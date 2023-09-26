#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::TextWidgets" for configuration "RelWithDebInfo"
set_property(TARGET KF5::TextWidgets APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::TextWidgets PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5TextWidgets.dll.a"
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "KF5::SonnetCore;KF5::ConfigWidgets;KF5::Completion;Qt5::TextToSpeech"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5TextWidgets.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::TextWidgets )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::TextWidgets "${_IMPORT_PREFIX}/lib/libKF5TextWidgets.dll.a" "${_IMPORT_PREFIX}/bin/libKF5TextWidgets.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
