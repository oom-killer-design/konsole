#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::Codecs" for configuration "RelWithDebInfo"
set_property(TARGET KF5::Codecs APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::Codecs PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5Codecs.dll.a"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5Codecs.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::Codecs )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::Codecs "${_IMPORT_PREFIX}/lib/libKF5Codecs.dll.a" "${_IMPORT_PREFIX}/bin/libKF5Codecs.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
