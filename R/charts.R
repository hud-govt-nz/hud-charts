library(ggplot2)
library(showtext)

source("R/colours.R")
source("R/theme.R")

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
