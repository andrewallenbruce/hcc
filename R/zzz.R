# nocov start
.onLoad <- function(libname, pkgname) {
  S7::methods_register()
  requireNamespace("pillar", quietly = TRUE)
} # nocov end
