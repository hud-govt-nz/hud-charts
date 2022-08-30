library(devtools)
install_github("hud-govt-nz/hud-charts", force = TRUE)

library(tidyverse)
library(showtext)
library(hud.charts)

# Last five years
targ_period <- c(Sys.Date() - 365 * 5, Sys.Date())

# Set series order (most important series first)
s <- c("Rest of South Island" = "CPIM.SE6041F",
       "Canterbury" = "CPIM.SE5041F",
       "Rest of North Island" = "CPIM.SE3041F",
       "Wellington" = "CPIM.SE2041F",
       "Auckland" = "CPIM.SE1041F",
       "National" = "CPIM.SE9041F")

# Read and clean
df_reg <-
  make_long(sample_wide, s, x = "period") %>%
  filter(period >= targ_period[1], period <= targ_period[2]) %>%
  make_regional("National", r = "series", x = "period", y = "value")

# Plot
plot_regional_lines(
  df_reg,
  ncols = 2,
  r = "region",
  palette_type = "single", # Single (single focus, with optional secondary series, e.g. [Seasonally adjusted, raw])
  medium = "print",
  layout = "big") +
labs(
  title = "Rental Price Index change",
  subtitle = "How have rental prices changed, compared with 12 months ago?",
  caption = "Source: StatsNZ (CPIM.SE9041F)") +
scale_x_date(
  name = NULL,
  limits = targ_period,
  date_labels = "%b %Y") +
scale_y_continuous(
  name = NULL,
  limits = c(NA, NA),
  labels = scales::label_percent(scale = 100))


# # Full version for reference, same results as above
# # Read and clean
# df_long <-
#   sample_wide %>%
#   select(period, all_of(s)) %>% # Selects target columns using pretty names
#   pivot_longer(-period, names_to = "series") %>%
#   mutate(period = as.Date(period), # Must use date types
#          series = factor(series, levels = names(s))) %>% # Uses target columns order
#   filter(period >= targ_period[1], period <= targ_period[2])
#
# n_df <-
#   filter(df_long, series == "National")
#
# df_reg <-
#   filter(df_long, series != "National") %>%
#   left_join(n_df, by = "period", suffix = c("", "_y")) %>%
#   select(period, region = series, c("Region" = value, "National" = value_y)) %>%
#   pivot_longer(-c(period, region), names_to = "series") %>%
#   mutate(series = factor(series, levels = c("National", "Region")))
#
# # Plot using HUD themes and colours
# ggplot(df_reg,
#        aes(color = series, x = period, y = value)) +
# geom_line(size = 1) +
# facet_wrap(df_reg$region, ncol = 2) +
# hud_theme(
#   medium = "print",
#   layout = "big") +
# theme(panel.grid.major.y = element_line(color = "#E6E6E6")) +
# hud_colours(
#   nlevels(df_reg$series),
#   palette_type = "single",
#   medium = "print")  +
# labs(
#   title = "Rental Price Index change",
#   subtitle = "How have rental prices changed, compared with 12 months ago?",
#   caption = "Source: StatsNZ (CPIM.SE9041F)") +
# scale_x_date(
#   name = NULL,
#   limits = targ_period,
#   date_labels = "%b %Y") +
# scale_y_continuous(
#   name = NULL,
#   limits = c(NA, NA),
#   labels = scales::label_percent(scale = 100))
