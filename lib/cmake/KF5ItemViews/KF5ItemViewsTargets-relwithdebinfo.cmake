#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::ItemViews" for configuration "RelWithDebInfo"
set_property(TARGET KF5::ItemViews APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::ItemViews PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5ItemViews.dll.a"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5ItemViews.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::ItemViews )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::ItemViews "${_IMPORT_PREFIX}/lib/libKF5ItemViews.dll.a" "${_IMPORT_PREFIX}/bin/libKF5ItemViews.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
