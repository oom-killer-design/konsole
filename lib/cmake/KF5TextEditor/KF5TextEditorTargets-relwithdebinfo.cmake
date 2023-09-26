#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::TextEditor" for configuration "RelWithDebInfo"
set_property(TARGET KF5::TextEditor APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::TextEditor PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5TextEditor.dll.a"
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "Qt5::Qml;Qt5::PrintSupport;KF5::I18n;KF5::Archive;KF5::GuiAddons;KF5::ItemViews;KF5::SonnetCore;KF5::WindowSystem;KF5::SonnetUi"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5TextEditor.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::TextEditor )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::TextEditor "${_IMPORT_PREFIX}/lib/libKF5TextEditor.dll.a" "${_IMPORT_PREFIX}/bin/libKF5TextEditor.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
