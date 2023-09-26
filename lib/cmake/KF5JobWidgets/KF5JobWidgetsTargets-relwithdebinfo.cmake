#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::JobWidgets" for configuration "RelWithDebInfo"
set_property(TARGET KF5::JobWidgets APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::JobWidgets PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5JobWidgets.dll.a"
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "KF5::WidgetsAddons;Qt5::DBus"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5JobWidgets.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::JobWidgets )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::JobWidgets "${_IMPORT_PREFIX}/lib/libKF5JobWidgets.dll.a" "${_IMPORT_PREFIX}/bin/libKF5JobWidgets.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
