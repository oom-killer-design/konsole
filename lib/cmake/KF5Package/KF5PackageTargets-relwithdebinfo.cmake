#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::Package" for configuration "RelWithDebInfo"
set_property(TARGET KF5::Package APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::Package PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5Package.dll.a"
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "Qt5::DBus;KF5::Archive;KF5::I18n"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5Package.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::Package )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::Package "${_IMPORT_PREFIX}/lib/libKF5Package.dll.a" "${_IMPORT_PREFIX}/bin/libKF5Package.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
