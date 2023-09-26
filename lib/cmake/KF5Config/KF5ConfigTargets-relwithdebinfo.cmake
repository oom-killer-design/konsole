#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::ConfigCore" for configuration "RelWithDebInfo"
set_property(TARGET KF5::ConfigCore APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::ConfigCore PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5ConfigCore.dll.a"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5ConfigCore.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::ConfigCore )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::ConfigCore "${_IMPORT_PREFIX}/lib/libKF5ConfigCore.dll.a" "${_IMPORT_PREFIX}/bin/libKF5ConfigCore.dll" )

# Import target "KF5::ConfigGui" for configuration "RelWithDebInfo"
set_property(TARGET KF5::ConfigGui APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::ConfigGui PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5ConfigGui.dll.a"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5ConfigGui.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::ConfigGui )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::ConfigGui "${_IMPORT_PREFIX}/lib/libKF5ConfigGui.dll.a" "${_IMPORT_PREFIX}/bin/libKF5ConfigGui.dll" )

# Import target "KF5::ConfigQml" for configuration "RelWithDebInfo"
set_property(TARGET KF5::ConfigQml APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::ConfigQml PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5ConfigQml.dll.a"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5ConfigQml.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::ConfigQml )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::ConfigQml "${_IMPORT_PREFIX}/lib/libKF5ConfigQml.dll.a" "${_IMPORT_PREFIX}/bin/libKF5ConfigQml.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
