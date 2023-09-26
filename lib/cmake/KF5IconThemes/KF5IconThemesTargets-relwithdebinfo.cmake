#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::IconThemes" for configuration "RelWithDebInfo"
set_property(TARGET KF5::IconThemes APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::IconThemes PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5IconThemes.dll.a"
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "Qt5::Svg;KF5::Archive;KF5::I18n;KF5::WidgetsAddons;KF5::ConfigWidgets;KF5::CoreAddons;Qt5::DBus"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5IconThemes.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::IconThemes )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::IconThemes "${_IMPORT_PREFIX}/lib/libKF5IconThemes.dll.a" "${_IMPORT_PREFIX}/bin/libKF5IconThemes.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
