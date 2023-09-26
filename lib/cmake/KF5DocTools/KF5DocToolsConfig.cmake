
####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was KF5DocToolsConfig.cmake.in                            ########

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

if (NOT KDOCTOOLS_CUSTOMIZATION_DIR)
    set(KDOCTOOLS_DATA_INSTALL_DIR "${PACKAGE_PREFIX_DIR}/bin/data/kf5")
    set(KDOCTOOLS_CUSTOMIZATION_DIR "${KDOCTOOLS_DATA_INSTALL_DIR}/kdoctools/customization")
endif()

include("${CMAKE_CURRENT_LIST_DIR}/KF5DocToolsTargets.cmake")

    if (CMAKE_CROSSCOMPILING AND KF5_HOST_TOOLING)
    find_file(KDOCTOOLS_TARGETSFILE KF5DocTools/KF5DocToolsToolsTargets.cmake PATHS ${KF5_HOST_TOOLING} ${CMAKE_CURRENT_LIST_DIR} NO_DEFAULT_PATH)
    include("${KDOCTOOLS_TARGETSFILE}")
else()
    include("${CMAKE_CURRENT_LIST_DIR}/KF5DocToolsToolsTargets.cmake")

    # TODO KF6: deprecated, remove the below
    if(CMAKE_CROSSCOMPILING AND MEINPROC5_EXECUTABLE)
        set_target_properties(KF5::meinproc5 PROPERTIES IMPORTED_LOCATION_NONE ${MEINPROC5_EXECUTABLE})
        set_target_properties(KF5::meinproc5 PROPERTIES IMPORTED_LOCATION ${MEINPROC5_EXECUTABLE})
    endif()

    if(CMAKE_CROSSCOMPILING AND DOCBOOKL10NHELPER_EXECUTABLE)
        set_target_properties(KF5::docbookl10nhelper PROPERTIES IMPORTED_LOCATION_NONE ${DOCBOOKL10NHELPER_EXECUTABLE})
        set_target_properties(KF5::docbookl10nhelper PROPERTIES IMPORTED_LOCATION ${DOCBOOKL10NHELPER_EXECUTABLE})
    endif()

    if(CMAKE_CROSSCOMPILING AND CHECKXML5_EXECUTABLE)
        set_target_properties(KF5::checkXML5 PROPERTIES IMPORTED_LOCATION_NONE ${CHECKXML5_EXECUTABLE})
        set_target_properties(KF5::checkXML5 PROPERTIES IMPORTED_LOCATION ${CHECKXML5_EXECUTABLE})
    endif()
endif()

include(${CMAKE_CURRENT_LIST_DIR}/KF5DocToolsMacros.cmake)

# find_dependency must be called *after* including the macros or PACKAGE_PREFIX_DIR will be altered
include(CMakeFindDependencyMacro)
find_dependency(Qt5Core 5.15.2)

# Cannot use Qt6::Core5Compat as it won't be defined at the time this file
# is used
if(TARGET Qt6::Core)
    find_dependency(Qt6Core5Compat 5.15.2)
endif()


