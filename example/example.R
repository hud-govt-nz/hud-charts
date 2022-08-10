library(devtools)
install_github("hud-govt-nz/public-hud-themes", force = TRUE)

library(tidyverse)
library(ggplot2)
library(showtext)
library(hud.theme)

# Set series order (most important series **last**)
s <- c("Business purposes" = "BUS",
       "Investors" = "INV",
       "Other owner occupiers" = "OTH",
       "First home buyers" = "FHB",
       "All borrower types" = "ALL")
# Last five years
targ_period <- c(Sys.Date() - 365 * 5, Sys.Date())

# Read and clean
df <- read.csv("rbnz-new_mortgages.csv") %>%
      select(period, all_of(s)) %>% # Selects target columns using pretty names
      pivot_longer(-period, names_to = "series") %>%
      mutate(period = as.Date(period), # Must use date types
             series = factor(series, levels = names(s))) %>% # Uses target columns order
      filter(period >= targ_period[1],
             period <= targ_period[2])

# Plot
ggplot(df, aes(x = period, y = value, color = series)) +
geom_line(size = 1) +
labs(
  title = "New residential mortgage borrowing",
  subtitle = "Who is borrowing for new residential mortages?",
  caption = "Source: RBNZ (LVRN.MMB2)") +
scale_x_date(
  name = NULL,
  limits = targ_period,
  date_labels = "%b %Y") +
scale_y_continuous(
  name = NULL,
  limits = c(0, NA),
  labels = scales::label_number(scale = 1)) +
hud_colours(medium = "print", colours = 5) +
hud_theme(medium = "print", layout = "big")
