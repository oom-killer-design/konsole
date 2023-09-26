#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::Wallet" for configuration "RelWithDebInfo"
set_property(TARGET KF5::Wallet APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::Wallet PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5Wallet.dll.a"
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "Qt5::DBus;Qt5::Widgets;KF5::WindowSystem;KF5::ConfigCore"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5Wallet.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::Wallet )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::Wallet "${_IMPORT_PREFIX}/lib/libKF5Wallet.dll.a" "${_IMPORT_PREFIX}/bin/libKF5Wallet.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
