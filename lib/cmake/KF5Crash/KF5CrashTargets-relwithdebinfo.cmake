#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::Crash" for configuration "RelWithDebInfo"
set_property(TARGET KF5::Crash APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::Crash PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5Crash.dll.a"
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "Qt5::Gui;KF5::CoreAddons"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5Crash.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::Crash )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::Crash "${_IMPORT_PREFIX}/lib/libKF5Crash.dll.a" "${_IMPORT_PREFIX}/bin/libKF5Crash.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
