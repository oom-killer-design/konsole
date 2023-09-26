
####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was KF5PackageConfig.cmake.in                            ########

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

# Any changes in this ".cmake" file will be overwritten by CMake, the source is the ".cmake.in" file.

include("${CMAKE_CURRENT_LIST_DIR}/KF5PackageTargets.cmake")
if (CMAKE_CROSSCOMPILING AND KF5_HOST_TOOLING)
    find_file(KPACKAGE_TARGETSFILE KF5Package/KF5PackageToolsTargets.cmake PATHS ${KF5_HOST_TOOLING} ${CMAKE_CURRENT_LIST_DIR} NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
    include("${KPACKAGE_TARGETSFILE}")
else()
    include("${CMAKE_CURRENT_LIST_DIR}/KF5PackageToolsTargets.cmake")
endif()



set(Package_INSTALL_PREFIX "${PACKAGE_PREFIX_DIR}")
set_and_check(Package_INCLUDE_DIR    "${PACKAGE_PREFIX_DIR}/include/KF5")

set(Package_LIBRARIES KF5::Package)

include(CMakeFindDependencyMacro)
find_dependency(KF5CoreAddons "5.110.0")

####################################################################################
# CMAKE_AUTOMOC

# CMake 3.9+ warns about automoc on files without Q_OBJECT, and doesn't know about other macros.
# 3.10+ lets us provide more macro names that require automoc.
foreach(macro_name  K_EXPORT_KPACKAGE_PACKAGE_WITH_JSON)
    # we can be run multiple times, so add only once
    list (FIND CMAKE_AUTOMOC_MACRO_NAMES "${macro_name}" _index)
    if(_index LESS 0)
        list(APPEND CMAKE_AUTOMOC_MACRO_NAMES ${macro_name})
    endif()
endforeach()

# CMake's automoc needs help to find names of plugin metadata files in case Q_PLUGIN_METADATA
# is indirectly used via other C++ preprocessor macros
foreach(macro_name  K_EXPORT_KPACKAGE_PACKAGE_WITH_JSON)
    # we can be run multiple times, so add only once
    list (FIND CMAKE_AUTOMOC_DEPEND_FILTERS "${macro_name}" _index)
    if(_index LESS 0)
        list(APPEND CMAKE_AUTOMOC_DEPEND_FILTERS
            "${macro_name}"
            "[\n^][ \t]*${macro_name}[ \t\n]*\\([^,]*,[ \t\n]*\"([^\"]+)\""
        )
    endif()
endforeach()

####################################################################################

include("${CMAKE_CURRENT_LIST_DIR}/KF5PackageMacros.cmake")
