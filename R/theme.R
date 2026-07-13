load_fonts <- function() {
  font_path <- find_path()
  fonts <- list(
    c("Ancizar", "/fonts/AncizarSerif-Regular.ttf"),
    c("Ancizar Black", "/fonts/AncizarSerif-Black.ttf"),
    c("Ancizar Light", "/fonts/AncizarSerif-Light.ttf"),
    c("Ancizar Medium", "/fonts/AncizarSerif-Medium.ttf"),
    c("Ancizar SemiBold", "/fonts/AncizarSerif-SemiBold.ttf"),
    c("Ancizar Bold", "/fonts/AncizarSerif-Bold.ttf")
  )
  for (f in fonts) {
    sysfonts::font_add(f[1], paste0(font_path, f[2]))
  }
  showtext::showtext_auto()
}

#' HUD Theme
#'
#' ggplot2 theme generator using HUD styles.
#' @name hud_theme
#' @param medium "web" (dark background theme) or "print" (white background theme)
#' @param layout "big" or "small
#' @keywords hud ggplot2 themes
#' @export
#' @examples
#' hud_theme(medium = "web", layout = "big")
hud_theme <- function(medium = "web", layout = "big") {
  load_fonts()

  # Base
  b <- theme(text             = element_text(family = "Ancizar Light"),
             title            = element_text(family = "Ancizar"),
             plot.title       = element_text(family = "Ancizar Bold"),
             axis.ticks       = element_blank(),
             panel.background = element_blank(),
             panel.border     = element_blank(),
             panel.grid       = element_blank(),
             strip.background = element_blank(),
             strip.text.x     = element_text(hjust = 1),
             legend.title     = element_blank(),
             legend.key       = element_blank())

  # Medium
  if (medium == "web") {
    c <- theme(plot.background    = element_rect(fill = "#103039"),
               legend.background  = element_rect(fill = "#103039"),
               text               = element_text(color = "#FFFFFF"),
               axis.text          = element_text(color = "#FFFFFF"),
               axis.ticks.x       = element_line(color = "#BFBFBF"),
               plot.title         = element_text(color = "#FFFFFF"),
               plot.caption       = element_text(color = "#CCCCCC"),
               panel.grid.major.y = element_line(color = "#333333"))
  }
  else if (medium == "print") {
    c <- theme(plot.background    = element_rect(fill = "#FFFFFF"),
               legend.background  = element_rect(fill = "#FFFFFF"),
               text               = element_text(color = "#103039"),
               axis.text          = element_text(color = "#103039"),
               axis.ticks.x       = element_line(color = "#626463"),
               plot.title         = element_text(color = "#103039"),
               plot.caption       = element_text(color = "#909090"),
               panel.grid.major.y = element_line(color = "#F1F1F1"))
  }
  else stop("Invalid medium (Expected: 'web' or 'print')!")

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
  else stop("Invalid layout (Expected: 'big' or 'small')!")
  return(b + c + l)
}
