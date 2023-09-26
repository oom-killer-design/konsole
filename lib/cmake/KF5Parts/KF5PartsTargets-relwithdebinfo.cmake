#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::Parts" for configuration "RelWithDebInfo"
set_property(TARGET KF5::Parts APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::Parts PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5Parts.dll.a"
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "KF5::I18n;KF5::IconThemes"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5Parts.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::Parts )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::Parts "${_IMPORT_PREFIX}/lib/libKF5Parts.dll.a" "${_IMPORT_PREFIX}/bin/libKF5Parts.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
