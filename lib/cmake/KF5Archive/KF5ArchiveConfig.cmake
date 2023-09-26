
####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was KF5ArchiveConfig.cmake.in                            ########

get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

macro(set_and_check _var _file)
  set(${_var} "${_file}")
  if(NOT EXISTS "${_file}")
    message(FATAL_ERROR "File or directory ${_file} referenced by variable ${_var} does not exist !")
  endif()
endmacro()

macro(check_required_components _NAME)
  foreach(comp ${${_NAME}_FIND_COMPONENTS})
    if(NOT ${_NAME}_${comp}_FOUND)
      if(${_NAME}_FIND_REQUIRED_${comp})
        set(${_NAME}_FOUND FALSE)
      endif()
    endif()
  endforeach()
endmacro()

####################################################################################

include(CMakeFindDependencyMacro)
find_dependency(Qt5Core 5.15.2)


set(KArchive_HAVE_ZLIB  "TRUE")
set(KArchive_HAVE_BZIP2 "TRUE")
set(KArchive_HAVE_LZMA  "TRUE")
set(KArchive_HAVE_ZSTD  "1")

if (NOT ON)
    if (TRUE)
        find_dependency(ZLIB)
    endif()

    if (TRUE)
        find_dependency(BZip2)
    endif()

    if (TRUE)
        find_dependency(LibLZMA)
    endif()

    if (1)
        find_package(PkgConfig)
        pkg_check_modules(LibZstd IMPORTED_TARGET "libzstd")
    endif()
endif()

include("${CMAKE_CURRENT_LIST_DIR}/KF5ArchiveTargets.cmake")

