#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "libjpeg-turbo::jpeg" for configuration "RelWithDebInfo"
set_property(TARGET libjpeg-turbo::jpeg APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(libjpeg-turbo::jpeg PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libjpeg.dll.a"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libjpeg-62.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS libjpeg-turbo::jpeg )
list(APPEND _IMPORT_CHECK_FILES_FOR_libjpeg-turbo::jpeg "${_IMPORT_PREFIX}/lib/libjpeg.dll.a" "${_IMPORT_PREFIX}/bin/libjpeg-62.dll" )

# Import target "libjpeg-turbo::turbojpeg" for configuration "RelWithDebInfo"
set_property(TARGET libjpeg-turbo::turbojpeg APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(libjpeg-turbo::turbojpeg PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libturbojpeg.dll.a"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libturbojpeg.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS libjpeg-turbo::turbojpeg )
list(APPEND _IMPORT_CHECK_FILES_FOR_libjpeg-turbo::turbojpeg "${_IMPORT_PREFIX}/lib/libturbojpeg.dll.a" "${_IMPORT_PREFIX}/bin/libturbojpeg.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
