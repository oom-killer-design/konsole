#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::I18n" for configuration "RelWithDebInfo"
set_property(TARGET KF5::I18n APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::I18n PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5I18n.dll.a"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5I18n.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::I18n )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::I18n "${_IMPORT_PREFIX}/lib/libKF5I18n.dll.a" "${_IMPORT_PREFIX}/bin/libKF5I18n.dll" )

# Import target "KF5::I18nLocaleData" for configuration "RelWithDebInfo"
set_property(TARGET KF5::I18nLocaleData APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::I18nLocaleData PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5I18nLocaleData.dll.a"
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "KF5::I18n"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5I18nLocaleData.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::I18nLocaleData )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::I18nLocaleData "${_IMPORT_PREFIX}/lib/libKF5I18nLocaleData.dll.a" "${_IMPORT_PREFIX}/bin/libKF5I18nLocaleData.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
