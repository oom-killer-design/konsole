#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "qca-qt5" for configuration "RelWithDebInfo"
set_property(TARGET qca-qt5 APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(qca-qt5 PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "C:/CraftRoot/lib/libqca-qt5.dll.a"
  IMPORTED_LOCATION_RELWITHDEBINFO "C:/CraftRoot/bin/libqca-qt5.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS qca-qt5 )
list(APPEND _IMPORT_CHECK_FILES_FOR_qca-qt5 "C:/CraftRoot/lib/libqca-qt5.dll.a" "C:/CraftRoot/bin/libqca-qt5.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
