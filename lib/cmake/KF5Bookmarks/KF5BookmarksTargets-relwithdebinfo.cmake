#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::Bookmarks" for configuration "RelWithDebInfo"
set_property(TARGET KF5::Bookmarks APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::Bookmarks PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5Bookmarks.dll.a"
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "KF5::CoreAddons;KF5::Codecs;KF5::ConfigCore;KF5::ConfigWidgets;KF5::XmlGui;Qt5::DBus"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5Bookmarks.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::Bookmarks )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::Bookmarks "${_IMPORT_PREFIX}/lib/libKF5Bookmarks.dll.a" "${_IMPORT_PREFIX}/bin/libKF5Bookmarks.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
