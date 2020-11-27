#' Remove paths (files/directories) from your system
#'
#' @param paths A character vector with the names of the file(s) or directories to be deleted.
#'
#' @return A logical value indicating remove status.
#' @export
#'
#' @examples
#' x <- tempfile()
#' file.create(x)
#' yes <- rm_paths(x)
#' print(yes)
rm_paths <- function(paths) {
  if (any(purrr::map_lgl(paths, dir.exists)) || any(file.exists(paths))) {
    tryCatch(
      {
        unlink(paths, recursive = TRUE, force = TRUE)
        invisible(TRUE)
      },
      error = function(e) {
        invisible(FALSE)
      }
    )
  } else {
    message("The path does not exist, no need to remove.")
    invisible(FALSE)
  }
}
