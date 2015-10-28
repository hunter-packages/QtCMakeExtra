# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

cmake_minimum_required(VERSION 3.0)

include("cmake/HunterGate.cmake")
HunterGate(
    URL "https://github.com/ruslo/hunter/archive/v0.12.25.tar.gz"
    SHA1 "c8d7b703dd093ec1aa87333226ddf4617a8aa06c"
)

project(QtCMakeExtra)

add_subdirectory("./cmake")
add_subdirectory("./sources")
