#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::desktoptojson" for configuration "RelWithDebInfo"
set_property(TARGET KF5::desktoptojson APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::desktoptojson PROPERTIES
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/desktoptojson.exe"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::desktoptojson )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::desktoptojson "${_IMPORT_PREFIX}/bin/desktoptojson.exe" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
