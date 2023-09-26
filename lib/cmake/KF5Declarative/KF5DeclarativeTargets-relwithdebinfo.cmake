#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::Declarative" for configuration "RelWithDebInfo"
set_property(TARGET KF5::Declarative APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::Declarative PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5Declarative.dll.a"
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "Qt5::Quick;KF5::I18n;KF5::KIOWidgets;KF5::IconThemes"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5Declarative.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::Declarative )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::Declarative "${_IMPORT_PREFIX}/lib/libKF5Declarative.dll.a" "${_IMPORT_PREFIX}/bin/libKF5Declarative.dll" )

# Import target "KF5::QuickAddons" for configuration "RelWithDebInfo"
set_property(TARGET KF5::QuickAddons APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::QuickAddons PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5QuickAddons.dll.a"
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "KF5::I18n;KF5::Declarative;KF5::ConfigGui"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5QuickAddons.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::QuickAddons )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::QuickAddons "${_IMPORT_PREFIX}/lib/libKF5QuickAddons.dll.a" "${_IMPORT_PREFIX}/bin/libKF5QuickAddons.dll" )

# Import target "KF5::CalendarEvents" for configuration "RelWithDebInfo"
set_property(TARGET KF5::CalendarEvents APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::CalendarEvents PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5CalendarEvents.dll.a"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5CalendarEvents.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::CalendarEvents )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::CalendarEvents "${_IMPORT_PREFIX}/lib/libKF5CalendarEvents.dll.a" "${_IMPORT_PREFIX}/bin/libKF5CalendarEvents.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
