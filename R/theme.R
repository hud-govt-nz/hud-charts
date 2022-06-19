#' HUD Themes
#'
#' ggplot2 theme generation function for HUD styles.
#' @name hud_theme
#' @param medium "web" (dark background theme) or "print" (white background theme)
#' @param layout "big" or "small
#' @keywords hud ggplot2 themes
#' @export
#' @examples
#' hud_theme(medium = "web", layout = "big")

library(ggplot2)
library(showtext)

# This is a crummy way to find the font path, but here() and sys.frame(1)$ofile don't work
find_path <- function() {
  for (lp in .libPaths()) {
    p <- paste(lp, "hud.theme/fonts", sep = "/")
    if (dir.exists(p)) {
      return(p)
    }
  }
}

load_fonts <- function() {
  font_path <- find_path()
  fonts <- list(
    c("National", "FiraSans-Regular.ttf"),
    c("National Black", "FiraSans-Black.ttf"),
    c("National Thin", "FiraSans-Thin.ttf"),
    c("National ExtraLight", "FiraSans-ExtraLight.ttf"),
    c("National Light", "FiraSans-Light.ttf"),
    c("National Medium", "FiraSans-Medium.ttf"),
    c("National SemiBold", "FiraSans-SemiBold.ttf"),
    c("National Bold", "FiraSans-Bold.ttf"),
    c("National ExtraBold", "FiraSans-ExtraBold.ttf")
  )
  for (f in fonts) {
    font_add(f[1], paste(font_path, f[2], sep = "/"))
  }
  showtext_auto()
}

hud_theme <- function(medium = "web", layout = "big") {
  load_fonts()

  # Base
  b <- theme(text             = element_text(family = "National Light"),
             title            = element_text(family = "National"),
             plot.title       = element_text(family = "National Bold"),
             axis.ticks       = element_blank(),
             panel.background = element_blank(),
             panel.border     = element_blank(),
             panel.grid       = element_blank(),
             legend.title     = element_blank(),
             legend.key       = element_blank())

  # Medium
  if (medium == "web") {
    c <- theme(plot.background    = element_rect(fill = "#00232F"),
               legend.background  = element_rect(fill = "#00232F"),
               text               = element_text(color = "#FFFFFF"),
               axis.text          = element_text(color = "#FFFFFF"),
               plot.title         = element_text(color = "#FFFFFF"),
               plot.caption       = element_text(color = "#CCCCCC"),
               panel.grid.major.y = element_line(color = "#666666"))
  }
  else if (medium == "print") {
    c <- theme(plot.background    = element_rect(fill = "#FFFFFF"),
               legend.background  = element_rect(fill = "#FFFFFF"),
               text               = element_text(color = "#222423"),
               axis.text          = element_text(color = "#222423"),
               plot.title         = element_text(color = "#003E52"),
               plot.caption       = element_text(color = "#909090"),
               panel.grid.major.y = element_line(color = "#F1F1F1"))
  }
  else {
    stop("Invalid medium (Expected: 'web' or 'print')!")
  }

  # Layout
  if (layout == "big") {
    l <- theme(text            = element_text(size = 14),
               plot.title      = element_text(size = 24),
               plot.caption    = element_text(size = 10),
               plot.margin     = margin(t = 16, r = 12, b = 8, l = 12),
               axis.title.x    = element_text(margin = margin(t = 8)),
               axis.title.y    = element_text(margin = margin(r = 12)),
               legend.position = "bottom",
               legend.text     = element_text(margin = margin(r = 12)))
  }
  else if (layout == "small") {
    l <- theme(text            = element_text(size = 12),
               plot.title      = element_text(size = 24),
               plot.caption    = element_text(size = 9),
               plot.margin     = margin(t = 16, r = 12, b = 8, l = 12),
               axis.title.x    = element_text(margin = margin(t = 8)),
               axis.title.y    = element_text(margin = margin(r = 12)),
               legend.position = "bottom",
               legend.text     = element_text(margin = margin(r = 12)))
  }
  else {
    stop("Invalid layout (Expected: 'big' or 'small')!")
  }
  return(b + c + l)
}
