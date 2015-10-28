# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

# Implementation note: this package should not depends on Qt since it downloaded
# when Qt downloaded (avoid circular dependency)

cmake_minimum_required(VERSION 3.0)
project(QtCMakeExtra)

add_subdirectory("./cmake")
add_subdirectory("./sources")
