#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "LibXslt::LibXslt" for configuration "RelWithDebInfo"
set_property(TARGET LibXslt::LibXslt APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(LibXslt::LibXslt PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libxslt.dll.a"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libxslt.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS LibXslt::LibXslt )
list(APPEND _IMPORT_CHECK_FILES_FOR_LibXslt::LibXslt "${_IMPORT_PREFIX}/lib/libxslt.dll.a" "${_IMPORT_PREFIX}/bin/libxslt.dll" )

# Import target "LibXslt::LibExslt" for configuration "RelWithDebInfo"
set_property(TARGET LibXslt::LibExslt APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(LibXslt::LibExslt PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libexslt.dll.a"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libexslt.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS LibXslt::LibExslt )
list(APPEND _IMPORT_CHECK_FILES_FOR_LibXslt::LibExslt "${_IMPORT_PREFIX}/lib/libexslt.dll.a" "${_IMPORT_PREFIX}/bin/libexslt.dll" )

# Import target "LibXslt::xsltproc" for configuration "RelWithDebInfo"
set_property(TARGET LibXslt::xsltproc APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(LibXslt::xsltproc PROPERTIES
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/xsltproc.exe"
  )

list(APPEND _IMPORT_CHECK_TARGETS LibXslt::xsltproc )
list(APPEND _IMPORT_CHECK_FILES_FOR_LibXslt::xsltproc "${_IMPORT_PREFIX}/bin/xsltproc.exe" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
