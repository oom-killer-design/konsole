# SPDX-FileCopyrightText: KDE Contributors
# SPDX-License-Identifier: BSD-2-Clause


####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was KF5NewStuffCoreConfig.cmake.in                            ########

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
find_dependency(KF5Attica "5.110.0")
find_dependency(KF5CoreAddons "5.110.0")
find_dependency(Qt5Xml 5.15.2)

if (NOT ON)
    find_dependency(Qt5Gui 5.15.2)

    find_dependency(KF5I18n "5.110.0")
    find_dependency(KF5Archive "5.110.0")
    find_dependency(KF5Package "5.110.0")
    find_dependency(KF5Config "5.110.0")

    if(1)
            find_dependency(KF5Syndication "5.110.0")
    endif()
endif()

set(KDE_INSTALL_KNSRCDIR "bin/data/knsrcfiles")

include("${CMAKE_CURRENT_LIST_DIR}/KF5NewStuffCoreTargets.cmake")

