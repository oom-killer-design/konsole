#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::DocTools" for configuration "RelWithDebInfo"
set_property(TARGET KF5::DocTools APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::DocTools PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5DocTools.dll.a"
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "KF5::Archive"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5DocTools.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::DocTools )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::DocTools "${_IMPORT_PREFIX}/lib/libKF5DocTools.dll.a" "${_IMPORT_PREFIX}/bin/libKF5DocTools.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
