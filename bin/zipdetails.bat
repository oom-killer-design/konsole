@rem = '--*-Perl-*--
@set "ErrorLevel="
@if "%OS%" == "Windows_NT" @goto WinNT
@perl -x -S "%0" %1 %2 %3 %4 %5 %6 %7 %8 %9
@set ErrorLevel=%ErrorLevel%
@goto endofperl
:WinNT
@perl -x -S %0 %*
@set ErrorLevel=%ErrorLevel%
@if NOT "%COMSPEC%" == "%SystemRoot%\system32\cmd.exe" @goto endofperl
@if %ErrorLevel% == 9009 @echo You do not have Perl in your PATH.
@goto endofperl
@rem ';
#!perl
#line 16
    eval 'exec C:\CraftRoot\bin\perl.exe -S $0 ${1+"$@"}'
	if 0; # ^ Run only under a shell
#!/usr/bin/perl

# zipdetails
#
# Display info on the contents of a Zip file
#

use 5.010; # for unpack "Q<"

BEGIN {
    # Check for a 32-bit Perl
    if (!eval { pack "Q", 1 }) {
        warn "zipdetails requires 64 bit integers, ",
                "this Perl has 32 bit integers.\n";
        exit(1);
    }
}

BEGIN { pop @INC if $INC[-1] eq '.' }
use strict;
use warnings ;
no  warnings 'portable'; # for unpacking > 2^32
use feature 'state';

use IO::File;
use Encode;
use Getopt::Long;

my $VERSION = "2.104" ;

use constant MAX32 => 0xFFFFFFFF ;

# Compression types
use constant ZIP_CM_STORE                      => 0 ;
use constant ZIP_CM_IMPLODE                    => 6 ;
use constant ZIP_CM_DEFLATE                    => 8 ;
use constant ZIP_CM_BZIP2                      => 12 ;
use constant ZIP_CM_LZMA                       => 14 ;
use constant ZIP_CM_PPMD                       => 98 ;

# General Purpose Flag
use constant ZIP_GP_FLAG_ENCRYPTED_MASK        => (1 << 0) ;
use constant ZIP_GP_FLAG_STREAMING_MASK        => (1 << 3) ;
use constant ZIP_GP_FLAG_PATCHED_MASK          => (1 << 5) ;
use constant ZIP_GP_FLAG_STRONG_ENCRYPTED_MASK => (1 << 6) ;
use constant ZIP_GP_FLAG_LZMA_EOS_PRESENT      => (1 << 1) ;
use constant ZIP_GP_FLAG_LANGUAGE_ENCODING     => (1 << 11) ;

# Internal File Attributes
use constant ZIP_IFA_TEXT_MASK                 => 1;

# Signatures for each of the headers
use constant ZIP_LOCAL_HDR_SIG                 => 0x04034b50;
use constant ZIP_DATA_HDR_SIG                  => 0x08074b50;
use constant ZIP_CENTRAL_HDR_SIG               => 0x02014b50;
use constant ZIP_END_CENTRAL_HDR_SIG           => 0x06054b50;
use constant ZIP64_END_CENTRAL_REC_HDR_SIG     => 0x06064b50;
use constant ZIP64_END_CENTRAL_LOC_HDR_SIG     => 0x07064b50;
use constant ZIP_ARCHIVE_EXTRA_DATA_SIG        => 0x08064b50;
use constant ZIP_DIGITAL_SIGNATURE_SIG         => 0x05054b50;

use constant ZIP_ARCHIVE_EXTRA_DATA_RECORD_SIG => 0x08064b50;

# Extra sizes
use constant ZIP_EXTRA_HEADER_SIZE          => 2 ;
use constant ZIP_EXTRA_MAX_SIZE             => 0xFFFF ;
use constant ZIP_EXTRA_SUBFIELD_ID_SIZE     => 2 ;
use constant ZIP_EXTRA_SUBFIELD_LEN_SIZE    => 2 ;
use constant ZIP_EXTRA_SUBFIELD_HEADER_SIZE => ZIP_EXTRA_SUBFIELD_ID_SIZE +
                                               ZIP_EXTRA_SUBFIELD_LEN_SIZE;
use constant ZIP_EXTRA_SUBFIELD_MAX_SIZE    => ZIP_EXTRA_MAX_SIZE -
                                               ZIP_EXTRA_SUBFIELD_HEADER_SIZE;

my %ZIP_CompressionMethods =
    (
          0 => 'Stored',
          1 => 'Shrunk',
          2 => 'Reduced compression factor 1',
          3 => 'Reduced compression factor 2',
          4 => 'Reduced compression factor 3',
          5 => 'Reduced compression factor 4',
          6 => 'Imploded',
          7 => 'Reserved for Tokenizing compression algorithm',
          8 => 'Deflated',
          9 => 'Enhanced Deflating using Deflate64(tm)',
         10 => 'PKWARE Data Compression Library Imploding',
         11 => 'Reserved by PKWARE',
         12 => 'BZIP2',
         13 => 'Reserved by PKWARE',
         14 => 'LZMA',
         15 => 'Reserved by PKWARE',
         16 => 'IBM z/OS CMPSC Compression',
         17 => 'Reserved by PKWARE',
         18 => 'File is compressed using IBM TERSE (new)',
         19 => 'IBM LZ77 z Architecture (PFS)',
         93 => 'Zstandard',
         94 => 'MP3',
         95 => 'XZ',
         96 => 'WinZip JPEG Compression',
         97 => 'WavPack compressed data',
         98 => 'PPMd version I, Rev 1',
         99 => 'AES Encryption',
     );

my %OS_Lookup = (
    0   => "MS-DOS",
    1   => "Amiga",
    2   => "OpenVMS",
    3   => "Unix",
    4   => "VM/CMS",
    5   => "Atari ST",
    6   => "HPFS (OS/2, NT 3.x)",
    7   => "Macintosh",
    8   => "Z-System",
    9   => "CP/M",
    10  => "Windows NTFS or TOPS-20",
    11  => "MVS or NTFS",
    12  => "VSE or SMS/QDOS",
    13  => "Acorn RISC OS",
    14  => "VFAT",
    15  => "alternate MVS",
    16  => "BeOS",
    17  => "Tandem",
    18  => "OS/400",
    19  => "OS/X (Darwin)",
    30  => "AtheOS/Syllable",
    );


my %Lookup = (
    ZIP_LOCAL_HDR_SIG,             \&LocalHeader,
    ZIP_DATA_HDR_SIG,              \&DataHeader,
    ZIP_CENTRAL_HDR_SIG,           \&CentralHeader,
    ZIP_END_CENTRAL_HDR_SIG,       \&EndCentralHeader,
    ZIP64_END_CENTRAL_REC_HDR_SIG, \&Zip64EndCentralHeader,
    ZIP64_END_CENTRAL_LOC_HDR_SIG, \&Zip64EndCentralLocator,

    # TODO - Archive Encryption Headers & digital signature
    #ZIP_ARCHIVE_EXTRA_DATA_RECORD_SIG
    #ZIP_DIGITAL_SIGNATURE_SIG
    #ZIP_ARCHIVE_EXTRA_DATA_SIG
);

my %Extras = (
      0x0001,  ['ZIP64', \&decode_Zip64],
      0x0007,  ['AV Info', undef],
      0x0008,  ['Extended Language Encoding', undef],
      0x0009,  ['OS/2 extended attributes', undef],
      0x000a,  ['NTFS FileTimes', \&decode_NTFS_Filetimes],
      0x000c,  ['OpenVMS', undef],
      0x000d,  ['Unix', undef],
      0x000e,  ['Stream & Fork Descriptors', undef],
      0x000f,  ['Patch Descriptor', undef],
      0x0014,  ['PKCS#7 Store for X.509 Certificates', undef],
      0x0015,  ['X.509 Certificate ID and Signature for individual file', undef],
      0x0016,  ['X.509 Certificate ID for Central Directory', undef],
      0x0017,  ['Strong Encryption Header', undef],
      0x0018,  ['Record Management Controls', undef],
      0x0019,  ['PKCS#7 Encryption Recipient Certificate List', undef],
      0x0020,  ['Reserved for Timestamp record', undef],
      0x0021,  ['Policy Decryption Key Record', undef],
      0x0022,  ['Smartcrypt Key Provider Record', undef],
      0x0023,  ['Smartcrypt Policy Key Data Record', undef],

      # The Header ID mappings defined by Info-ZIP and third parties are:

      0x0065,  ['IBM S/390 attributes - uncompressed', \&decodeMVS],
      0x0066,  ['IBM S/390 attributes - compressed', undef],
      0x07c8,  ['Info-ZIP Macintosh (old, J. Lee)', undef],
      0x2605,  ['ZipIt Macintosh (first version)', undef],
      0x2705,  ['ZipIt Macintosh v 1.3.5 and newer (w/o full filename)', undef],
      0x2805,  ['ZipIt Macintosh v 1.3.5 and newer', undef],
      0x334d,  ["Info-ZIP Macintosh (new, D. Haase's 'Mac3' field)", undef],
      0x4154,  ['Tandem NSK', undef],
      0x4341,  ['Acorn/SparkFS (David Pilling)', undef],
      0x4453,  ['Windows NT security descriptor', \&decode_NT_security],
      0x4690,  ['POSZIP 4690', undef],
      0x4704,  ['VM/CMS', undef],
      0x470f,  ['MVS', undef],
      0x4854,  ['Theos, old inofficial port', undef],
      0x4b46,  ['FWKCS MD5 (see below)', undef],
      0x4c41,  ['OS/2 access control list (text ACL)', undef],
      0x4d49,  ['Info-ZIP OpenVMS (obsolete)', undef],
      0x4d63,  ['Macintosh SmartZIP, by Macro Bambini', undef],
      0x4f4c,  ['Xceed original location extra field', undef],
      0x5356,  ['AOS/VS (binary ACL)', undef],
      0x5455,  ['Extended Timestamp', \&decode_UT],
      0x554e,  ['Xceed unicode extra field', \&decode_Xceed_unicode],
      0x5855,  ['Info-ZIP Unix (original; also OS/2, NT, etc.)', \&decode_UX],
      0x5a4c,  ['ZipArchive Unicode Filename', undef],
      0x5a4d,  ['ZipArchive Offsets Array', undef],
      0x6375,  ['Info-ZIP Unicode Comment', \&decode_up ],
      0x6542,  ['BeOS (BeBox, PowerMac, etc.)', undef],
      0x6854,  ['Theos', undef],
      0x7075,  ['Info-ZIP Unicode Path', \&decode_up ],
      0x756e,  ['ASi Unix', undef],
      0x7441,  ['AtheOS (AtheOS/Syllable attributes)', undef],
      0x7855,  ['Unix Extra type 2', \&decode_Ux],
      0x7875,  ['Unix Extra Type 3', \&decode_ux],
      0x9901,  ['AES Encryption', \&decode_AES],
      0xa11e,  ['Data Stream Alignment', \&decode_DataStreamAlignment],
      0xA220,  ['Open Packaging Growth Hint', \&decode_GrowthHint ],
      0xCAFE,  ['Java Executable', \&decode_Java_exe],
      0xfb4a,  ['SMS/QDOS', undef],

       );


my $FH;

my $ZIP64 = 0 ;
my $NIBBLES = 8;
my $LocalHeaderCount = 0;
my $CentralHeaderCount = 0;

my $START;
my $OFFSET = 0 ;
my $TRAILING = 0 ;
my $PAYLOADLIMIT = 256;
my $ZERO = 0 ;
my $APK = 0 ;
my $START_APK = 0;
my $APK_LEN = 0;

my $SEEN = Seen->new();

sub prOff
{
    my $offset = shift;
    my $s = offset($OFFSET);
    $OFFSET += $offset;
    return $s;
}

sub offset
{
    my $v = shift ;

    sprintf("%0${NIBBLES}X", $v);
}

my ($OFF,  $LENGTH,  $CONTENT, $TEXT, $VALUE) ;

my $FMT1 ;
my $FMT2 ;

sub setupFormat
{
    my $wantVerbose = shift ;
    my $nibbles = shift;

    my $width = '@' . ('>' x ($nibbles -1));
    my $space = " " x length($width);

    my $fmt ;

    if ($wantVerbose) {

        $FMT1 = "
        format STDOUT =
$width $width ^<<<<<<<<<<<^<<<<<<<<<<<<<<<<<<<< ^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
\$OFF,     \$LENGTH,  \$CONTENT, \$TEXT,               \$VALUE
$space $space ^<<<<<<<<<<<^<<<<<<<<<<<<<<<<<<<< ^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<~~
                    \$CONTENT, \$TEXT,               \$VALUE
.
";

        $FMT2 = "
        format STDOUT =
$width $width ^<<<<<<<<<<<  ^<<<<<<<<<<<<<<<<<< ^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
\$OFF,     \$LENGTH,  \$CONTENT, \$TEXT,               \$VALUE
$space $space ^<<<<<<<<<<<  ^<<<<<<<<<<<<<<<<<< ^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<~~
              \$CONTENT, \$TEXT,               \$VALUE
.  " ;

    }
    else {

        $FMT1 = "
        format STDOUT =
$width ^<<<<<<<<<<<<<<<<<<<< ^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
\$OFF,      \$TEXT,               \$VALUE
$space ^<<<<<<<<<<<<<<<<<<<< ^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<~~
                    \$TEXT,               \$VALUE
.
";

        $FMT2 = "
    format STDOUT =
$width   ^<<<<<<<<<<<<<<<<<< ^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
\$OFF,     \$TEXT,               \$VALUE
$space   ^<<<<<<<<<<<<<<<<<< ^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<~~
                    \$TEXT,               \$VALUE
.
" ;
    }

    eval "$FMT1";

    $| = 1;

}

sub mySpr
{
    my $format = shift ;

    return "" if ! defined $format;
    return $format unless @_ ;
    return sprintf $format, @_ ;
}

sub out0
{
    my $size = shift;
    my $text = shift;
    my $format = shift;

    $OFF     = prOff($size);
    $LENGTH  = offset($size) ;
    $CONTENT = '...';
    $TEXT    = $text;
    $VALUE   = mySpr $format,  @_;

    write;

    skip($FH, $size);
}

sub xDump
{
    my $input = shift;

    $input =~ tr/\0-\37\177-\377/./;
    return $input;
}

sub hexDump
{
    my $input = shift;

    my $out = unpack('H*', $input) ;
    $out =~ s#(..)# $1#g ;
    $out =~ s/^ //;
    $out = uc $out;

    return $out;
}

sub hexValue
{
    return sprintf("%X", $_[0]);
}

sub out
{
    my $data = shift;
    my $text = shift;
    my $format = shift;

    my $size = length($data) ;

    $OFF     = prOff($size);
    $LENGTH  = offset($size) ;
    $CONTENT = hexDump($data);
    $TEXT    = $text;
    $VALUE   = mySpr $format,  @_;

    no warnings;

    write;
}

sub out1
{
    my $text = shift;
    my $format = shift;

    $OFF     = '';
    $LENGTH  = '' ;
    $CONTENT = '';
    $TEXT    = $text;
    $VALUE   = mySpr $format,  @_;

    write;
}

sub out2
{
    my $data = shift ;
    my $text = shift ;
    my $format = shift;

    my $size = length($data) ;
    $OFF     = prOff($size);
    $LENGTH  = offset($size);
    $CONTENT = hexDump($data);
    $TEXT    = $text;
    $VALUE   = mySpr $format,  @_;

    no warnings;
    eval "$FMT2";
    write ;
    eval "$FMT1";
}

sub Value
{
    my $letter = shift;
    my @value = @_;

    if ($letter eq 'C')
      { return Value_C(@value) }
    elsif ($letter eq 'v')
      { return Value_v(@value) }
    elsif ($letter eq 'V')
      { return Value_V(@value) }
    elsif ($letter eq 'Q<')
      { return Value_Q(@value) }
    else
      { die "here letter $letter"}
}

sub outer
{
    my $name = shift ;
    my $unpack = shift ;
    my $size = shift ;
    my $cb1  = shift ;
    my $cb2  = shift ;


    myRead(my $buff, $size);
    my (@value) = unpack $unpack, $buff;
    my $hex = Value($unpack,  @value);

    if (defined $cb1) {
        my $v ;
        if (ref $cb1 eq 'CODE') {
            $v = $cb1->(@value) ;
        }
        else {
            $v = $cb1 ;
        }

        $v = "'" . $v unless $v =~ /^'/;
        $v .= "'"     unless $v =~ /'$/;
        $hex .= " $v" ;
    }

    out $buff, $name, $hex ;

    $cb2->(@value)
        if defined $cb2 ;

    return $value[0];
}

sub out_C
{
    my $name = shift ;
    my $cb1  = shift ;
    my $cb2  = shift ;

    outer($name, 'C', 1, $cb1, $cb2);
}

sub out_v
{
    my $name = shift ;
    my $cb1  = shift ;
    my $cb2  = shift ;

    outer($name, 'v', 2, $cb1, $cb2);
}

sub out_V
{
    my $name = shift ;
    my $cb1  = shift ;
    my $cb2  = shift ;

    outer($name, 'V', 4, $cb1, $cb2);
}

sub out_Q
{
    my $name = shift ;
    my $cb1  = shift ;
    my $cb2  = shift ;

    outer($name, 'Q<', 8, $cb1, $cb2);
}

sub outSomeData
{
    my $size = shift;
    my $message = shift;
    my $redact = shift ;

    if ($size > 0) {
        if ($size > $PAYLOADLIMIT) {
            my $before = $FH->tell();
            out0 $size, $message;
        } else {
            myRead(my $buffer, $size );
            $buffer = "X" x $size
                if $redact;
            out $buffer, $message, xDump $buffer ;
        }
    }
}

sub unpackValue_C
{
    Value_v(unpack "C", $_[0]);
}

sub Value_C
{
    sprintf "%02X", $_[0];
}


sub unpackValue_v
{
    Value_v(unpack "v", $_[0]);
}

sub Value_v
{
    sprintf "%04X", $_[0];
}

sub unpackValue_V
{
    Value_V(unpack "V", $_[0]);
}

sub Value_V
{
    my $v = defined $_[0] ? $_[0] : 0;
    sprintf "%08X", $v;
}

sub unpackValue_Q
{
    my $v = unpack ("Q<", $_[0]);
    Value_Q($v);
}

sub Value_Q
{
    my $v = shift ;
    sprintf "%016X", $v;
}

sub read_Q
{
    my $b ;
    myRead($b, 8);
    return ($b, unpack ("Q<" , $b));
}

sub read_V
{
    my $b ;
    myRead($b, 4);
    return ($b, unpack ("V", $b));
}

sub read_v
{
    my $b ;
    myRead($b, 2);
    return ($b, unpack "v", $b);
}


sub read_C
{
    my $b ;
    myRead($b, 1);
    return ($b, unpack "C", $b);
}

sub seekTo
{
    my $offset = shift ;
    my $loc = shift ;

    $loc = SEEK_SET
        if ! defined $loc ;

    $FH->seek($offset, $loc);
    $OFFSET = $FH->tell();
}

sub scanForSignature
{
    my %sigs =
        map { $_ => 1         }
        map { substr $_, 2, 2 } # don't want the initial "PK"
        map { pack "V", $_    }
        (
                ZIP_LOCAL_HDR_SIG                 ,
                ZIP_DATA_HDR_SIG                  ,
                ZIP_CENTRAL_HDR_SIG               ,
                ZIP_END_CENTRAL_HDR_SIG           ,
                ZIP64_END_CENTRAL_REC_HDR_SIG     ,
                ZIP64_END_CENTRAL_LOC_HDR_SIG     ,
                # ZIP_ARCHIVE_EXTRA_DATA_SIG        ,
                # ZIP_DIGITAL_SIGNATURE_SIG         ,
                # ZIP_ARCHIVE_EXTRA_DATA_RECORD_SIG ,
        );

    my $start = $FH->tell();

    my $last = '';
    my $offset = 0;
    my $buffer ;
    BUFFER:
    while ($FH->read($buffer, 1024 * 1000))
    {
        my $combine = $last . $buffer ;

        my $ix = 0;
        while (1)
        {
            $ix = index($combine, "PK", $ix) ;

            if ($ix == -1)
            {
                $last = '';
                next BUFFER;
            }

            my $rest = substr($combine, $ix + 2, 2);

            if (! $sigs{$rest})
            {
                $ix += 2;
                next;
            }

            # possible match
            my $here = $FH->tell();
            seekTo($here - length($combine) + $ix);

            return 1;
        }

        $last = substr($combine, $ix+4);
    }

    return 0;
}

my $is64In32 = 0;

my $opt_verbose = 0;
my $opt_scan = 0;
my $opt_Redact = 0;
my $opt_utc = 0;


$Getopt::Long::bundling = 1 ;

GetOptions("h"       => \&Usage,
           "v"       => \$opt_verbose,
           "scan"    => \$opt_scan,
           "redact"  => \$opt_Redact,
           "utc"     => \$opt_utc,
           "version" => sub { print "$VERSION\n"; exit },
    )
  or Usage("Invalid command line option\n");


Usage("No zipfile") unless @ARGV == 1;

my $filename = shift @ARGV;

die "$filename does not exist\n"
    unless -e $filename ;

die "$filename not a standard file\n"
    unless -f $filename ;

$FH = IO::File->new( "<$filename" )
    or die "Cannot open $filename: $!\n";


my $FILELEN = -s $filename ;
$TRAILING = -s $filename ;
$NIBBLES = nibbles(-s $filename) ;

die "$filename too short to be a zip file\n"
    if $FILELEN <  22 ;

setupFormat($opt_verbose, $NIBBLES);

if(0)
{
    # Sanity check that this is a Zip file
    my ($buffer, $signature) = read_V();

    warn "$filename doesn't look like a zip file\n"
        if $signature != ZIP_LOCAL_HDR_SIG ;
    $FH->seek(0, SEEK_SET) ;
}

my @Messages = ();

if ($opt_scan)
{
    my $foundCentralHeader = 0;
    my $lastEndsAt = 0;

    while(scanForSignature())
    {
        my $here = $FH->tell();

        my ($buffer, $signature) = read_V();

        # check for an APK header directly before the first central header
        if ($signature == ZIP_CENTRAL_HDR_SIG && $foundCentralHeader == 0)
        {
            $foundCentralHeader = 1;

            ($START_APK, $APK, $APK_LEN) = chckForAPKSigningBlock($FH, $here) ;

            if ($START_APK)
            {
                seekTo($lastEndsAt+4);

                scanApkBlock();
                seekTo($here);
                next;
            }

            seekTo($here + 4);
        }

        my $handler = $Lookup{$signature};
        $handler->($signature, $buffer);

        $lastEndsAt = $FH->tell();

        seekTo($here + 4) ;
    }

    dislayMessages();
    exit;

}

our ($CdExists, $CdOffset, @CentralDirectory) = scanCentralDirectory($FH);

die "No Central Directory records found\n"
    if ! $CdExists ;

$OFFSET = 0 ;
$FH->seek(0, SEEK_SET) ;

outSomeData($START, "PREFIX DATA")
    if defined $START && $START > 0 ;

my $skippedFrom = 0 ;
my $skippedContent = 0 ;

while (1)
{
    last if $FH->eof();

    my $here = $FH->tell();
    if ($here >= $TRAILING) {
        print "\n" ;
        outSomeData($FILELEN - $TRAILING, "TRAILING DATA");
        last;

    }

    my ($buffer, $signature) = read_V();

    my $handler = $Lookup{$signature};

    if (!defined $handler)
    {
        if (@CentralDirectory) {
            # Should be at offset that central directory says
            my $locOffset = $CentralDirectory[0][0];
            my $delta = $locOffset - $here ;

            if ($here + 4 == $locOffset ) {
                for (0 .. 3) {
                    $FH->ungetc(ord(substr($buffer, $_, 1)))
                }
                outSomeData($delta, "UNEXPECTED PADDING");
                next;
            }
        }


        if ($here < $CdOffset)
        {
            if ($APK)
            {
                scanApkBlock();
                next;
            }

            # next
            #     if scanForSignature() ;

            $skippedFrom = $FH->tell() ;
            $skippedContent = $CdOffset - $skippedFrom ;

            printf "\nWARNING!\nZip local header not found at offset 0x%X\n", $skippedFrom;
            printf "Skipping 0x%x bytes to Central Directory...\n", $skippedContent;

            push @Messages,
                sprintf("Expected Zip header not found at offset 0x%X, ", $skippedFrom) .
                sprintf("skipped 0x%X bytes\n", $skippedContent);

            seekTo($CdOffset);

            next;
        }
        else
        {
            printf "\n\nUnexpected END at offset %08X, value %s\n", $here, Value_V($signature);

            last;
        }
    }

    $ZIP64 = 0 if $signature != ZIP_DATA_HDR_SIG ;
    $handler->($signature, $buffer);
}


dislayMessages();

exit ;

sub dislayMessages
{
    $SEEN->short_summary();

    $SEEN->summary();


    if (@Messages)
    {
        my $count = scalar @Messages ;
        print "\nWARNINGS\n\n";
        print "* $_\n" for @Messages ;
    }

    print "Done\n";
}

sub compressionMethod
{
    my $id = shift ;
    Value_v($id) . " '" . ($ZIP_CompressionMethods{$id} || "Unknown Method") . "'" ;
}

sub LocalHeader
{
    my $signature = shift ;
    my $data = shift ;

    my $from_offset = $FH->tell() - 4;

    print "\n";
    ++ $LocalHeaderCount;
    my $hexHdrCount = sprintf("%X", $LocalHeaderCount) ;
    out $data, "LOCAL HEADER #$hexHdrCount" , Value_V($signature);

    my $buffer;

    my ($loc, $CDcompressedLength, $cdZip64, $zip64Sizes, $cdIndex, $cdEntryOffset) ;
    if (! $opt_scan)
    {
        ($loc, $CDcompressedLength, $cdZip64, $zip64Sizes, $cdIndex, $cdEntryOffset) = @{ shift @CentralDirectory } ;
        # my $cdi = sprintf("%X", $cdIndex) ;
        # out1 "CENTRAL HEADER #$cdi", sprintf "Offset %s\n", Value_Q($cdEntryOffset);
    }

    out_C  "Extract Zip Spec", \&decodeZipVer;
    out_C  "Extract OS", \&decodeOS;

    my ($bgp, $gpFlag) = read_v();
    my ($bcm, $compressedMethod) = read_v();

    out $bgp, "General Purpose Flag", Value_v($gpFlag) ;
    GeneralPurposeBits($compressedMethod, $gpFlag);

    out $bcm, "Compression Method",   compressionMethod($compressedMethod) ;

    out_V "Last Mod Time", sub { getTime(_dosToUnixTime($_[0])) };

    my $crc                = out_V "CRC";
    my $compressedLength   = out_V "Compressed Length";
    my $uncompressedLength = out_V "Uncompressed Length";
    my $filenameLength     = out_v "Filename Length";
    my $extraLength        = out_v "Extra Length";

    my $filename ;
    myRead($filename, $filenameLength);
    outputFilename($filename);

    my $cl64 = $compressedLength;
    my %ExtraContext = ();
    if ($extraLength)
    {
        my @z64 = ($uncompressedLength, $compressedLength, 1, 1);
        $ExtraContext{Zip64} = \@z64 ;
        $ExtraContext{InCentralDir} = 0;
        walkExtra($extraLength, \%ExtraContext);
    }


    my @msg ;
    # if ($cdZip64 && ! $ZIP64)
    # {
    #     # Central directory said this was Zip64
    #     # some zip files don't have the Zip64 field in the local header
    #     # seems to be a streaming issue.
    #     push @msg, "Missing Zip64 extra field in Local Header #$hexHdrCount\n";

    #     if (! $zip64Sizes)
    #     {
    #         # Central has a ZIP64 entry that doesn't have sizes
    #         # Local doesn't have a Zip 64 at all
    #         push @msg, "Unzip may complain about 'overlapped components' #$hexHdrCount\n";
    #     }
    #     else
    #     {
    #         $ZIP64 = 1
    #     }
    # }



    my $size = 0;
    $size = printAes(\%ExtraContext)
        if $compressedMethod == 99 ;

    $size += printLzmaProperties()
        if $compressedMethod == ZIP_CM_LZMA ;

    $CDcompressedLength = $compressedLength
        if $opt_scan ;

    $CDcompressedLength -= $size;

    if ($CDcompressedLength) {
        outSomeData($CDcompressedLength, "PAYLOAD", $opt_Redact) ;
    }

    if ($compressedMethod == 99) {
        my $auth ;
        myRead($auth, 10);
        out $auth, "AES Auth",  hexDump($auth);
    }

    print "WARNING: $_"
        for @msg;

    push @Messages, @msg ;


    # $SEEN->save("LOCAL HEADER #" . sprintf("%X", $LocalHeaderCount), $filename, $from_offset, $from_offset + $CDcompressedLength);
}

sub redactFilename
{
    my $filename = shift;

    # Redact everything apart from directory seperators
    $filename =~ s([^/])(X)g
        if $opt_Redact;

    return $filename;
}

sub outputFilename
{
    my $filename = shift;

    $filename = redactFilename($filename) ;

    if (length $filename > 256)
    {
        my $f = substr($filename, 0, 256) ;
        out $f, "Filename",  "'". $f . "' ...";
    }
    else
    {
        out $filename, "Filename",  "'". $filename . "'";
    }
}

sub CentralHeader
{
    my $signature = shift ;
    my $data = shift ;

    my $from_offset = $FH->tell() - 4;

    ++ $CentralHeaderCount;
    print "\n";
    out $data, "CENTRAL HEADER #" . sprintf("%X", $CentralHeaderCount) . "", Value_V($signature);
    my $buffer;

    out_C "Created Zip Spec", \&decodeZipVer;
    out_C "Created OS", \&decodeOS;
    out_C "Extract Zip Spec", \&decodeZipVer;
    out_C "Extract OS", \&decodeOS;

    my ($bgp, $gpFlag) = read_v();
    my ($bcm, $compressedMethod) = read_v();

    out $bgp, "General Purpose Flag", Value_v($gpFlag) ;
    GeneralPurposeBits($compressedMethod, $gpFlag);

    out $bcm, "Compression Method", compressionMethod($compressedMethod) ;

    out_V "Last Mod Time", sub { getTime(_dosToUnixTime($_[0])) };

    my $crc                = out_V "CRC";
    my $compressedLength   = out_V "Compressed Length";
    my $uncompressedLength = out_V "Uncompressed Length";
    my $filenameLength     = out_v "Filename Length";
    my $extraLength        = out_v "Extra Length";
    my $comment_length     = out_v "Comment Length";
    my $disk_start         = out_v "Disk Start";
    my $int_file_attrib    = out_v "Int File Attributes";

    out1 "[Bit 0]",  $int_file_attrib & 1 ? "1 Text Data" : "0 'Binary Data'";

    my $ext_file_attrib    = out_V "Ext File Attributes";
    out1 "[Bit 0]",  "Read-Only"
        if $ext_file_attrib & 0x01 ;
    out1 "[Bit 1]",  "Hidden"
        if $ext_file_attrib & 0x02 ;
    out1 "[Bit 2]",  "System"
        if $ext_file_attrib & 0x04 ;
    out1 "[Bit 3]",  "Label"
        if $ext_file_attrib & 0x08 ;
    out1 "[Bit 4]",  "Directory"
        if $ext_file_attrib & 0x10 ;
    out1 "[Bit 5]",  "Archive"
        if $ext_file_attrib & 0x20 ;

    my $lcl_hdr_offset     = out_V "Local Header Offset";

    my $filename ;
    myRead($filename, $filenameLength);
    outputFilename($filename);


    my %ExtraContext = ( CRC => $crc,
                         LocalHdrOffset   => $lcl_hdr_offset,
                         CompressedLength => $compressedLength);

    if ($extraLength)
    {
        my @z64 = ($uncompressedLength, $compressedLength, $lcl_hdr_offset, $disk_start);
        $ExtraContext{Zip64} = \@z64 ;
        $ExtraContext{InCentralDir} = 1;
        walkExtra($extraLength, \%ExtraContext);
    }

    if ($comment_length)
    {
        my $comment ;
        myRead($comment, $comment_length);
        out $comment, "Comment",  "'". $comment . "'";
    }


    $SEEN->save("CENTRAL HEADER ref Local #" . sprintf("%X", $CentralHeaderCount), $filename, \%ExtraContext) ;
}

sub decodeZipVer
{
    my $ver = shift ;

    my $sHi = int($ver /10) ;
    my $sLo = $ver % 10 ;

    #out1 "Zip Spec", "$sHi.$sLo";
    "$sHi.$sLo";
}

sub decodeOS
{
    my $ver = shift ;

    $OS_Lookup{$ver} || "Unknown" ;
}

sub Zip64EndCentralHeader
{
    my $signature = shift ;
    my $data = shift ;

    print "\n";
    out $data, "ZIP64 END CENTRAL DIR RECORD", Value_V($signature);

    my $buff;
    myRead($buff, 8);

    out $buff, "Size of record", unpackValue_Q($buff);

    my $size  = unpack "Q<", $buff;

    out_C  "Created Zip Spec", \&decodeZipVer;
    out_C  "Created OS", \&decodeOS;
    out_C  "Extract Zip Spec", \&decodeZipVer;
    out_C  "Extract OS", \&decodeOS;
    out_V  "Number of this disk";
    out_V  "Central Dir Disk no";
    out_Q  "Entries in this disk";
    out_Q  "Total Entries";
    out_Q  "Size of Central Dir";
    out_Q  "Offset to Central dir";

    # TODO -
    if ($size != 44)
    {
        push @Messages,  "Unsupported Size field in Zip64EndCentralHeader: should be 44, got $size\n"
    }
}


sub Zip64EndCentralLocator
{
    my $signature = shift ;
    my $data = shift ;

    print "\n";
    out $data, "ZIP64 END CENTRAL DIR LOCATOR", Value_V($signature);

    out_V  "Central Dir Disk no";
    out_Q  "Offset to Central dir";
    out_V  "Total no of Disks";
}

sub EndCentralHeader
{
    my $signature = shift ;
    my $data = shift ;

    print "\n";
    out $data, "END CENTRAL HEADER", Value_V($signature);

    out_v "Number of this disk";
    out_v "Central Dir Disk no";
    out_v "Entries in this disk";
    out_v "Total Entries";
    out_V "Size of Central Dir";
    out_V "Offset to Central Dir";
    my $comment_length = out_v "Comment Length";

    if ($comment_length)
    {
        my $comment ;
        myRead($comment, $comment_length);
        out $comment, "Comment", "'$comment'";
    }
}

sub DataHeader
{
    my $signature = shift ;
    my $data = shift ;

    print "\n";
    out $data, "STREAMING DATA HEADER", Value_V($signature);

    out_V "CRC";

    if ($ZIP64)
    {
        out_Q "Compressed Length" ;
        out_Q "Uncompressed Length" ;
    }
    else
    {
        out_V "Compressed Length" ;
        out_V "Uncompressed Length" ;
    }
}


sub GeneralPurposeBits
{
    my $method = shift;
    my $gp = shift;

    out1 "[Bit  0]", "1 'Encryption'" if $gp & ZIP_GP_FLAG_ENCRYPTED_MASK;

    my %lookup = (
        0 =>    "Normal Compression",
        1 =>    "Maximum Compression",
        2 =>    "Fast Compression",
        3 =>    "Super Fast Compression");


    if ($method == ZIP_CM_DEFLATE)
    {
        my $mid = ($gp >> 1) & 0x03 ;

        out1 "[Bits 1-2]", "$mid '$lookup{$mid}'";
    }

    if ($method == ZIP_CM_LZMA)
    {
        if ($gp & ZIP_GP_FLAG_LZMA_EOS_PRESENT) {
            out1 "[Bit 1]", "1 'LZMA EOS Marker Present'" ;
        }
        else {
            out1 "[Bit 1]", "0 'LZMA EOS Marker Not Present'" ;
        }
    }

    if ($method == ZIP_CM_IMPLODE) # Imploding
    {
        out1 "[Bit 1]", ($gp & (1 << 1) ? "1 '8k" : "0 '4k") . " Sliding Dictionary'" ;
        out1 "[Bit 2]", ($gp & (2 << 1) ? "1 '3" : "0 '2"  ) . " Shannon-Fano Trees'" ;
    }

    out1 "[Bit  3]", "1 'Streamed'"           if $gp & ZIP_GP_FLAG_STREAMING_MASK;
    out1 "[Bit  4]", "1 'Enhanced Deflating'" if $gp & 1 << 4;
    out1 "[Bit  5]", "1 'Compressed Patched'" if $gp & 1 << 5 ;
    out1 "[Bit  6]", "1 'Strong Encryption'"  if $gp & ZIP_GP_FLAG_STRONG_ENCRYPTED_MASK;
    out1 "[Bit 11]", "1 'Language Encoding'"  if $gp & ZIP_GP_FLAG_LANGUAGE_ENCODING;
    out1 "[Bit 12]", "1 'Pkware Enhanced Compression'"  if $gp & 1 <<12 ;
    out1 "[Bit 13]", "1 'Encrypted Central Dir'"  if $gp & 1 <<13 ;

    return ();
}


sub seekSet
{
    my $fh = $_[0] ;
    my $size = $_[1];

    use Fcntl qw(SEEK_SET);
    seek($fh, $size, SEEK_SET);

}

sub skip
{
    my $fh = $_[0] ;
    my $size = $_[1];

    use Fcntl qw(SEEK_CUR);
    seek($fh, $size, SEEK_CUR);

}


sub myRead
{
    my $got = \$_[0] ;
    my $size = $_[1];

    my $wantSize = $size;
    $$got = '';

    if ($size == 0)
    {
        return ;
    }

    if ($size > 0)
    {
        my $buff ;
        my $status = $FH->read($buff, $size);
        return $status
            if $status < 0;
        $$got .= $buff ;
    }

    my $len = length $$got;
    die "Truncated file (got $len, wanted $wantSize): $!\n"
        if length $$got != $wantSize;
}




sub walkExtra
{
    my $XLEN = shift;
    my $context = shift;

    my $buff ;
    my $offset = 0 ;

    my $id;
    my $subLen;
    my $payload ;

    my $count = 0 ;

    while ($offset < $XLEN) {

        ++ $count;

        # Detect if there is not enough data for an extra ID and length.
        # Android zipalign and zipflinger are prime candidates for these
        # non-standard extra sub-fields.
        my $remaining = $XLEN - $offset;
        if ($remaining < ZIP_EXTRA_SUBFIELD_HEADER_SIZE) {
            # There is not enough left.
            # Consume whatever is there and return so parsing
            # can continue.
            myRead($payload, $remaining);
            my $data = hexDump($payload);

            if ($payload =~ /^\x00+$/)
            {
                out $payload, "Null Padding in Extra";
            }
            else
            {
                out $payload, "Malformed Extra Data", $data;
            }

            return undef;
        }

        myRead($id, ZIP_EXTRA_SUBFIELD_ID_SIZE);
        $offset += ZIP_EXTRA_SUBFIELD_ID_SIZE;
        my $lookID = unpack "v", $id ;
        if ($lookID == 0)
        {
            # check for null padding at end of extra
            my $here = $FH->tell();
            my $rest;
            myRead($rest, $XLEN - $offset);
            if ($rest =~ /^\x00+$/)
            {
                out $id . $rest, "Null Padding in Extra";
                return undef;
            }

            seekTo($here);
        }

        my ($who, $decoder) =  @{ $Extras{$lookID} // ['', undef ] };

        $who = "$id: $who"
            if $id =~ /\w\w/ ;

        $who = "'$who'";
        out $id, "Extra ID #" . Value_v($count), unpackValue_v($id) . " $who" ;

        myRead($buff, ZIP_EXTRA_SUBFIELD_LEN_SIZE);
        $offset += ZIP_EXTRA_SUBFIELD_LEN_SIZE;

        $subLen =  unpack("v", $buff);
        out2 $buff, "Length", Value_v($subLen) ;

        return undef
            if $offset + $subLen > $XLEN ;

        if (! defined $decoder)
        {
            if ($subLen)
            {
                myRead($payload, $subLen);
                my $data = hexDump($payload);

                out2 $payload, "Extra Payload", $data;
            }
        }
        else
        {
            $decoder->($subLen, $context) ;
        }

        $offset += $subLen ;
    }

    return undef ;
}


sub full32
{
    return $_[0] == MAX32 ;
}

sub decode_Zip64
{
    my $len = shift;
    my $context = shift;

    my $z64Data = $context->{Zip64};
    my $inCentralHdr = $context->{InCentralDir} ;
    my $inLocalHdr = ! $inCentralHdr ;

    $ZIP64 = 1;

    if ($inLocalHdr || full32 $z64Data->[0]) {
        out_Q "  Uncompressed Size";
    }

    if ($inLocalHdr || full32 $z64Data->[1]) {
        $context->{CompressedLength} = out_Q "  Compressed Size";
    }

    if (full32 $z64Data->[2] ) {
        $context->{LocalHdrOffset} = out_Q "  Offset to Local Dir";
    }

    if ($z64Data->[3] == 0xFFFF ) {
        out_V "  Disk Number";
    }
}

sub Ntfs2Unix
{
    my $m = shift;
    my $v = shift;

    # NTFS offset is 19DB1DED53E8000

    my $hex = Value_Q($v) ;
    $v -= 0x19DB1DED53E8000 ;
    my $ns = ($v % 10000000) * 100;
    my $elapse = int ($v/10000000);
    return "$hex '" . getT($elapse) .
           " " . sprintf("%0dns'", $ns);
}

sub decode_NTFS_Filetimes
{
    my $len = shift;
    my $context = shift;

    out_V "  Reserved";
    out_v "  Tag1";
    out_v "  Size1" ;

    my ($m, $s1) = read_Q;
    out $m, "  Mtime", Ntfs2Unix($m, $s1);

    my ($a, $s3) = read_Q;
    out $m, "  Atime", Ntfs2Unix($m, $s3);

    my ($c, $s2) = read_Q;
    out $c, "  Ctime", Ntfs2Unix($m, $s2);
}

sub getT
{
    my $time = shift ;

    if ($opt_utc)
     { return scalar gmtime($time) }
    else
     { return scalar localtime($time) }
}

sub getTime
{
    my $time = shift ;

    return "'" . getT($time) . "'";
}

sub decode_UT
{
    my $len = shift;
    my $context = shift;

    my ($data, $flags) = read_C();

    my $f = Value_C $flags;
    $f .= " mod"    if $flags & 1;
    $f .= " access" if $flags & 2;
    $f .= " change" if $flags & 4;

    out $data, "  Flags", "'$f'";

    -- $len;

    if ($flags & 1)
    {
        my ($data, $time) = read_V();

        out2 $data, "Mod Time",    Value_V($time) . " " . getTime($time) ;

        $len -= 4 ;
    }


      if ($flags & 2 && $len > 0 )
      {
          my ($data, $time) = read_V();

          out2 $data, "Access Time",    Value_V($time) . " " . getTime($time) ;
          $len -= 4 ;
      }

      if ($flags & 4 && $len > 0)
      {
          my ($data, $time) = read_V();

          out2 $data, "Change Time",    Value_V($time) . " " . getTime($time) ;
      }
}



sub decode_AES
{
    # ref https://www.winzip.com/win/es/aes_info.html

    my $len = shift;
    my $context = shift;

    return if $len == 0 ;

    my %lookup = ( 1 => "AE-1", 2 => "AE-2");
    out_v "  Vendor Version", sub {  $lookup{$_[0]} || "Unknown"  } ;

    my $id ;
    myRead($id, 2);
    out $id, "  Vendor ID", unpackValue_v($id) . " '$id'";

    my %strengths = (1 => "128-bit encryption key",
                     2 => "192-bit encryption key",
                     3 => "256-bit encryption key",
                    );

    my $strength = out_C "  Encryption Strength", sub {$strengths{$_[0]} || "Unknown" } ;

    my ($bmethod, $method) = read_v();
    out $bmethod, "  Compression Method", compressionMethod($method) ;

    $context->{AesStrength} = $strength ;
}

sub decode_GrowthHint
{
    my $len = shift;
    my $context = shift;
    my $inCentralHdr = $context->{InCentralDir} ;

    return if $len == 0 ;

    out_v "  Signature" ;
    out_v "  Initial Value";

    my $padding;
    myRead($padding, $len - 4);
    my $data = hexDump($padding);

    out2 $padding, "Padding", $data;
}

sub decode_DataStreamAlignment
{
    my $len = shift;
    my $context = shift;
    my $inCentralHdr = $context->{InCentralDir} ;

    return if $len == 0 ;

    my ($data, $alignment) = read_v();

    out $data, "  Alignment", Value_v($alignment) ;

    my $recompress_value = $alignment & 0x8000 ? 1 : 0;

    my $recompressing = $recompress_value ? "True" : "False";
    $alignment &= 0x7FFF ;
    my $hexAl =  sprintf("%X", $alignment);

    out1 "  [Bit   15]",  "$recompress_value    'Recompress $recompressing'";
    out1 "  [Bits 0-14]", "$hexAl 'Minimal Alignment $alignment'";

    if (! $inCentralHdr && $len - 2 > 0)
    {
        my $padding;
        myRead($padding, $len - 2);

        out2 $padding, "Padding", hexDump($padding);
    }
}


sub decode_UX
{
    my $len = shift;
    my $context = shift;
    my $inCentralHdr = $context->{InCentralDir} ;

    return if $len == 0 ;

    my ($data, $time) = read_V();
    out2 $data, "Access Time",    Value_V($time) . " " . getTime($time) ;

    ($data, $time) = read_V();
    out2 $data, "Mod Time",    Value_V($time) . " " . getTime($time) ;

    if (! $inCentralHdr ) {
        out_v "  UID" ;
        out_v "  GID";
    }
}

sub decode_Ux
{
    my $len = shift;
    my $context = shift;

    return if $len == 0 ;
    out_v "  UID" ;
    out_v "  GID";
}

sub decodeLitteEndian
{
    my $value = shift ;

    if (length $value == 4)
    {
        return Value_V unpack ("V", $value)
    }
    else {
        # TODO - fix this
        die "unsupported\n";
    }

    my $got = 0 ;
    my $shift = 0;

    #hexDump
    #reverse
    #my @a =unpack "C*", $value;
    #@a = reverse @a;
    #hexDump(@a);

    for (reverse unpack "C*", $value)
    {
        $got = ($got << 8) + $_ ;
    }

    return $got ;
}

sub decode_ux
{
    my $len = shift;
    my $context = shift;

    return if $len == 0 ;
    out_C "  Version" ;
    my $uidSize = out_C "  UID Size";
    myRead(my $data, $uidSize);
    out2 $data, "UID", decodeLitteEndian($data);

    my $gidSize = out_C "  GID Size";
    myRead($data, $gidSize);
    out2 $data, "GID", decodeLitteEndian($data);

}

sub decode_Java_exe
{
    my $len = shift;
    my $context = shift;

}

sub decode_up
{
    my $len = shift;
    my $context = shift;


    out_C "  Version";
    out_V "  NameCRC32";

    myRead(my $data, $len - 5);

    out $data, "  UnicodeName", $data;
}

sub decode_Xceed_unicode
{
    my $len = shift;
    my $context = shift;

    my $data ;

    # No public definition available, so guess the fields used for this one
    # Data analysis based on output from Fiddler (https://www.telerik.com/fiddler),
    # which uses this field

    # First 4 bytes appear to be "NUCX" all the time
    myRead($data, 4);
    out $data, "  ID", $data;

    # Next 2 bytes contains a count of the remaining bytes/2
    # Probably the number of UTF-16 characters, including the
    # optional NULL prefix
    out_v "  Length";

    # next is a UTF16 encode filename
    # sometimes preceeded by a two Null bytes

    myRead($data, $len - 6);

    my $prefix = substr($data, 0, 2);
    if ($prefix eq "\x00\x00")
    {
        # Found the Null prefix
        out $prefix, "  Null", '0000';
        substr($data, 0, 2) = '';
    }

    out $data, "  UTF16LE Name", decode("UTF16LE", $data);
}


sub decode_NT_security
{
    my $len = shift;
    my $context = shift;
    my $inCentralHdr = $context->{InCentralDir} ;

    out_V "  Uncompressed Size" ;

    if (! $inCentralHdr) {

        out_C "  Version" ;

        out_v "  Type";

        out_V "  NameCRC32" ;

        my $plen = $len - 4 - 1 - 2 - 4;
        myRead(my $payload, $plen);
        out $plen, "  Extra Payload", hexDump($payload);
    }
}

sub decodeMVS
{
    my $len = shift;
    my $context = shift;

    # data in Big-Endian
    myRead(my $data, $len);
    my $ID = unpack("N", $data);

    if ($ID == 0xE9F3F9F0)
    {
        out($data, "  ID", "'Z390'");
        substr($data, 0, 4) = '';
    }

    out($data, "  Extra Payload", hexDump($data));
}

sub printAes
{
    # ref https://www.winzip.com/win/es/aes_info.html

    my $context = shift ;

    my %saltSize = (
                        1 => 8,
                        2 => 12,
                        3 => 16,
                    );

    myRead(my $salt, $saltSize{$context->{AesStrength} });
    out $salt, "AES Salt", hexDump($salt);
    myRead(my $pwv, 2);
    out $pwv, "AES Pwd Ver", hexDump($pwv);

    return  $saltSize{$context->{AesStrength}} + 2 + 10;
}

sub printLzmaProperties
{
    my $len = 0;

    my $b1;
    my $b2;
    my $buffer;

    myRead($b1, 2);
    my ($verHi, $verLow) = unpack ("CC", $b1);

    out $b1, "LZMA Version", sprintf("%02X%02X", $verHi, $verLow) . " '$verHi.$verLow'";
    my $LzmaPropertiesSize = out_v "LZMA Properties Size";
    $len += 4;

    my $LzmaInfo = out_C "LZMA Info",  sub { $_[0] == 93 ? "(Default)" : ""};

    my $PosStateBits = 0;
    my $LiteralPosStateBits = 0;
    my $LiteralContextBits = 0;
    $PosStateBits = int($LzmaInfo / (9 * 5));
	$LzmaInfo -= $PosStateBits * 9 * 5;
	$LiteralPosStateBits = int($LzmaInfo / 9);
	$LiteralContextBits = $LzmaInfo - $LiteralPosStateBits * 9;

    out1 "  PosStateBits",        $PosStateBits;
    out1 "  LiteralPosStateBits", $LiteralPosStateBits;
    out1 "  LiteralContextBits",  $LiteralContextBits;

    out_V "LZMA Dictionary Size";

    # TODO - assumption that this is 5
    $len += $LzmaPropertiesSize;

    skip($FH, $LzmaPropertiesSize - 5)
        if  $LzmaPropertiesSize != 5 ;

    return $len;
}

sub readFromOffset
{
    # my $fh = shift;
    my $offset = shift;
    my $len = shift;

    seekTo($offset) ;

    my $buffer;
    myRead($buffer, $len);
    # $fh->read($buffer, $len) == $len
    length $buffer == $len
        or return '';

    return $buffer;
}

sub chckForAPKSigningBlock
{
    my $fh = shift;
    my $cdOffset = shift;

    # APK Signing Block comes directy before the Central directory

    # If offset less than
    #
    #   len1     8
    #   id       4
    #   kv with zero len 8
    #   len1     8
    #   magic   16
    #   ----------
    #           44

    return (0, 0, '')
        if $cdOffset < 44;

    # Step 1 - 16 bytes before CD is literal string "APK Sig Block 42"
    my $magicOffset = $cdOffset - 16;
    my $buffer = readFromOffset($magicOffset, 16);

    return (0, 0, '')
        if $buffer ne "APK Sig Block 42" ;

    # Step 2 - read the two length fields
    #          and check they are identical
    $buffer = readFromOffset($cdOffset - 16 - 8, 8);
    my $len2 = unpack("Q<", $buffer);

    return (0, 0, '')
        if $len2 == 0 ;

    my $startApkOffset = $cdOffset -  8 - $len2 ;

    $buffer = readFromOffset($startApkOffset, 8);
    my $len1 = unpack("Q<", $buffer);

    return (0, 0, '')
        if $len1 != $len2;

    return ($startApkOffset, $cdOffset - 16 - 8, $buffer);
}

sub scanApkBlock
{
    state $IDs = {
            0x7109871a  => "APK Signature v2",
            0xf05368c0  => "APK Signature v3",
            0x42726577  => "Verity Padding Block", # from https://android.googlesource.com/platform/tools/apksig/+/master/src/main/java/com/android/apksig/internal/apk/ApkSigningBlockUtils.java
            0x6dff800d  => "Source Stamp",
            0x504b4453  => "Dependency Info",
            0x71777777  => "APK Channel Block",
            0xff3b5998  => "Zero Block",
            0x2146444e  => "Play Metadata",
    } ;


    seekTo($FH->tell() - 4) ;
    print "\nAPK SIGNING BLOCK\n";

    scanApkPadding('');
    out_Q "Block Length Copy #1";
    my $ix = 1;

    while ($FH->tell() < $APK - 8)
    {
         my ($bytes, $id, $len);
        ($bytes, $len) = read_Q ;
        out $bytes, "ID/Value Length #" . sprintf("%X", $ix), Value_Q($len);

        ($bytes, $id) = read_V;

        out $bytes, "  ID", Value_V($id) . " '" . ($IDs->{$id} // 'Unknown ID') . "'";

        outSomeData($len-4, "  Value");
        ++ $ix;
    }

    out_Q "Block Length Copy #2";

    my $magic ;
    myRead($magic, 16);

    out $magic, "Magic", qq['$magic'];
}

sub scanApkPadding
{
    my $bytes = shift ;

    # padding
    my $here = $FH->tell();
    my $got;
    myRead($got, $APK - $here);
    $got = $bytes . $got;
    if ($got =~ /^(\x00+)($APK_LEN)?/)
    {
        my $len = length $1 ;
        seekTo($here - length($bytes));
        outSomeData($len, "Null Padding");
    }
    else
    {
        seekTo($here);
    }

}

sub scanCentralDirectory
{
    my $fh = shift;

    my $here = $fh->tell();

    # Use cases
    # 1 32-bit CD
    # 2 64-bit CD

    my @CD = ();
    my $offset = findCentralDirectoryOffset($fh);

    return ()
        if ! defined $offset;

    $fh->seek($offset, SEEK_SET) ;

    # Now walk the Central Directory Records
    my $buffer ;
    my $cdIndex = 0;
    while ($fh->read($buffer, 46) == 46  &&
           unpack("V", $buffer) == ZIP_CENTRAL_HDR_SIG) {

        my $cdEntryOffset = $fh->tell() - 46;
        ++ $cdIndex ;

        my $compressedLength   = unpack("V", substr($buffer, 20, 4));
        my $uncompressedLength = unpack("V", substr($buffer, 24, 4));
        my $filename_length    = unpack("v", substr($buffer, 28, 2));
        my $extra_length       = unpack("v", substr($buffer, 30, 2));
        my $comment_length     = unpack("v", substr($buffer, 32, 2));
        my $locHeaderOffset    = unpack("V", substr($buffer, 42, 4));
        my $cdZip64 = 0;
        my $zip64Sizes = 0;

        skip($fh, $filename_length ) ;

        if ($extra_length)
        {
            $fh->read(my $extraField, $extra_length) ;
            # $self->smartReadExact(\$extraField, $extra_length);

            # Check for Zip64
            # my SizesExtended = findID("\x01\x00", $extraField);
            my $zip64Extended = findID(0x0001, $extraField);

            if ($zip64Extended)
            {
                $cdZip64 = 1;

                if ($uncompressedLength == MAX32)
                {
                    $uncompressedLength = unpack "Q<", substr($zip64Extended, 0, 8, "");
                    $zip64Sizes = 1;
                }
                if ($compressedLength == MAX32)
                {
                    $compressedLength = unpack "Q<", substr($zip64Extended, 0, 8, "");
                    $zip64Sizes = 1;

                }
                if ($locHeaderOffset == MAX32)
                {
                    $locHeaderOffset = unpack "Q<", substr($zip64Extended, 0, 8, "");
                }
            }
        }

        my $got = [$locHeaderOffset, $compressedLength, $cdZip64, $zip64Sizes, $cdIndex, $cdEntryOffset] ;

        skip($fh, $comment_length ) ;

        push @CD, $got ;
    }

    $fh->seek($here, SEEK_SET) ;

    # @CD = sort { $a->[0]->cmp($b->[0]) } @CD ;
    @CD = sort { $a->[0] <=> $b->[0] } @CD ;

    # Set the first Local File Header offset.
    $START = $CD[0]->[0]
        if @CD ;

    return (1, $offset, @CD);
}


sub offsetFromZip64
{
    my $fh = shift ;
    my $here = shift;

    $fh->seek($here - 20, SEEK_SET)
    # TODO - fix this
        or die "xx $!" ;

    my $buffer;
    my $got = 0;
    ($got = $fh->read($buffer, 20)) == 20
    # TODO - fix this
        or die "xxx


         $here $got $!" ;

    if ( unpack("V", $buffer) == ZIP64_END_CENTRAL_LOC_HDR_SIG ) {
        my $cd64 = unpack "Q<", substr($buffer,  8, 8);

        $fh->seek($cd64, SEEK_SET) ;

        $fh->read($buffer, 4) == 4
        # TODO - fix this
            or die "xxx" ;

        if ( unpack("V", $buffer) == ZIP64_END_CENTRAL_REC_HDR_SIG ) {

            $fh->read($buffer, 8) ==  8
            # TODO - fix this
                or die "xxx" ;
            my $size  = unpack "Q<", $buffer;
            $fh->read($buffer, $size) ==  $size
            # TODO - fix this
                or die "xxx" ;

            my $cd64 =  unpack "Q<", substr($buffer,  36, 8);

            return $cd64 ;
        }

        die "Cannot find 'Zip64 end of central directory record': 0x06054b50\nTry running with --scan option.\n" ;
    }

    die "Cannot find signature for 'Zip64 end of central directory locator': 0x07064b50 \nTry running with --scan option.\n" ;
}

use constant Pack_ZIP_END_CENTRAL_HDR_SIG => pack("V", ZIP_END_CENTRAL_HDR_SIG);

sub findCentralDirectoryOffset
{
    my $fh = shift ;

    # Most common use-case is where there is no comment, so
    # know exactly where the end of central directory record
    # should be.

    $fh->seek(-22, SEEK_END) ;
    my $here = $fh->tell();

    my $is64bit = $here > MAX32;
    my $over64bit = $here  & (~ MAX32);

    my $buffer;
    $fh->read($buffer, 22) == 22
    # TODO - fix this
        or die "xxx" ;

    my $zip64 = 0;
    my $centralDirOffset ;

    if ( unpack("V", $buffer) == ZIP_END_CENTRAL_HDR_SIG ) {
        $centralDirOffset = unpack("V", substr($buffer, 16,  4));
    }
    else {
        $fh->seek(0, SEEK_END) ;

        my $fileLen = $fh->tell();
        my $want = 0 ;

        while(1) {
            $want += 1024 * 32;
            my $seekTo = $fileLen - $want;
            if ($seekTo < 0 ) {
                $seekTo = 0;
                $want = $fileLen ;
            }
            $fh->seek( $seekTo, SEEK_SET)
            # TODO - fix this
                or die "xxx $!" ;
            my $got;
            ($got = $fh->read($buffer, $want)) == $want
            # TODO - fix this
                or die "xxx $got  $!" ;
            my $pos = rindex( $buffer, Pack_ZIP_END_CENTRAL_HDR_SIG);

            if ($pos >= 0 && $want - $pos > 22) {
                $here = $seekTo + $pos ;
                $centralDirOffset = unpack("V", substr($buffer, $pos + 16,  4));
                my $commentLength = unpack("V", substr($buffer, $pos + 20,  2));
                $commentLength = 0 if ! defined $commentLength ;

                my $expectedEof = $fileLen - $want + $pos + 22 + $commentLength  ;
                # check for trailing data after end of zip
                if ($expectedEof < $fileLen ) {
                    $TRAILING = $expectedEof ;
                }
                last ;
            }

            return undef
                if $want == $fileLen;
        }
    }

    if (full32 $centralDirOffset)
    {
        $centralDirOffset = offsetFromZip64($fh, $here)
    }
    elsif ($is64bit)
    {
        # use-case is where a 64-bit zip file doesn't use the 64-bit
        # extensions.
        print "EOCD not 64-bit $centralDirOffset ($here)\n" ;

        push @Messages,
            sprintf "Zip file > 4Gig. Expected 'Offset to Central Dir' to be 0xFFFFFFFF, got 0x%X\n", $centralDirOffset;

        $centralDirOffset += $over64bit;
        $is64In32 = 1;
    }

    ($START_APK, $APK, $APK_LEN) = chckForAPKSigningBlock($fh, $centralDirOffset);

    return $centralDirOffset ;
}

sub findID
{
    my $id_want = shift ;
    my $data    = shift;

    my $XLEN = length $data ;

    my $offset = 0 ;
    while ($offset < $XLEN) {

        return undef
            if $offset + ZIP_EXTRA_SUBFIELD_HEADER_SIZE  > $XLEN ;

        my $id = substr($data, $offset, ZIP_EXTRA_SUBFIELD_ID_SIZE);
        $id = unpack("v", $id);
        $offset += ZIP_EXTRA_SUBFIELD_ID_SIZE;

        my $subLen =  unpack("v", substr($data, $offset,
                                            ZIP_EXTRA_SUBFIELD_LEN_SIZE));
        $offset += ZIP_EXTRA_SUBFIELD_LEN_SIZE ;

        return undef
            if $offset + $subLen > $XLEN ;

        return substr($data, $offset, $subLen)
            if $id eq $id_want ;

        $offset += $subLen ;
    }

    return undef ;
}


sub _dosToUnixTime
{
    my $dt = shift;

    my $year = ( ( $dt >> 25 ) & 0x7f ) + 80;
    my $mon  = ( ( $dt >> 21 ) & 0x0f ) - 1;
    my $mday = ( ( $dt >> 16 ) & 0x1f );

    my $hour = ( ( $dt >> 11 ) & 0x1f );
    my $min  = ( ( $dt >> 5  ) & 0x3f );
    my $sec  = ( ( $dt << 1  ) & 0x3e );


    use POSIX 'mktime';

    # Force mktime to return a UTC time
    local $ENV{TZ} = "UTC";

    my $time_t = mktime( $sec, $min, $hour, $mday, $mon, $year, 0, 0, -1 );
    return 0 if ! defined $time_t;
    return $time_t;
}

sub nibbles
{
    my @nibbles = (
        [ 16 => 0x1000000000000000 ],
        [ 15 => 0x100000000000000 ],
        [ 14 => 0x10000000000000 ],
        [ 13 => 0x1000000000000 ],
        [ 12 => 0x100000000000 ],
        [ 11 => 0x10000000000 ],
        [ 10 => 0x1000000000 ],
        [  9 => 0x100000000 ],
        [  8 => 0x10000000 ],
        [  7 => 0x1000000 ],
        [  6 => 0x100000 ],
        [  5 => 0x10000 ],
        [  4 => 0x1000 ],
        [  4 => 0x100 ],
        [  4 => 0x10 ],
        [  4 => 0x1 ],
    );
    my $value = shift ;

    for my $pair (@nibbles)
    {
        my ($count, $limit) = @{ $pair };

        return $count
            if $value >= $limit ;
    }
}


{
    package Seen;

    sub new
    {
        my $class = shift ;

        my %object = ( overlaps     => [],
                       duplicates   => [],
                       detail       => [],
                       duplicate_count  => 0,
                       overlap_count    => 0,
                     ) ;

        bless \%object, $class;
    }

    sub save
    {
        my $self = shift ;
        my $hdrId = shift;
        my $name = shift;
        my $extras = shift;

        my $from_offset = $extras->{LocalHdrOffset};
        my $to_offset = $from_offset ;
        $to_offset += $extras->{CompressedLength} - 1 ;

        my $crc = $extras->{CRC};

        $name = ::redactFilename($name) ;

        for my $entry ( @{ $self->{detail} } )
        {
            if ( $from_offset == $entry->{from} && $to_offset == $entry->{to} && $crc == $entry->{crc})
            {
                $self->{duplicate_count} ++;
                print "$hdrId: '$name' matches with $entry->{str}\n"
            }
            elsif ( ($from_offset >= $entry->{from} && $from_offset <= $entry->{to} ) ||
                    ($to_offset   >= $entry->{from} && $to_offset   <= $entry->{to} )
               )
            {
                # die "overlap!"
                # push @{ $self->{overlap} },
                $self->{overlap_count} ++;

                print "$hdrId: '$name' overlaps with $entry->{str}\n";
            }
        }

        # warn "ADD $from_offset $to_offset $hdrId: $name\n";
        push @{ $self->{detail} },
             {
                from => $from_offset,
                to   => $to_offset,
                length => $extras->{CompressedLength},
                id   => $hdrId,
                crc  => $crc,
                name => $name,
                str  => "$hdrId: '$name'",
             } ;
    }

    sub short_summary
    {
        my $self = shift;

        my $duplicates = $self->{duplicate_count};
        push @Messages, "$duplicates duplicate entries"
            if $duplicates;

        my $overlaps = $self->{overlap_count};
        push @Messages, "$overlaps overlap entries"
            if $overlaps;
    }

    sub summary
    {
        my $self = shift ;

        # disable for now
        return;

        print "\n";
        for my $entry ( sort { $a->{from}->cmp($b->{from}) } @{ $self->{detail} } )

        {
            my $from_offset = $entry->{from};
            my $to_offset = $entry->{to};
            my $hdrId = $entry->{id};
            my $name = $entry->{name};
            print "$hdrId\t" . $entry->{from} . "\n";


        }
    }

}

sub Usage
{
    if (@_)
    {
        warn "$_\n"
        for @_  ;
        warn "\n";
    }

    die <<EOM;
zipdetails [OPTIONS] file

Display details about the internal structure of a Zip file.

This is zipdetails version $VERSION

OPTIONS
     -h        display help
     --redact  Hide filenames in the output
     --scan    enable scannng mode.
               Blindly scan the file looking for zip headers
               Expect false-positives.
     --utc     Display date/time fields in UTC
     -v        Verbose - output more stuff
     --version Print version number

Copyright (c) 2011-2022 Paul Marquess. All rights reserved.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.
EOM


}

__END__

=head1 NAME

zipdetails - display the internal structure of zip files

=head1 SYNOPSIS

    zipdetails [-v][--scan][--redact][--utc] zipfile.zip
    zipdetails -h
    zipdetails --version

=head1 DESCRIPTION

This program creates a detailed report on the internal structure of zip
files. For each item of metadata within a zip file the program will output

=over 5

=item the offset into the zip file where the item is located.

=item a textual representation for the item.

=item an optional hex dump of the item.

=back


The program assumes a prior understanding of the internal structure of Zip
files. You should have a copy of the Zip
L<APPNOTE.TXT|http://www.pkware.com/documents/casestudies/APPNOTE.TXT> file
at hand to help understand the output from this program.

=head2 Default Behaviour

By default the program expects to be given a well-formed zip file.  It will
navigate the Zip file by first parsing the zip central directory at the end
of the file.  If that is found, it will then walk through the zip records
starting at the beginning of the file. Any badly formed zip data structures
encountered are likely to terminate the program.

If the program finds any structural problems with the zip file it will
print a summary at the end of the output report. The set of error cases
reported is very much a work in progress, so don't rely on this feature to
find all the possible errors in a zip file. If you have suggestions for
use-cases where this could be enhanced please consider creating an
enhancement request (see L<"SUPPORT">).

Date/time fields are found in zip files are displayed in local time. Use
the C<--utc> option to display these fields in Coordinated Universal Time
(UTC).

=head2 Scan-Mode

If you do have a potentially corrupt zip file, particulatly where the
central directory at the end of the file is absent/incomplete, you can try
usng the C<--scan> option to search for zip records that are still present.

When Scan-mode is enabled, the program will walk the zip file from the
start, blindly looking for the 4-byte signatures that preceed each of the
zip data structures. If it finds any of the recognised signatures it will
attempt to dump the associated zip record. For very large zip files, this
operation can take a long time to run.

Note that the 4-byte signatures used in zip files can sometimes match with
random data stored in the zip file, so care is needed interpreting the
results.

=head2 OPTIONS

=over 5

=item -h

Display help

=item --redact

Obscure filenames in the output. Handy for the use case where the zip files
contains sensitive data that cannot be shared.

=item --scan

Walk the zip file loking for possible zip records. Can be error-prone.
See L<"Scan-Mode">

=item --utc

By default, date/time fields are displayed in local time. Use this option
to display them in in Coordinated Universal Time (UTC).

=item -v

Enable Verbose mode. See L<"Verbose Output">.

=item --version

Display version number of the program and exit.

=back

=head2 Default Output

By default zipdetails will output the details of the zip file in three
columns.

=over 5

=item Column 1

This contains the offset from the start of the file in hex.

=item Column 2

This contains a textual description of the field.

=item Column 3

If the field contains a numeric value it will be displayed in hex. Zip
stores most numbers in little-endian format - the value displayed will have
the little-endian encoding removed.

Next, is an optional description of what the value means.

=back

For example, assuming you have a zip file with two entries, like this

    $ unzip -l test.zip
    Archive:  setup/test.zip
    Length      Date    Time    Name
    ---------  ---------- -----   ----
            6  2021-03-23 18:52   latters.txt
            6  2021-03-23 18:52   numbers.txt
    ---------                     -------
        12                     2 files

Running C<zipdetails> will gives this output

    $ zipdetails test.zip

    0000 LOCAL HEADER #1       04034B50
    0004 Extract Zip Spec      0A '1.0'
    0005 Extract OS            00 'MS-DOS'
    0006 General Purpose Flag  0000
    0008 Compression Method    0000 'Stored'
    000A Last Mod Time         5277983D 'Tue Mar 23 19:01:58 2021'
    000E CRC                   0F8A149C
    0012 Compressed Length     00000006
    0016 Uncompressed Length   00000006
    001A Filename Length       000B
    001C Extra Length          0000
    001E Filename              'letters.txt'
    0029 PAYLOAD               abcde.

    002F LOCAL HEADER #2       04034B50
    0033 Extract Zip Spec      0A '1.0'
    0034 Extract OS            00 'MS-DOS'
    0035 General Purpose Flag  0000
    0037 Compression Method    0000 'Stored'
    0039 Last Mod Time         5277983D 'Tue Mar 23 19:01:58 2021'
    003D CRC                   261DAFE6
    0041 Compressed Length     00000006
    0045 Uncompressed Length   00000006
    0049 Filename Length       000B
    004B Extra Length          0000
    004D Filename              'numbers.txt'
    0058 PAYLOAD               12345.

    005E CENTRAL HEADER #1     02014B50
    0062 Created Zip Spec      1E '3.0'
    0063 Created OS            03 'Unix'
    0064 Extract Zip Spec      0A '1.0'
    0065 Extract OS            00 'MS-DOS'
    0066 General Purpose Flag  0000
    0068 Compression Method    0000 'Stored'
    006A Last Mod Time         5277983D 'Tue Mar 23 19:01:58 2021'
    006E CRC                   0F8A149C
    0072 Compressed Length     00000006
    0076 Uncompressed Length   00000006
    007A Filename Length       000B
    007C Extra Length          0000
    007E Comment Length        0000
    0080 Disk Start            0000
    0082 Int File Attributes   0001
         [Bit 0]               1 Text Data
    0084 Ext File Attributes   81B40000
    0088 Local Header Offset   00000000
    008C Filename              'letters.txt'

    0097 CENTRAL HEADER #2     02014B50
    009B Created Zip Spec      1E '3.0'
    009C Created OS            03 'Unix'
    009D Extract Zip Spec      0A '1.0'
    009E Extract OS            00 'MS-DOS'
    009F General Purpose Flag  0000
    00A1 Compression Method    0000 'Stored'
    00A3 Last Mod Time         5277983D 'Tue Mar 23 19:01:58 2021'
    00A7 CRC                   261DAFE6
    00AB Compressed Length     00000006
    00AF Uncompressed Length   00000006
    00B3 Filename Length       000B
    00B5 Extra Length          0000
    00B7 Comment Length        0000
    00B9 Disk Start            0000
    00BB Int File Attributes   0001
         [Bit 0]               1 Text Data
    00BD Ext File Attributes   81B40000
    00C1 Local Header Offset   0000002F
    00C5 Filename              'numbers.txt'

    00D0 END CENTRAL HEADER    06054B50
    00D4 Number of this disk   0000
    00D6 Central Dir Disk no   0000
    00D8 Entries in this disk  0002
    00DA Total Entries         0002
    00DC Size of Central Dir   00000072
    00E0 Offset to Central Dir 0000005E
    00E4 Comment Length        0000
    Done


=head2 Verbose Output

If the C<-v> option is present, column 1 is expanded to include

=over 5

=item *

The offset from the start of the file in hex.

=item *

The length of the field in hex.

=item *

A hex dump of the bytes in field in the order they are stored in the zip
file.

=back

Here is the same zip file dumped using the C<zipdetails> C<-v> option:

    $ zipdetails -v test.zip

    0000 0004 50 4B 03 04 LOCAL HEADER #1       04034B50
    0004 0001 0A          Extract Zip Spec      0A '1.0'
    0005 0001 00          Extract OS            00 'MS-DOS'
    0006 0002 00 00       General Purpose Flag  0000
    0008 0002 00 00       Compression Method    0000 'Stored'
    000A 0004 3D 98 77 52 Last Mod Time         5277983D 'Tue Mar 23 19:01:58 2021'
    000E 0004 9C 14 8A 0F CRC                   0F8A149C
    0012 0004 06 00 00 00 Compressed Length     00000006
    0016 0004 06 00 00 00 Uncompressed Length   00000006
    001A 0002 0B 00       Filename Length       000B
    001C 0002 00 00       Extra Length          0000
    001E 000B 6C 65 74 74 Filename              'letters.txt'
              65 72 73 2E
              74 78 74
    0029 0006 61 62 63 64 PAYLOAD               abcde.
              65 0A

    002F 0004 50 4B 03 04 LOCAL HEADER #2       04034B50
    0033 0001 0A          Extract Zip Spec      0A '1.0'
    0034 0001 00          Extract OS            00 'MS-DOS'
    0035 0002 00 00       General Purpose Flag  0000
    0037 0002 00 00       Compression Method    0000 'Stored'
    0039 0004 3D 98 77 52 Last Mod Time         5277983D 'Tue Mar 23 19:01:58 2021'
    003D 0004 E6 AF 1D 26 CRC                   261DAFE6
    0041 0004 06 00 00 00 Compressed Length     00000006
    0045 0004 06 00 00 00 Uncompressed Length   00000006
    0049 0002 0B 00       Filename Length       000B
    004B 0002 00 00       Extra Length          0000
    004D 000B 6E 75 6D 62 Filename              'numbers.txt'
              65 72 73 2E
              74 78 74
    0058 0006 31 32 33 34 PAYLOAD               12345.
              35 0A

    005E 0004 50 4B 01 02 CENTRAL HEADER #1     02014B50
    0062 0001 1E          Created Zip Spec      1E '3.0'
    0063 0001 03          Created OS            03 'Unix'
    0064 0001 0A          Extract Zip Spec      0A '1.0'
    0065 0001 00          Extract OS            00 'MS-DOS'
    0066 0002 00 00       General Purpose Flag  0000
    0068 0002 00 00       Compression Method    0000 'Stored'
    006A 0004 3D 98 77 52 Last Mod Time         5277983D 'Tue Mar 23 19:01:58 2021'
    006E 0004 9C 14 8A 0F CRC                   0F8A149C
    0072 0004 06 00 00 00 Compressed Length     00000006
    0076 0004 06 00 00 00 Uncompressed Length   00000006
    007A 0002 0B 00       Filename Length       000B
    007C 0002 00 00       Extra Length          0000
    007E 0002 00 00       Comment Length        0000
    0080 0002 00 00       Disk Start            0000
    0082 0002 01 00       Int File Attributes   0001
                          [Bit 0]               1 Text Data
    0084 0004 00 00 B4 81 Ext File Attributes   81B40000
    0088 0004 00 00 00 00 Local Header Offset   00000000
    008C 000B 6C 65 74 74 Filename              'letters.txt'
              65 72 73 2E
              74 78 74

    0097 0004 50 4B 01 02 CENTRAL HEADER #2     02014B50
    009B 0001 1E          Created Zip Spec      1E '3.0'
    009C 0001 03          Created OS            03 'Unix'
    009D 0001 0A          Extract Zip Spec      0A '1.0'
    009E 0001 00          Extract OS            00 'MS-DOS'
    009F 0002 00 00       General Purpose Flag  0000
    00A1 0002 00 00       Compression Method    0000 'Stored'
    00A3 0004 3D 98 77 52 Last Mod Time         5277983D 'Tue Mar 23 19:01:58 2021'
    00A7 0004 E6 AF 1D 26 CRC                   261DAFE6
    00AB 0004 06 00 00 00 Compressed Length     00000006
    00AF 0004 06 00 00 00 Uncompressed Length   00000006
    00B3 0002 0B 00       Filename Length       000B
    00B5 0002 00 00       Extra Length          0000
    00B7 0002 00 00       Comment Length        0000
    00B9 0002 00 00       Disk Start            0000
    00BB 0002 01 00       Int File Attributes   0001
                          [Bit 0]               1 Text Data
    00BD 0004 00 00 B4 81 Ext File Attributes   81B40000
    00C1 0004 2F 00 00 00 Local Header Offset   0000002F
    00C5 000B 6E 75 6D 62 Filename              'numbers.txt'
              65 72 73 2E
              74 78 74

    00D0 0004 50 4B 05 06 END CENTRAL HEADER    06054B50
    00D4 0002 00 00       Number of this disk   0000
    00D6 0002 00 00       Central Dir Disk no   0000
    00D8 0002 02 00       Entries in this disk  0002
    00DA 0002 02 00       Total Entries         0002
    00DC 0004 72 00 00 00 Size of Central Dir   00000072
    00E0 0004 5E 00 00 00 Offset to Central Dir 0000005E
    00E4 0002 00 00       Comment Length        0000
    Done

=head1 LIMITATIONS

The following zip file features are not supported by this program:

=over 5

=item *

Multi-part archives.

=item *

The strong encryption features defined in the L<APPNOTE.TXT|http://www.pkware.com/documents/casestudies/APPNOTE.TXT> document.

=back

=head1 TODO

Error handling is a work in progress. If the program encounters a problem
reading a zip file it is likely to terminate with an unhelpful error
message.

=head1 SUPPORT

General feedback/questions/bug reports should be sent to
L<https://github.com/pmqs/zipdetails/issues>.

=head1 SEE ALSO


The primary reference for Zip files is
L<APPNOTE.TXT|http://www.pkware.com/documents/casestudies/APPNOTE.TXT>.

An alternative reference is the Info-Zip appnote. This is available from
L<ftp://ftp.info-zip.org/pub/infozip/doc/>

For details of WinZip AES encryption see L<AES Encryption Information:
Encryption Specification AE-1 and AE-2|https://www.winzip.com/win/es/aes_info.html>.

The C<zipinfo> program that comes with the info-zip distribution
(L<http://www.info-zip.org/>) can also display details of the structure of
a zip file.


=head1 AUTHOR

Paul Marquess F<pmqs@cpan.org>.

=head1 COPYRIGHT

Copyright (c) 2011-2022 Paul Marquess. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
__END__
:endofperl
@set "ErrorLevel=" & @goto _undefined_label_ 2>NUL || @"%COMSPEC%" /d/c @exit %ErrorLevel%