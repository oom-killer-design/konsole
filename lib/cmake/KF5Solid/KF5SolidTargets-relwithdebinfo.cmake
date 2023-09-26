#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::Solid" for configuration "RelWithDebInfo"
set_property(TARGET KF5::Solid APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::Solid PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5Solid.dll.a"
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "Qt5::Xml;Qt5::Gui;Qt5::Network"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5Solid.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::Solid )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::Solid "${_IMPORT_PREFIX}/lib/libKF5Solid.dll.a" "${_IMPORT_PREFIX}/bin/libKF5Solid.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
