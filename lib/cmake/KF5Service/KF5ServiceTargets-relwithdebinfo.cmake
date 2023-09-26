#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::Service" for configuration "RelWithDebInfo"
set_property(TARGET KF5::Service APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::Service PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5Service.dll.a"
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "KF5::I18n;Qt5::Xml;KF5::DBusAddons"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5Service.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::Service )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::Service "${_IMPORT_PREFIX}/lib/libKF5Service.dll.a" "${_IMPORT_PREFIX}/bin/libKF5Service.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
