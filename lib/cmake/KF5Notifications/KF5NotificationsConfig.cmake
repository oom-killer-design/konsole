
####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was KF5NotificationsConfig.cmake.in                            ########

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

set(KNOTIFICATIONS_DBUS_INTERFACES_DIR "${PACKAGE_PREFIX_DIR}/bin/data/dbus-1/interfaces")

include(CMakeFindDependencyMacro)
find_dependency(Qt5Gui 5.15.2)
if (TRUE)
    find_dependency(Qt5Widgets 5.15.2)
endif()
if (FALSE)
    find_dependency(Qt5DBus 5.15.2)
endif()

if (NOT ON) 
    find_dependency(KF5CoreAddons "5.110.0")
    find_dependency(KF5Config "5.110.0")

    if (TRUE)
        find_dependency(KF5WindowSystem "5.110.0")
    endif()

    if (ON)
        find_dependency(LibSnoreToast)
        find_dependency(Qt5Network 5.15.2)
    endif()

    if ()
        find_dependency(Phonon4Qt5)
    endif()

    if ()
        find_dependency(Canberra)
    endif()

    if (1)
        find_dependency(Qt5TextToSpeech 5.15.2)
    endif()

    if()
        if (NOT TARGET Qt6::Gui)
            find_dependency(Qt5X11Extras 5.15.2)
        endif()
    endif()

    if(APPLE)
        find_dependency(Qt5MacExtras 5.15.2)
    endif()

    if()
        find_dependency(dbusmenu-qt5)
    endif()

    if (ANDROID)
        find_dependency(Qt5AndroidExtras 5.15.2)
    endif()
endif()

include("${CMAKE_CURRENT_LIST_DIR}/KF5NotificationsTargets.cmake")

