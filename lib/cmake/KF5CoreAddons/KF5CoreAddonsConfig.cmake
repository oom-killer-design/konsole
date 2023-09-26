
####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was KF5CoreAddonsConfig.cmake.in                            ########

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

if(NOT ON)
    if(NOT WIN32)
        find_dependency(Threads)
    endif()

    # Should be if(Inotify_FOUND) here, but for some reason this doesn't work when building statically
    # due to ECM's FindInotify.cmake misbehavior — see https://bugs.kde.org/show_bug.cgi?id=460656 for details.
    # This workaround stops CMake from failing on Linux by relying on the fact that Inotify is built into
    # kernel there, so no additional linking is required, resulting in an empty Inotify_LIBRARIES var.
    # The issue (most likely) persists on BSD, though, where Inotify is, in fact, provided by a library.
    if()
        find_dependency(Inotify)
    endif()

    if()
        find_dependency(Procstat)
    endif()

    if()
        find_dependency(Qt5DBus 5.15.2)
    endif()

    if ()
        find_dependency(UDev)
    endif()
endif()

####################################################################################
# CMAKE_AUTOMOC

# CMake 3.9+ warns about automoc on files without Q_OBJECT, and doesn't know about other macros.
# 3.10+ lets us provide more macro names that require automoc.
foreach(macro_name  K_PLUGIN_FACTORY;K_PLUGIN_CLASS;K_PLUGIN_FACTORY_WITH_JSON;K_PLUGIN_CLASS_WITH_JSON)
    # we can be run multiple times, so add only once
    list (FIND CMAKE_AUTOMOC_MACRO_NAMES "${macro_name}" _index)
    if(_index LESS 0)
        list(APPEND CMAKE_AUTOMOC_MACRO_NAMES ${macro_name})
    endif()
endforeach()

# CMake's automoc needs help to find names of plugin metadata files in case Q_PLUGIN_METADATA
# is indirectly used via other C++ preprocessor macros
foreach(macro_name  K_PLUGIN_FACTORY_WITH_JSON;K_PLUGIN_CLASS_WITH_JSON)
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

if(CMAKE_CROSSCOMPILING AND KF5_HOST_TOOLING)
    find_file(KCOREADDONS_TARGETSFILE KF5CoreAddons/KF5CoreAddonsToolingTargets.cmake
        PATHS ${KF5_HOST_TOOLING} ${CMAKE_CURRENT_LIST_DIR}
        NO_DEFAULT_PATH
        NO_CMAKE_FIND_ROOT_PATH)
    include("${KCOREADDONS_TARGETSFILE}")
    # Check that the host tool version is the same to avoid incompatibilities.
    get_target_property(HOST_TOOL_VERSION KF5::desktoptojson TOOL_VERSION)
    if (NOT ("${HOST_TOOL_VERSION}" VERSION_EQUAL "5.110.0"))
        message(WARNING "Found incompatible host tool version ${HOST_TOOL_VERSION}, expected 5.110.0")
    endif()
else()
    include("${CMAKE_CURRENT_LIST_DIR}/KF5CoreAddonsToolingTargets.cmake")
    if(CMAKE_CROSSCOMPILING AND DESKTOPTOJSON_EXECUTABLE)
        set_target_properties(KF5::desktoptojson PROPERTIES IMPORTED_LOCATION_NONE ${DESKTOPTOJSON_EXECUTABLE})
        set_target_properties(KF5::desktoptojson PROPERTIES IMPORTED_LOCATION ${DESKTOPTOJSON_EXECUTABLE})
    endif()
endif()
include("${CMAKE_CURRENT_LIST_DIR}/KF5CoreAddonsTargets.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/KF5CoreAddonsMacros.cmake")

