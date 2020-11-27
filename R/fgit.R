#' Install R packages
#'
#' @param pkg A package name for Git(hub) package (e.g. `ShixiangWang/ezcox`) or
#' a list of packages (e.g. `c("dplyr", "maftools")`) for normal packages.
#' @param gitee if `TRUE`, install package from gitee.
#' @param ... other arguments passing to [remotes::install_git],
#' [BiocManager::install] or [remotes::install_github] based on input.
#'
#' @return Nothing.
#' @export
#'
#' @examples
#' \dontrun{
#' install("ShixiangWang/ezcox")
#' install("ShixiangWang/tinyscholar", gitee = TRUE)
#' install(c("ggplot2", "Biobase"))
#' }
install <- function(pkg, gitee = FALSE, ...) {
  stopifnot(is.logical(gitee))
  if (gitee) {
    if (!grepl("/", pkg)) stop("Invalid package name, should in name/repo format.")
    verbose_git()
    remotes::install_git(paste0("https://gitee.com/", pkg), ...)
  } else {
    if (any(grepl(":", pkg))) {
      verbose_git()
      remotes::install_git(pkg, ...)
    } else {
      if (any(grepl("/", pkg))) {
        verbose_git()
        tryCatch(
          remotes::install_git(paste0("https://hub.fastgit.org/", pkg)),
          error = function(e) {
            message("Install error when use GitHub mirror, roll back to official GitHub.")
            verbose_github()
            remotes::install_github(pkg)
          }
        )
      } else {
        verbose_bioc()
        BiocManager::install(pkg)
      }
    }
  }
}

verbose_git <- function() message("See ?remotes::install_git fore more options.")
verbose_github <- function() message("See ?remotes::install_github fore more options.")
verbose_bioc <- function() message("See ?BiocManager::install for more options.")

clone <- function() {

}

download <- function() {

}
