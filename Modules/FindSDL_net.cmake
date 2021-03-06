# - Locate SDL_net library
# This module defines:
#  SDL_NET_LIBRARIES, the name of the library to link against
#  SDL_NET_INCLUDE_DIRS, where to find the headers
#  SDL_NET_FOUND, if false, do not try to link against
#  SDL_NET_VERSION_STRING - human-readable string containing the version of SDL_net
#
# For backward compatiblity the following variables are also set:
#  SDLNET_LIBRARY (same value as SDL_NET_LIBRARIES)
#  SDLNET_INCLUDE_DIR (same value as SDL_NET_INCLUDE_DIRS)
#  SDLNET_FOUND (same value as SDL_NET_FOUND)
#
# $SDLDIR is an environment variable that would
# correspond to the ./configure --prefix=$SDLDIR
# used in building SDL.
#
# Created by Eric Wing. This was influenced by the FindSDL.cmake
# module, but with modifications to recognize OS X frameworks and
# additional Unix paths (FreeBSD, etc).

#=============================================================================
# Copyright 2005-2009 Kitware, Inc.
# Copyright 2012 Benjamin Eikel
#
# Distributed under the OSI-approved BSD License (the "License");
# see accompanying file Copyright.txt for details.
#
# This software is distributed WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the License for more information.
#=============================================================================
# (To distribute this file outside of CMake, substitute the full
#  License text for the above reference.)

if(NOT SDL_NET_INCLUDE_DIR AND SDLNET_INCLUDE_DIR)
  set(SDL_NET_INCLUDE_DIR ${SDLNET_INCLUDE_DIR} CACHE PATH "directory cache
entry initialized from old variable name")
endif()
find_path(SDL_NET_INCLUDE_DIR SDL_net.h
  HINTS
    ENV SDLNETDIR
    ENV SDLDIR
  PATH_SUFFIXES SDL SDL12 SDL11
)

if(NOT SDL_NET_LIBRARY AND SDLNET_LIBRARY)
  set(SDL_NET_LIBRARY ${SDLNET_LIBRARY} CACHE FILEPATH "file cache entry
initialized from old variable name")
endif()
find_library(SDL_NET_LIBRARY
  NAMES SDL_net
  HINTS
    ENV SDLNETDIR
    ENV SDLDIR
)

if(SDL_NET_INCLUDE_DIR AND EXISTS "${SDL_NET_INCLUDE_DIR}/SDL_net.h")
  file(STRINGS "${SDL_NET_INCLUDE_DIR}/SDL_net.h" SDL_NET_VERSION_MAJOR_LINE REGEX "^#define[ \t]+SDL_NET_MAJOR_VERSION[ \t]+[0-9]+$")
  file(STRINGS "${SDL_NET_INCLUDE_DIR}/SDL_net.h" SDL_NET_VERSION_MINOR_LINE REGEX "^#define[ \t]+SDL_NET_MINOR_VERSION[ \t]+[0-9]+$")
  file(STRINGS "${SDL_NET_INCLUDE_DIR}/SDL_net.h" SDL_NET_VERSION_PATCH_LINE REGEX "^#define[ \t]+SDL_NET_PATCHLEVEL[ \t]+[0-9]+$")
  string(REGEX REPLACE "^#define[ \t]+SDL_NET_MAJOR_VERSION[ \t]+([0-9]+)$" "\\1" SDL_NET_VERSION_MAJOR "${SDL_NET_VERSION_MAJOR_LINE}")
  string(REGEX REPLACE "^#define[ \t]+SDL_NET_MINOR_VERSION[ \t]+([0-9]+)$" "\\1" SDL_NET_VERSION_MINOR "${SDL_NET_VERSION_MINOR_LINE}")
  string(REGEX REPLACE "^#define[ \t]+SDL_NET_PATCHLEVEL[ \t]+([0-9]+)$" "\\1" SDL_NET_VERSION_PATCH "${SDL_NET_VERSION_PATCH_LINE}")
  set(SDL_NET_VERSION_STRING ${SDL_NET_VERSION_MAJOR}.${SDL_NET_VERSION_MINOR}.${SDL_NET_VERSION_PATCH})
  unset(SDL_NET_VERSION_MAJOR_LINE)
  unset(SDL_NET_VERSION_MINOR_LINE)
  unset(SDL_NET_VERSION_PATCH_LINE)
  unset(SDL_NET_VERSION_MAJOR)
  unset(SDL_NET_VERSION_MINOR)
  unset(SDL_NET_VERSION_PATCH)
endif()

set(SDL_NET_LIBRARIES ${SDL_NET_LIBRARY})
set(SDL_NET_INCLUDE_DIRS ${SDL_NET_INCLUDE_DIR})

include(${CMAKE_CURRENT_LIST_DIR}/FindPackageHandleStandardArgs.cmake)

FIND_PACKAGE_HANDLE_STANDARD_ARGS(SDL_net
                                  REQUIRED_VARS SDL_NET_LIBRARIES SDL_NET_INCLUDE_DIRS
                                  VERSION_VAR SDL_NET_VERSION_STRING)

# for backward compatiblity
set(SDLNET_LIBRARY ${SDL_NET_LIBRARIES})
set(SDLNET_INCLUDE_DIR ${SDL_NET_INCLUDE_DIRS})
set(SDLNET_FOUND ${SDL_NET_FOUND})

mark_as_advanced(SDL_NET_LIBRARY SDL_NET_INCLUDE_DIR)
