# Copyright 2017-2019 Peter Dimov
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE_1_0.txt or copy at http://boost.org/LICENSE_1_0.txt)

function(boost_detect_toolset)
  string(REGEX MATCHALL "[0-9]+" _BOOST_COMPILER_VERSION ${CMAKE_CXX_COMPILER_VERSION})

  list(GET _BOOST_COMPILER_VERSION 0 _BOOST_COMPILER_VERSION_MAJOR)
  list(GET _BOOST_COMPILER_VERSION 1 _BOOST_COMPILER_VERSION_MINOR)

  if(BORLAND)

    # Borland is unversioned

    set(BOOST_DETECTED_TOOLSET "bcb")

    set(_BOOST_COMPILER_VERSION_MAJOR)
    set(_BOOST_COMPILER_VERSION_MINOR)

  elseif(CMAKE_CXX_COMPILER_ID STREQUAL "AppleClang")

    set(BOOST_DETECTED_TOOLSET "clang-darwin")

  elseif(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")

    if(MSVC)
      set(BOOST_DETECTED_TOOLSET "clangw")
    else()
      set(BOOST_DETECTED_TOOLSET "clang")
    endif()

    if(_BOOST_COMPILER_VERSION_MAJOR GREATER 3)
      set(_BOOST_COMPILER_VERSION_MINOR)
    endif()

  elseif(CMAKE_CXX_COMPILER_ID STREQUAL "Intel")

    if(WIN32)

      # Intel-Win is unversioned

      set(BOOST_DETECTED_TOOLSET "iw")

      set(_BOOST_COMPILER_VERSION_MAJOR)
      set(_BOOST_COMPILER_VERSION_MINOR)

    else()

      set(BOOST_DETECTED_TOOLSET "il")

    endif()

  elseif(CMAKE_CXX_COMPILER_ID STREQUAL "MIPSpro")

      set(BOOST_DETECTED_TOOLSET "mp")

  elseif(CMAKE_CXX_COMPILER_ID STREQUAL "SunPro")

      set(BOOST_DETECTED_TOOLSET "sun")

  elseif(CMAKE_CXX_COMPILER_ID STREQUAL "IBM XL")

      set(BOOST_DETECTED_TOOLSET "xlc")

  elseif(MINGW)

    set(BOOST_DETECTED_TOOLSET "mgw")

    if(_BOOST_COMPILER_VERSION_MAJOR GREATER 4)
      set(_BOOST_COMPILER_VERSION_MINOR)
    endif()

  elseif(CMAKE_COMPILER_IS_GNUCXX)

    if(APPLE)
      set(BOOST_DETECTED_TOOLSET "xgcc")
    else()
      set(BOOST_DETECTED_TOOLSET "gcc")
    endif()

    if(_BOOST_COMPILER_VERSION_MAJOR GREATER 4)
      set(_BOOST_COMPILER_VERSION_MINOR)
    endif()

  elseif(MSVC)

    if((MSVC_VERSION GREATER 1919) AND (MSVC_VERSION LESS 1930))

      set(BOOST_DETECTED_TOOLSET "vc142")

    elseif((MSVC_VERSION GREATER 1909) AND (MSVC_VERSION LESS 1920))

      set(BOOST_DETECTED_TOOLSET "vc141")

    elseif(MSVC_VERSION EQUAL 1900)

      set(BOOST_DETECTED_TOOLSET "vc140")

    elseif(MSVC_VERSION EQUAL 1800)

      set(BOOST_DETECTED_TOOLSET "vc120")

    elseif(MSVC_VERSION EQUAL 1700)

      set(BOOST_DETECTED_TOOLSET "vc110")

    elseif(MSVC_VERSION EQUAL 1600)

      set(BOOST_DETECTED_TOOLSET "vc100")

    elseif(MSVC_VERSION EQUAL 1500)

      set(BOOST_DETECTED_TOOLSET "vc90")

    elseif(MSVC_VERSION EQUAL 1400)

      set(BOOST_DETECTED_TOOLSET "vc80")

    elseif(MSVC_VERSION EQUAL 1310)

      set(BOOST_DETECTED_TOOLSET "vc71")

    elseif(MSVC_VERSION EQUAL 1300)

      set(BOOST_DETECTED_TOOLSET "vc7")

    elseif(MSVC_VERSION EQUAL 1200)

      set(BOOST_DETECTED_TOOLSET "vc6")

    endif()

    set(_BOOST_COMPILER_VERSION_MAJOR)
    set(_BOOST_COMPILER_VERSION_MINOR)

  endif()

  # Add version

  if(BOOST_DETECTED_TOOLSET)
    set(BOOST_DETECTED_TOOLSET ${BOOST_DETECTED_TOOLSET}${_BOOST_COMPILER_VERSION_MAJOR}${_BOOST_COMPILER_VERSION_MINOR} PARENT_SCOPE)
    if(Boost_DEBUG)
      message(STATUS "Boost toolset is ${BOOST_DETECTED_TOOLSET} (${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION})")
    endif()
  else()
    set(BOOST_DETECTED_TOOLSET "" PARENT_SCOPE)
    # Unknown toolset
    message(STATUS "Boost toolset is unknown (compiler ${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION})")
  endif()
endfunction()
