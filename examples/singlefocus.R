library(devtools)
install_github("hud-govt-nz/hud-charts", force = TRUE)

library(tidyverse)
library(hud.charts)

# Last five years
targ_period <- c(Sys.Date() - 365 * 5, Sys.Date())

# Set series order (most important series first)
s <- c("National" = "CPIM.SE9041F",
       "Auckland" = "CPIM.SE1041F")

# Read and clean
df_long <-
  charts_test_data() %>%
  make_long(s, x = "period") %>%
  filter(period >= targ_period[1], period <= targ_period[2])

# Plot using HUD themes and colours
plot_line(
  df_long,
  palette_type = "double", # Change colours here
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
#   charts_test_data() %>%
#   select(period, all_of(s)) %>% # Selects target columns using pretty names
#   pivot_longer(-period, names_to = "series") %>%
#   mutate(period = as.Date(period), # Must use date types
#          series = factor(series, levels = names(s))) %>% # Uses target columns order
#   filter(period >= targ_period[1], period <= targ_period[2])
#
# # Plot using HUD themes and colours
# ggplot(df_long,
#        aes(color = series, x = period, y = value)) +
# geom_line(size = 1) +
# hud_theme(
#   medium = "print",
#   layout = "big") +
# hud_colours(
#   nlevels(df_long$series),
#   palette_type = "double",
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
