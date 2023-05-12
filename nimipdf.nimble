# Package

version       = "0.2.0"
author        = "Jasmine"
description   = "PDF backend for nimib"
license       = "MIT"
srcDir        = "src"


# Tasks

task readme, "Generate readme for nimipdf":
  mkDir "docs"

  exec "nim r -d:md docsrc/index.nim"

task docs, "Build documentation":
  mkDir "docs"

  exec "nim r docsrc/index.nim"
  exec "nim r docsrc/hello.nim"


# Dependencies

requires "nim >= 1.4.0"
requires "nimwkhtmltox >= 0.1.0"
requires "nimib"