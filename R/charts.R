library(tidyverse)
library(ggplot2)
library(showtext)

#' Sample wide data
#'
#' Housing register data in wide format
#' @name sample_wide
#' @export
sample_wide <- read_csv("R/sample-data/rental-price-index-wide.csv", show_col_types = FALSE)

#' Wide-to-Long
#'
#' Pivots wider, parses dates, renames and reorders levels for series.
#' @name make_long
#' @param df_wide Wide dataframe (must have a period column)
#' @param s Named vector containing levels for the series column, in the desired order
#' @param x Column name for the period column
#' @keywords hud clean long
#' @export
#' @examples
#' make_long(df_wide, c("Seasonal" = "BLDM.SFTZ1100A1S", "Actual" = "BLDM.SFTZ1100A1A"))
make_long <- function(df_wide, s = NULL, x = "period") {
  df <- rename(df_wide, period = x)
  if (is.null(s)) {
    s <- df %>% select(-period) %>% colnames()
    names(s) <- s
  }
  df %>%
    select(period, all_of(s)) %>%
    pivot_longer(-period, names_to = "series") %>%
    # Line layering puts the first line at the bottom,
    # which means we have to reverse the order from the input...
    mutate(period = as.Date(period),
           series = factor(series, levels = rev(names(s))))
}

#' Long-to-regional
#'
#' Using one series as a national baseline, create regional/national pairs for each region.
#' Region will go in region column, regional/national will go into a series column.
#' @name make_regional
#' @param df_long Long dataframe
#' @param r Column name for the region column
#' @param x Column name for the period column
#' @param y Column name for the value column
#' @keywords hud clean regional
#' @export
#' @examples
#' make_regional(df_long)
make_regional <- function(
    df_long, national = "National", r = "region",
    x = "period", y = "value") {
  s <- c("Region" = paste0(y, ""), "National" = paste0(y, "_y"))
  df <- rename(df_long, region = r)
  n_df <- filter(df, region == national)
  df %>%
    filter(region != national) %>%
    left_join(n_df, by = x, suffix = c("", "_y")) %>%
    select(x, region, s) %>%
    pivot_longer(-c(x, region), names_to = "series") %>%
    mutate(series = factor(series, levels = rev(names(s))))
}

#' HUD Line Chart
#'
#' Pre-made ggplot2 line charts using HUD styles.
#' @name plot_line
#' @param df_long Dataframe produced by make_long() (e.g. series, period, value)
#' @param palette_type How to colour the series ("single", "double", "categorical")
#' @param medium "web" (dark background theme) or "print" (white background theme)
#' @param layout "big" or "small
#' @param c Name of column to use for colour
#' @param x Name of column to use for x-axis
#' @param y Name of column to use for y-axis
#' @keywords hud ggplot2 charts
#' @export
#' @examples
#' plot_long(df_long, palette_type = "double")
plot_line <- function(
    df_long,
    palette_type = "categorical", medium = "print", layout = "big",
    c = "series", x = "period", y = "value") {
  ggplot(df_long,
    aes(color = !!sym(c), x = !!sym(x), y = !!sym(y))) +
    geom_line(size = 1) +
    hud_theme(medium, layout) +
    hud_colours(nlevels(df_long[[c]]), palette_type, medium)
}

#' HUD Regional Line Charts
#'
#' Pre-made ggplot2 small multiples (facets) line charts using HUD styles.
#' @name plot_regional_lines
#' @param df_long Dataframe produced by make_regional() (e.g. region, series, period, value)
#' @param ncols Number of columns for small multiples (facets) grid
#' @param r Name of column to use for region
#' @param palette_type How to colour the series ("single", "double", "categorical")
#' @param medium "web" (dark background theme) or "print" (white background theme)
#' @param layout "big" or "small
#' @param c Name of column to use for colour
#' @param x Name of column to use for x-axis
#' @param y Name of column to use for y-axis
#' @keywords hud ggplot2 charts
#' @export
#' @examples
#' plot_reg(df_reg, palette_type = "double")
plot_regional_lines <- function(
    df_reg, ncols = 1, r = "region",
    palette_type = "categorical", medium = "print", layout = "big",
    c = "series", x = "period", y = "value") {
  plot_line(df_reg, palette_type, medium, layout, c, x, y) +
    facet_wrap(df_reg[[r]], ncol = ncols) +
    theme(panel.grid.major.y = element_line(color = "#E6E6E6"))
}
