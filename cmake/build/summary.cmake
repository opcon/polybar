#
# Output build summary
#

function(colored_option message_level text var color_on color_off)
  string(ASCII 27 esc)
  if(${var})
    message(${message_level} "${esc}[${color_on}m${text}${esc}[0m")
  else()
    message(${message_level} "${esc}[${color_off}m${text}${esc}[0m")
  endif()
endfunction()

message(STATUS " Build:")
if(CMAKE_BUILD_TYPE)
  message_colored(STATUS "   Type: ${CMAKE_BUILD_TYPE}" "37;2")
else()
  message_colored(STATUS "   Type: NONE" "33;1")
endif()

string(TOLOWER "${CMAKE_BUILD_TYPE}" CMAKE_BUILD_TYPE_LOWER)
if(CMAKE_BUILD_TYPE_LOWER STREQUAL "debug")
  if(NOT DEFINED ${DEBUG_LOGGER})
    set(DEBUG_LOGGER ON)
  endif()
  if(NOT DEFINED ${ENABLE_CCACHE})
    set(ENABLE_CCACHE ON)
  endif()
  message_colored(STATUS "   CC: ${CMAKE_C_COMPILER} ${CMAKE_C_FLAGS} ${CMAKE_C_FLAGS_DEBUG}" "37;2")
  message_colored(STATUS "   CXX: ${CMAKE_CXX_COMPILER} ${CMAKE_CXX_FLAGS} ${CMAKE_CXX_FLAGS_DEBUG}" "37;2")
  message_colored(STATUS "   LD: ${CMAKE_LINKER} ${CMAKE_EXE_LINKER_FLAGS}${CMAKE_EXE_LINKER_FLAGS_DEBUG}" "37;2")
elseif(CMAKE_BUILD_TYPE_LOWER STREQUAL "release")
  message_colored(STATUS "   CC: ${CMAKE_C_COMPILER} ${CMAKE_C_FLAGS} ${CMAKE_C_FLAGS_RELEASE}" "37;2")
  message_colored(STATUS "   CXX: ${CMAKE_CXX_COMPILER} ${CMAKE_CXX_FLAGS} ${CMAKE_CXX_FLAGS_RELEASE}" "37;2")
  message_colored(STATUS "   LD: ${CMAKE_LINKER} ${CMAKE_EXE_LINKER_FLAGS}${CMAKE_EXE_LINKER_FLAGS_RELEASE}" "37;2")
elseif(CMAKE_BUILD_TYPE_LOWER STREQUAL "sanitize")
  message_colored(STATUS "   CC: ${CMAKE_C_COMPILER} ${CMAKE_C_FLAGS} ${CMAKE_C_FLAGS_SANITIZE}" "37;2")
  message_colored(STATUS "   CXX: ${CMAKE_CXX_COMPILER} ${CMAKE_CXX_FLAGS} ${CMAKE_CXX_FLAGS_SANITIZE}" "37;2")
  message_colored(STATUS "   LD: ${CMAKE_LINKER} ${CMAKE_EXE_LINKER_FLAGS}${CMAKE_EXE_LINKER_FLAGS_SANITIZE}" "37;2")
elseif(CMAKE_BUILD_TYPE_LOWER STREQUAL "minsizerel")
  message_colored(STATUS "   CC: ${CMAKE_C_COMPILER} ${CMAKE_C_FLAGS} ${CMAKE_C_FLAGS_MINSIZEREL}" "37;2")
  message_colored(STATUS "   CXX: ${CMAKE_CXX_COMPILER} ${CMAKE_CXX_FLAGS} ${CMAKE_CXX_FLAGS_MINSIZEREL}" "37;2")
  message_colored(STATUS "   LD: ${CMAKE_LINKER} ${CMAKE_EXE_LINKER_FLAGS}${CMAKE_EXE_LINKER_FLAGS_MINSIZEREL}" "37;2")
elseif(CMAKE_BUILD_TYPE_LOWER STREQUAL "relwithdebinfo")
  message_colored(STATUS "   CC: ${CMAKE_C_COMPILER} ${CMAKE_C_FLAGS} ${CMAKE_C_FLAGS_RELWITHDEBINFO}" "37;2")
  message_colored(STATUS "   CXX: ${CMAKE_CXX_COMPILER} ${CMAKE_CXX_FLAGS} ${CMAKE_CXX_FLAGS_RELWITHDEBINFO}" "37;2")
  message_colored(STATUS "   LD: ${CMAKE_LINKER} ${CMAKE_EXE_LINKER_FLAGS}${CMAKE_EXE_LINKER_FLAGS_RELWITHDEBINFO}" "37;2")
endif()

if(CMAKE_EXE_LINKER_FLAGS)
  message_colored(STATUS "   LD: ${CMAKE_EXE_LINKER_FLAGS}" "37;2")
endif()

message(STATUS " Targets:")
colored_option(STATUS "   polybar-msg" BUILD_IPC_MSG "32;1" "37;2")
colored_option(STATUS "   testsuite" BUILD_TESTS "32;1" "37;2")

message(STATUS " Module supprt:")
colored_option(STATUS "   alsa" ENABLE_ALSA "32;1" "37;2")
colored_option(STATUS "   curl" ENABLE_CURL "32;1" "37;2")
colored_option(STATUS "   i3" ENABLE_I3 "32;1" "37;2")
colored_option(STATUS "   mpd" ENABLE_MPD "32;1" "37;2")
colored_option(STATUS "   network" ENABLE_NETWORK "32;1" "37;2")
message(STATUS " X extensions:")
colored_option(STATUS "   XRandR" WITH_XRANDR "32;1" "37;2")
colored_option(STATUS "   XRandR (enable monitors)" ENABLE_XRANDR_MONITORS "32;1" "37;2")
colored_option(STATUS "   XRender" WITH_XRENDER "32;1" "37;2")
colored_option(STATUS "   XDamage" WITH_XDAMAGE "32;1" "37;2")
colored_option(STATUS "   XSync" WITH_XSYNC "32;1" "37;2")
colored_option(STATUS "   XComposite" WITH_XCOMPOSITE "32;1" "37;2")
colored_option(STATUS "   Xkb" WITH_XKB "32;1" "37;2")

if(CMAKE_BUILD_TYPE_LOWER STREQUAL "debug")
  message(STATUS " Debug options:")
  colored_option(STATUS "   Trace logging" DEBUG_LOGGER "32;1" "37;2")
  colored_option(STATUS "   Trace logging (verbose)" DEBUG_LOGGER_VERBOSE "32;1" "37;2")
  colored_option(STATUS "   Draw clickable areas" DEBUG_HINTS "32;1" "37;2")
  colored_option(STATUS "   Print fc-match details" DEBUG_FONTCONFIG "32;1" "37;2")
  colored_option(STATUS "   Enable window shading" DEBUG_SHADED "32;1" "37;2")
  message(STATUS "--------------------------")
endif()
