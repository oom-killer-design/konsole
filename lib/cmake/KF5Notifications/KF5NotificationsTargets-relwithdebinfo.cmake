#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::Notifications" for configuration "RelWithDebInfo"
set_property(TARGET KF5::Notifications APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::Notifications PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5Notifications.dll.a"
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "KF5::CoreAddons;KF5::ConfigCore;KF5::WindowSystem;Qt5::Network;Qt5::TextToSpeech"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5Notifications.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::Notifications )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::Notifications "${_IMPORT_PREFIX}/lib/libKF5Notifications.dll.a" "${_IMPORT_PREFIX}/bin/libKF5Notifications.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
