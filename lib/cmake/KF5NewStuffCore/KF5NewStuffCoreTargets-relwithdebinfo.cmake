#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::NewStuffCore" for configuration "RelWithDebInfo"
set_property(TARGET KF5::NewStuffCore APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::NewStuffCore PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5NewStuffCore.dll.a"
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "KF5::Archive;KF5::I18n;KF5::ConfigCore;KF5::Package;Qt5::Gui;KF5::Syndication"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5NewStuffCore.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::NewStuffCore )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::NewStuffCore "${_IMPORT_PREFIX}/lib/libKF5NewStuffCore.dll.a" "${_IMPORT_PREFIX}/bin/libKF5NewStuffCore.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
