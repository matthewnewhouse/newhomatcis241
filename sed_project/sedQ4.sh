#!/usr/bin/env bash

sed -E -n '/\#[ \t]*define/p' /usr/include/limits.h > clean_limits.h
