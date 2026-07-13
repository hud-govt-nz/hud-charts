#' HUD Palette
#'
#' ggplot2 colour scale generation function for HUD styles.
#' @name hud_palette
#' @param colours Required number of colours
#' @param palette_type Scheme type: "single", "double", "categorical"
#' @param medium "print" (white background theme) or "web" (dark background theme)
#' @param reverse Whether to reverse the colour scheme - on by default. This means
#' the last series (which is on the top layer of the chart) gets the first colour
#' in the palette
#' @keywords hud ggplot2 colours
#' @export
#' @examples
#' hud_palette(2, palette_type = "single", medium = "web")
hud_palette <- function(palette_size = 5, palette_type = "categorical", medium = "web", reverse = FALSE) {
  # Pick a palette
  palette <- NULL
  if (medium == "print") {
    # Focus on a primary series, with an optional secondary series
    if (palette_type == "single") {
      palette <- c("#005B73", "#AAD7DF")
    }
    # Focus on two series
    else if (palette_type == "double") {
      palette <- c("#005B73", "#652F8F")
    }
    # Categorical colours
    else if (palette_type == "categorical") {
      palette <- c("#652F8F", "#3D612D", "#0D2C6B", "#006AC6", "#005B73")
    }
  }
  else if (medium == "web") {
    if (palette_type == "single") {
      palette <- c("#8CC8D3", "#005B73")
    }
    else if (palette_type == "double") {
      palette <- c("#8CC8D3", "#35A1AD")
    }
    else if (palette_type == "categorical") {
      palette <- c("#B384D7", "#A1CC8F", "#6E98ED", "#5CB3FF", "#5CDCFF")
    }
  }

  # Validate
  if (is.null(palette)) {
    stop("No such scheme/medium!")
  }
  if (palette_size > length(palette)) {
    stop("The scheme you have selected doesn't have enough colours!")
  }

  # Produce colour scale
  palette <- palette[1:palette_size]
  if (reverse) palette <- rev(palette)
  return(palette)
}

#' HUD Colours
#'
#' ggplot2 colour scale generation function for HUD styles.
#' @name hud_colours
#' @param colours Required number of colours
#' @param palette_type Scheme type: "single", "double", "categorical"
#' @param medium "print" (white background theme) or "web" (dark background theme)
#' @param reverse Whether to reverse the colour scheme - on by default. This means
#' the last series (which is on the top layer of the chart) gets the first colour
#' in the palette
#' @keywords hud ggplot2 colours
#' @export
#' @examples
#' hud_colours(2, palette_type = "single", medium = "web")
hud_colours <- function(palette_size = 5, palette_type = "categorical", medium = "web", reverse = TRUE) {
  palette <- hud_palette(palette_size, palette_type, medium, reverse)
  guide <- NULL
  if (palette_size > 1) guide <- guide_legend(reverse = reverse)
  scale_color_manual(values = palette, guide = guide)
}
