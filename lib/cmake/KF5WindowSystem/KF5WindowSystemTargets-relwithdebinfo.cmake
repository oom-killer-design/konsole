#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::WindowSystem" for configuration "RelWithDebInfo"
set_property(TARGET KF5::WindowSystem APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::WindowSystem PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5WindowSystem.dll.a"
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "Qt5::WinExtras"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5WindowSystem.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::WindowSystem )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::WindowSystem "${_IMPORT_PREFIX}/lib/libKF5WindowSystem.dll.a" "${_IMPORT_PREFIX}/bin/libKF5WindowSystem.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
