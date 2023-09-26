#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::Completion" for configuration "RelWithDebInfo"
set_property(TARGET KF5::Completion APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::Completion PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5Completion.dll.a"
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "KF5::ConfigCore;KF5::ConfigGui;KF5::WidgetsAddons"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5Completion.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::Completion )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::Completion "${_IMPORT_PREFIX}/lib/libKF5Completion.dll.a" "${_IMPORT_PREFIX}/bin/libKF5Completion.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
