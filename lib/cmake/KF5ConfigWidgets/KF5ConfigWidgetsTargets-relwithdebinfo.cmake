#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::ConfigWidgets" for configuration "RelWithDebInfo"
set_property(TARGET KF5::ConfigWidgets APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::ConfigWidgets PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5ConfigWidgets.dll.a"
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "KF5::GuiAddons;KF5::I18n;Qt5::DBus"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5ConfigWidgets.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::ConfigWidgets )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::ConfigWidgets "${_IMPORT_PREFIX}/lib/libKF5ConfigWidgets.dll.a" "${_IMPORT_PREFIX}/bin/libKF5ConfigWidgets.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
