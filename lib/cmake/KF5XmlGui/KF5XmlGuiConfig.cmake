
####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was KF5XmlGuiConfig.cmake.in                            ########

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

set(XMLGUI_DBUS_INTERFACES_DIR "${PACKAGE_PREFIX_DIR}/bin/data/dbus-1/interfaces")

include(CMakeFindDependencyMacro)
if ("1" OR "")
  find_dependency(Qt5DBus 5.15.2)
endif()
find_dependency(Qt5Widgets 5.15.2)
find_dependency(Qt5Xml 5.15.2)

find_dependency(KF5Config "5.110.0")
find_dependency(KF5ConfigWidgets "5.110.0")

if (NOT ON) 
    find_dependency(Qt5Network "5.15.2")
    find_dependency(Qt5PrintSupport "5.15.2")

    if ()
        find_dependency(KF5GlobalAccel "5.110.0")
    endif()

    find_dependency(KF5CoreAddons "5.110.0") 
    find_dependency(KF5GuiAddons "5.110.0")
    find_dependency(KF5WidgetsAddons "5.110.0")
    find_dependency(KF5ItemViews "5.110.0")
    find_dependency(KF5I18n "5.110.0")
    find_dependency(KF5IconThemes "5.110.0")
endif()

include("${CMAKE_CURRENT_LIST_DIR}/KF5XmlGuiTargets.cmake")

