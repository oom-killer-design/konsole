# SPDX-FileCopyrightText: 2022 Alexander Lohnau <alexander.lohnau@gmx.de>
# SPDX-License-Identifier: BSD-3-Clause


####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was KF5KCMUtilsConfig.cmake.in                            ########

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
find_dependency(KF5ConfigWidgets  "5.110.0")
find_dependency(KF5Service        "5.110.0")

if (NOT ON)
    find_dependency(Qt5DBus         "5.15.2")
    find_dependency(Qt5Qml          "5.15.2")
    find_dependency(Qt5Quick        "5.15.2")
    find_dependency(Qt5QuickWidgets "5.15.2")

    find_dependency(KF5CoreAddons   "5.110.0")
    find_dependency(KF5GuiAddons    "5.110.0")
    find_dependency(KF5I18n         "5.110.0")
    find_dependency(KF5ItemViews    "5.110.0")
    find_dependency(KF5XmlGui       "5.110.0")
    find_dependency(KF5Declarative  "5.110.0")
endif()

####################################################################################
# CMAKE_AUTOMOC

# CMake 3.9+ warns about automoc on files without Q_OBJECT, and doesn't know about other macros.
# 3.10+ lets us provide more macro names that require automoc.
foreach(macro_name  KCMODULECONTAINER)
    # we can be run multiple times, so add only once
    list (FIND CMAKE_AUTOMOC_MACRO_NAMES "${macro_name}" _index)
    if(_index LESS 0)
        list(APPEND CMAKE_AUTOMOC_MACRO_NAMES ${macro_name})
    endif()
endforeach()

####################################################################################

include("${CMAKE_CURRENT_LIST_DIR}/KF5KCMUtilsTargets.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/KF5KCMUtilsMacros.cmake")

if(CMAKE_CROSSCOMPILING AND KF5_HOST_TOOLING)
    find_file(KCMUTILS_TARGETSFILE KF5KCMUtils/KF5KCMUtilsToolingTargets.cmake
        PATHS ${KF5_HOST_TOOLING} ${CMAKE_CURRENT_LIST_DIR}
        NO_DEFAULT_PATH
        NO_CMAKE_FIND_ROOT_PATH)
    include("${KCMUTILS_TARGETSFILE}")
else()
    include("${CMAKE_CURRENT_LIST_DIR}/KF5KCMUtilsToolingTargets.cmake")
endif()



