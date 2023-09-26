#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::SonnetCore" for configuration "RelWithDebInfo"
set_property(TARGET KF5::SonnetCore APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::SonnetCore PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5SonnetCore.dll.a"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5SonnetCore.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::SonnetCore )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::SonnetCore "${_IMPORT_PREFIX}/lib/libKF5SonnetCore.dll.a" "${_IMPORT_PREFIX}/bin/libKF5SonnetCore.dll" )

# Import target "KF5::SonnetUi" for configuration "RelWithDebInfo"
set_property(TARGET KF5::SonnetUi APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::SonnetUi PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5SonnetUi.dll.a"
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "KF5::SonnetCore"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5SonnetUi.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::SonnetUi )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::SonnetUi "${_IMPORT_PREFIX}/lib/libKF5SonnetUi.dll.a" "${_IMPORT_PREFIX}/bin/libKF5SonnetUi.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
