#' Install R packages
#'
#' @param pkg A package name for Git(hub) package (e.g. `ShixiangWang/ezcox`) or
#' a list of packages (e.g. `c("dplyr", "maftools")`) for normal packages.
#' @param gitee If `TRUE`, install package from gitee.
#' @param ... Other arguments passing to [remotes::install_git],
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

#' Clone a Git repository
#'
#' @inheritParams git2r::clone
#' @param gitee If `TRUE`, clone repository from gitee.
#' @param reset_remote if `TRUE`, reset GitHub repository remote url.
#' @param ... Other arguments passing to [git2r::clone]
#'
#' @return Nothing
#' @export
#'
#' @examples
#' \dontrun{
#'  clone("ShixiangWang/ezcox", file.path(tempdir(), "ezcox"), reset_remote = TRUE)
#'  clone("ShixiangWang/tinyscholar", file.path(tempdir(), "ezcox"), gitee = TRUE)
#' }
clone <- function(url, local_path, gitee = FALSE, reset_remote = FALSE, ...) {
  stopifnot(length(url) == 1L)

  local_path <- path.expand(local_path)
  if (!grepl(":", url)) {
    if (gitee) {
      url <- paste0("https://gitee.com/", url)
    } else {
      message("Treat input as a GitHub repo.")
      url <- paste0("https://hub.fastgit.org/", url)
    }
  }
  url <- sub("github.com", "hub.fastgit.org", url, fixed = TRUE)
  git2r::clone(url, local_path, bare = FALSE, ...)
  if (reset_remote) {
    if (grepl("fastgit", url)) {
      url <- sub("hub.fastgit.org", "github.com", url, fixed = TRUE)
      message("Reset remote url to ", url)
      git2r:::remote_set_url(local_path,
                             name = git2r::remotes(local_path),
                             url
      )
    } else {
      message("No need to reset.")
    }
  }
}

download <- function() {

}

verbose_git <- function() message("See ?remotes::install_git fore more options.")
verbose_github <- function() message("See ?remotes::install_github fore more options.")
verbose_bioc <- function() message("See ?BiocManager::install for more options.")
verbose_clone <- function() message("See ?git2r::clone for more options.")
