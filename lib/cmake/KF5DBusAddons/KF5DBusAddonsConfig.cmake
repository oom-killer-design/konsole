
####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was KF5DBusAddonsConfig.cmake.in                            ########

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
find_dependency(Qt5DBus 5.15.2)

if(NOT ON)
    # Qt5::DBus target will have been defined by the find_dependency() call above
    # at the time where this file is used
    if(0)
        find_dependency(Qt5X11Extras 5.15.2)
    elseif()
        find_dependency(Qt6Gui 5.15.2) # qtx11extras_p.h
    endif()
endif()

include("${CMAKE_CURRENT_LIST_DIR}/KF5DBusAddonsTargets.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/KF5DBusAddonsMacros.cmake")
