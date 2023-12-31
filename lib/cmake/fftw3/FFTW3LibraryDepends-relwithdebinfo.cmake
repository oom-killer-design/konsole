#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "FFTW3::fftw3" for configuration "RelWithDebInfo"
set_property(TARGET FFTW3::fftw3 APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(FFTW3::fftw3 PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libfftw3.dll.a"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libfftw3.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS FFTW3::fftw3 )
list(APPEND _IMPORT_CHECK_FILES_FOR_FFTW3::fftw3 "${_IMPORT_PREFIX}/lib/libfftw3.dll.a" "${_IMPORT_PREFIX}/bin/libfftw3.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
