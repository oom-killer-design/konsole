#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::kpackagetool5" for configuration "RelWithDebInfo"
set_property(TARGET KF5::kpackagetool5 APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::kpackagetool5 PROPERTIES
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/kpackagetool5.exe"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::kpackagetool5 )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::kpackagetool5 "${_IMPORT_PREFIX}/bin/kpackagetool5.exe" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
