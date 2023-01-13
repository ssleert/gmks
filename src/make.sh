#!/bin/sh

# project info
NAME='test'
MAIN_FILE='./test.go'
BIN_DIR='.'
VERSION='0.0.1'

# gc type
GC='go'

# if gc is gcc
GCC_FLAGS='
  -mfpmath=sse
  -march=native
  -Ofast
  -flto=auto
  -funroll-loops
  -pipe
  -static
  -s
  -w
'

# if gc is go
GO_LINKER_FLAGS='
  -s
  -w
'

# what tasks user can use
# like phony in makefile
TASKS='
  run
  build
  strip
  install
  clean
'

# tasks

run() {
  _run "$@"
}

build() {
  _compile
}

strip() {
  _strip
}

install() {
  _install
}

uninstall() {
  _uninstall
}

clean() {
  _clean
}
