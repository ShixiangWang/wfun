
<!-- README.md is generated from README.Rmd. Please edit that file -->

# wfun

<!-- badges: start -->
<!-- badges: end -->

The goal of wfun is to provide useful functions to accelerate coding.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("ShixiangWang/wfun")
# from Gitee
# remotes::install_git("https://gitee.com/ShixiangWang/wfun")
```

Load it with:

``` r
library(wfun)
```

## Example

### Install GitHub/Gitee repo as R package

``` r
install("ShixiangWang/ezcox")
install("ShixiangWang/tinyscholar", gitee = TRUE)
```

The `install()` func can be also used to install normal CRAN/BioC
packages.

``` r
install(c("ggplot2", "Biobase"))
```

### Clone GitHub/Gitee repo

``` r
x <- file.path(tempdir(), "ezcox")
if (dir.exists(x)) rm_paths(x)
clone("ShixiangWang/ezcox", x, reset_remote = TRUE)
#> Treat input as a GitHub repo.
#> cloning into '/var/folders/bj/nw1w4g1j37ddpgb6zmh3sfh80000gn/T//Rtmp0sCShM/ezcox'...
#> Receiving objects:   1% (9/814),   31 kb
#> Receiving objects:  11% (90/814),   31 kb
#> Receiving objects:  21% (171/814),   47 kb
#> Receiving objects:  31% (253/814),   63 kb
#> Receiving objects:  41% (334/814),   95 kb
#> Receiving objects:  51% (416/814),  143 kb
#> Receiving objects:  61% (497/814),  191 kb
#> Receiving objects:  71% (578/814), 1007 kb
#> Receiving objects:  81% (660/814), 1775 kb
#> Receiving objects:  91% (741/814), 3198 kb
#> Receiving objects: 100% (814/814), 3640 kb, done.
#> Reset remote url to https://github.com/ShixiangWang/ezcox

y <- file.path(tempdir(), "tinyscholar")
if (dir.exists(y)) rm_paths(y)
clone("ShixiangWang/tinyscholar", y, gitee = TRUE)
#> cloning into '/var/folders/bj/nw1w4g1j37ddpgb6zmh3sfh80000gn/T//Rtmp0sCShM/tinyscholar'...
#> Receiving objects:   1% (4/313),   19 kb
#> Receiving objects:  11% (35/313),   27 kb
#> Receiving objects:  21% (66/313),  147 kb
#> Receiving objects:  31% (98/313),  331 kb
#> Receiving objects:  41% (129/313),  411 kb
#> Receiving objects:  51% (160/313),  539 kb
#> Receiving objects:  61% (191/313),  595 kb
#> Receiving objects:  71% (223/313),  642 kb
#> Receiving objects:  81% (254/313),  650 kb
#> Receiving objects:  91% (285/313),  658 kb
#> Receiving objects: 100% (313/313),  719 kb, done.
```

### Download GitHub/Gitee repo release or archive file

``` r
x <- tempdir()
download("ShixiangWang/tinyscholar", destdir = x)
#> Downloading repo archive...
dir(x)
#> [1] "ezcox"       "master.zip"  "tinyscholar"
```
