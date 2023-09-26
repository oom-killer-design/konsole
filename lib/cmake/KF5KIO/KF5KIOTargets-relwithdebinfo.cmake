#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::KIOCore" for configuration "RelWithDebInfo"
set_property(TARGET KF5::KIOCore APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::KIOCore PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5KIOCore.dll.a"
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "Qt5::Xml;KF5::ConfigCore;KF5::I18n;KF5::Crash;KF5::DBusAddons"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5KIOCore.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::KIOCore )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::KIOCore "${_IMPORT_PREFIX}/lib/libKF5KIOCore.dll.a" "${_IMPORT_PREFIX}/bin/libKF5KIOCore.dll" )

# Import target "KF5::KIONTLM" for configuration "RelWithDebInfo"
set_property(TARGET KF5::KIONTLM APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::KIONTLM PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5KIONTLM.dll.a"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5KIONTLM.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::KIONTLM )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::KIONTLM "${_IMPORT_PREFIX}/lib/libKF5KIONTLM.dll.a" "${_IMPORT_PREFIX}/bin/libKF5KIONTLM.dll" )

# Import target "KF5::KIOGui" for configuration "RelWithDebInfo"
set_property(TARGET KF5::KIOGui APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::KIOGui PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5KIOGui.dll.a"
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "KF5::I18n"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5KIOGui.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::KIOGui )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::KIOGui "${_IMPORT_PREFIX}/lib/libKF5KIOGui.dll.a" "${_IMPORT_PREFIX}/bin/libKF5KIOGui.dll" )

# Import target "KF5::KIOWidgets" for configuration "RelWithDebInfo"
set_property(TARGET KF5::KIOWidgets APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::KIOWidgets PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5KIOWidgets.dll.a"
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "Qt5::Concurrent;KF5::I18n;KF5::GuiAddons;KF5::IconThemes;KF5::WindowSystem;KF5::ConfigWidgets;Qt5::DBus"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5KIOWidgets.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::KIOWidgets )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::KIOWidgets "${_IMPORT_PREFIX}/lib/libKF5KIOWidgets.dll.a" "${_IMPORT_PREFIX}/bin/libKF5KIOWidgets.dll" )

# Import target "KF5::KIOFileWidgets" for configuration "RelWithDebInfo"
set_property(TARGET KF5::KIOFileWidgets APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(KF5::KIOFileWidgets PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libKF5KIOFileWidgets.dll.a"
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "KF5::GuiAddons;KF5::IconThemes;KF5::I18n"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libKF5KIOFileWidgets.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::KIOFileWidgets )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::KIOFileWidgets "${_IMPORT_PREFIX}/lib/libKF5KIOFileWidgets.dll.a" "${_IMPORT_PREFIX}/bin/libKF5KIOFileWidgets.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
