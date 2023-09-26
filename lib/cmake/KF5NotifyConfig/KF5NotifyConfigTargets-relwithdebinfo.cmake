#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::NotifyConfig" for configuration "RelWithDebInfo"
set_property(TARGET KF5::NotifyConfig APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::NotifyConfig PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5NotifyConfig.dll.a"
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "KF5::I18n;KF5::KIOWidgets;Qt5::DBus;Phonon::phonon4qt5"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5NotifyConfig.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::NotifyConfig )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::NotifyConfig "${_IMPORT_PREFIX}/lib/libKF5NotifyConfig.dll.a" "${_IMPORT_PREFIX}/bin/libKF5NotifyConfig.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
