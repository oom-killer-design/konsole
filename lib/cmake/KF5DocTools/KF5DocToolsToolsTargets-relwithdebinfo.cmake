#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::meinproc5" for configuration "RelWithDebInfo"
set_property(TARGET KF5::meinproc5 APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::meinproc5 PROPERTIES
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/meinproc5.exe"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::meinproc5 )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::meinproc5 "${_IMPORT_PREFIX}/bin/meinproc5.exe" )

# Import target "KF5::checkXML5" for configuration "RelWithDebInfo"
set_property(TARGET KF5::checkXML5 APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::checkXML5 PROPERTIES
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/checkXML5.exe"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::checkXML5 )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::checkXML5 "${_IMPORT_PREFIX}/bin/checkXML5.exe" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
