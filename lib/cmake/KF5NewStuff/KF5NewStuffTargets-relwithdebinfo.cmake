#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::NewStuff" for configuration "RelWithDebInfo"
set_property(TARGET KF5::NewStuff APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::NewStuff PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5NewStuff.dll.a"
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "KF5::KIOCore;KF5::KIOGui;KF5::JobWidgets;KF5::Completion;KF5::I18n;KF5::ItemViews;KF5::IconThemes;Qt5::Qml;Qt5::Quick"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5NewStuff.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::NewStuff )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::NewStuff "${_IMPORT_PREFIX}/lib/libKF5NewStuff.dll.a" "${_IMPORT_PREFIX}/bin/libKF5NewStuff.dll" )

# Import target "KF5::NewStuffWidgets" for configuration "RelWithDebInfo"
set_property(TARGET KF5::NewStuffWidgets APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::NewStuffWidgets PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5NewStuffWidgets.dll.a"
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "KF5::I18n"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5NewStuffWidgets.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::NewStuffWidgets )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::NewStuffWidgets "${_IMPORT_PREFIX}/lib/libKF5NewStuffWidgets.dll.a" "${_IMPORT_PREFIX}/bin/libKF5NewStuffWidgets.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
