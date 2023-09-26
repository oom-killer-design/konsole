#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::CoreAddons" for configuration "RelWithDebInfo"
set_property(TARGET KF5::CoreAddons APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::CoreAddons PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5CoreAddons.dll.a"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5CoreAddons.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::CoreAddons )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::CoreAddons "${_IMPORT_PREFIX}/lib/libKF5CoreAddons.dll.a" "${_IMPORT_PREFIX}/bin/libKF5CoreAddons.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
