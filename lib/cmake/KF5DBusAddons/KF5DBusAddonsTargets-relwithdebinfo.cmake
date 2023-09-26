#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::DBusAddons" for configuration "RelWithDebInfo"
set_property(TARGET KF5::DBusAddons APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::DBusAddons PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5DBusAddons.dll.a"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5DBusAddons.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::DBusAddons )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::DBusAddons "${_IMPORT_PREFIX}/lib/libKF5DBusAddons.dll.a" "${_IMPORT_PREFIX}/bin/libKF5DBusAddons.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
