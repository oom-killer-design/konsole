#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::KCMUtilsCore" for configuration "RelWithDebInfo"
set_property(TARGET KF5::KCMUtilsCore APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::KCMUtilsCore PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5KCMUtilsCore.dll.a"
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "KF5::ConfigCore;KF5::Service;KF5::ItemViews"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5KCMUtilsCore.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::KCMUtilsCore )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::KCMUtilsCore "${_IMPORT_PREFIX}/lib/libKF5KCMUtilsCore.dll.a" "${_IMPORT_PREFIX}/bin/libKF5KCMUtilsCore.dll" )

# Import target "KF5::KCMUtils" for configuration "RelWithDebInfo"
set_property(TARGET KF5::KCMUtils APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::KCMUtils PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5KCMUtils.dll.a"
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "KF5::KCMUtilsCore;Qt5::DBus;Qt5::Qml;Qt5::Quick;Qt5::QuickWidgets;KF5::CoreAddons;KF5::GuiAddons;KF5::I18n;KF5::ItemViews;KF5::XmlGui;KF5::QuickAddons;KF5::Declarative"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5KCMUtils.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::KCMUtils )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::KCMUtils "${_IMPORT_PREFIX}/lib/libKF5KCMUtils.dll.a" "${_IMPORT_PREFIX}/bin/libKF5KCMUtils.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
