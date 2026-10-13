ignore_unused_imports <- function() {
  doclisting::methods_list
}

.onLoad <- function(...) {
  requireNamespace("pillar", quietly = TRUE)
  charr::charr_threads(4L)
  S7::S7_on_load()
}
.onUnload <- function(...) {
  charr::charr_threads(1L)
  S7::S7_on_unload()
}
S7::S7_on_build()
