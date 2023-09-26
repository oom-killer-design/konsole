#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::SyntaxHighlighting" for configuration "RelWithDebInfo"
set_property(TARGET KF5::SyntaxHighlighting APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::SyntaxHighlighting PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5SyntaxHighlighting.dll.a"
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "Qt5::Network"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5SyntaxHighlighting.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::SyntaxHighlighting )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::SyntaxHighlighting "${_IMPORT_PREFIX}/lib/libKF5SyntaxHighlighting.dll.a" "${_IMPORT_PREFIX}/bin/libKF5SyntaxHighlighting.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
