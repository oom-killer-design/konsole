#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::kconfig_compiler" for configuration "RelWithDebInfo"
set_property(TARGET KF5::kconfig_compiler APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::kconfig_compiler PROPERTIES
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/kconfig_compiler_kf5.exe"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::kconfig_compiler )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::kconfig_compiler "${_IMPORT_PREFIX}/bin/kconfig_compiler_kf5.exe" )

# Import target "KF5::kconf_update" for configuration "RelWithDebInfo"
set_property(TARGET KF5::kconf_update APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::kconf_update PROPERTIES
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/kconf_update.exe"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::kconf_update )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::kconf_update "${_IMPORT_PREFIX}/bin/kconf_update.exe" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
