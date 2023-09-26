#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::Syndication" for configuration "RelWithDebInfo"
set_property(TARGET KF5::Syndication APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::Syndication PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5Syndication.dll.a"
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "Qt5::Xml;KF5::Codecs"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5Syndication.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::Syndication )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::Syndication "${_IMPORT_PREFIX}/lib/libKF5Syndication.dll.a" "${_IMPORT_PREFIX}/bin/libKF5Syndication.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
