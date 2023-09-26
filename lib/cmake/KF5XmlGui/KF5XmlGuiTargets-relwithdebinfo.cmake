#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::XmlGui" for configuration "RelWithDebInfo"
set_property(TARGET KF5::XmlGui APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::XmlGui PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5XmlGui.dll.a"
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "Qt5::Network;Qt5::PrintSupport;KF5::CoreAddons;KF5::GuiAddons;KF5::WidgetsAddons;KF5::ItemViews;KF5::I18n;KF5::IconThemes"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5XmlGui.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::XmlGui )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::XmlGui "${_IMPORT_PREFIX}/lib/libKF5XmlGui.dll.a" "${_IMPORT_PREFIX}/bin/libKF5XmlGui.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
