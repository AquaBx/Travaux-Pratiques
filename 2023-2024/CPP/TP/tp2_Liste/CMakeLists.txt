cmake_minimum_required(VERSION 3.27)
project(tp2_Liste C)

set(CMAKE_C_STANDARD 11)

include_directories(.)

add_executable(tp2_Liste
        copier.h
        cyclicNode.h
        Liste.h)
