#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::WidgetsAddons" for configuration "RelWithDebInfo"
set_property(TARGET KF5::WidgetsAddons APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::WidgetsAddons PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5WidgetsAddons.dll.a"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5WidgetsAddons.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::WidgetsAddons )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::WidgetsAddons "${_IMPORT_PREFIX}/lib/libKF5WidgetsAddons.dll.a" "${_IMPORT_PREFIX}/bin/libKF5WidgetsAddons.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
