#!/bin/sh

err() {
    printf "\033[0;31m\033[1;1merror:\033[1;0m \033[1;1m%s\033[1;0m\n" "$1"
    exit 1
}

has() {
    _cmd=$(command -v "$1") 2> /dev/null || return 1
    [ -x "$_cmd" ] || return 1
}

gen_dir_template() {
  dirs="
    ./cmd/$_name
    ./internal/self
    ./assets/
    ./.github/
  "
  
  files="
    ./go.mod
    ./cmd/$_name/$_name.go
    ./internal/self/self.go
    ./.github/README.md
  "

  for i in $dirs; do
    { 
      mkdir -p "$i"
      echo "'$i' dir maked"
    } &
  done

  wait

  for i in $files; do
    {
      :>"$i"
      echo "'$i' file touched"
    } &
  done

  wait
}

write_files() {
  {
    echo "module $_module_name

go 1.18" > "./go.mod"
    echo "'go.mod' file writted"
  } &

  {
    echo "# $_name" >> "./.github/README.md"
    echo "'./.github/README.md' writted"
  } &

  {
    echo "package main

import (
        \"$_name/internal/self\"
)

func main() {
        print(\"name - $_name\\\n\")
        print(\"commit - \", self.Commit, \"\\\n\")
        print(\"version - \", self.Version, \"\\\n\")
        print(\"debug - \", self.Debug, \"\\\n\")
}" > "./cmd/$_name/$_name.go"
    echo "'./cmd/$_name/$_name.go' writted"
  } &

  {
    echo 'package self

import _ "embed"

//go:generate sh -c "cd ./../../; ./gmks get commit_hash  > ./internal/self/commit.dat"
//go:embed commit.dat
var Commit string

//go:generate sh -c "cd ./../../; ./gmks get version > ./internal/self/version.dat"
//go:embed version.dat
var Version string

//go:generate sh -c "cd ./../../; ./gmks get debug > ./internal/self/debug.dat"
//go:embed debug.dat
var Debug string' > "./internal/self/self.go"
    echo '''./internal/self/self.go'' writted'
  } &

  wait
}

install_gmks() {
  cp ../gmks/gmks .

  echo "#!/bin/sh

#project info
NAME='$_name'
MAIN_FILE='./cmd/$_name/$_name.go'
BIN_DIR='.'
VERSION='0.0.1'
DEBUG='OFF'

# gc type 
GC='$_gc'

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
  prepare
  build
  strip
  install
  clean
'

# tasks

run() {
  _run \"\$@\"
}

prepare() {
  _format
  _generate
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
}" > "./make.sh"
}

main() {
  echo 'name of project'
  read -p '-> ' _name
  echo
  [ -z "$_name" ] && err '$_name is not defined'

  echo 'module name'
  read -p '-> ' _module_name
  echo
  [ -z "$_module_name" ] && err '$_module_name is not defined'

  echo 'go compiler toolchain'
  echo 'go or gcc'
  read -p '-> ' _gc
  echo
  [ "$_gc" != 'go' ] && [ "$_gc" != 'gcc' ] && {
    err "'$_gc' compiler type is incorrect"
  }
  echo

  gen_dir_template
  write_files
  install_gmks
  echo
}

main "$@"
