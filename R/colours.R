#' HUD Colours
#'
#' ggplot2 colour scale generation function for HUD styles.
#' @name hud_colours
#' @param medium "print" (white background theme) or "web" (dark background theme)
#' @param colours Required number of colours
#' @keywords hud ggplot2 colours
#' @export
#' @examples
#' hud_colours(medium = "web", colours = 2)

library(ggplot2)

hud_colours <- function(medium = "web", colours = 2) {

  if (medium == "print") {
    if (colours <= 2) {
      palette <- c("#003E52","#FFC04A")
    }
    else if (colours <= 3) {
      palette <- c("#003E52","#A4343E", "#00826E")
    }
    else {
      stop("Sorry I don't have that many colours! (Make your own with: [scale_color_manual(values = palette)]!")
    }
  }
  else if (medium == "web") {
    if (colours <= 2) {
      palette <- c("#FFC04A","#62B6F3")
    }
    else if (colours <= 3) {
      palette <- c("#FFC04A","#A4343E", "#00826E")
    }
    else {
      stop("Sorry I don't have that many colours! (Make your own with: [scale_color_manual(values = palette)]!")
    }
  }
  else {
    stop("Invalid medium (Expected: 'web' or 'print')!")
  }
  return(scale_color_manual(values = palette))
}
