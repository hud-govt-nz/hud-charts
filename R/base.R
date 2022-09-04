# This is a crummy way to find the font path, but here() and sys.frame(1)$ofile don't work
find_path <- function() {
  for (lp in .libPaths()) {
    p <- paste0(lp, "/hud.charts")
    if (dir.exists(p)) return(p)
  }
  stop("Cannot find library path!")
}

#' Sample data
#' @name charts_test_data
#' @export
charts_test_data <- function() {
  find_path() %>%
  paste0("/test/rental-price-index-wide.csv") %>%
  read_csv(show_col_types = FALSE)
}
