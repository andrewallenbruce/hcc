.onLoad <- function(...) {
  S7::S7_on_load()
  requireNamespace("pillar", quietly = TRUE)
}

.onUnload <- function(...) {
  S7::S7_on_unload()
}

S7::S7_on_build()
.onLoad <- function(libname, pkgname) {
  S7::methods_register()
}
