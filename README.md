# HUD charting tools
**CAUTION: This repo is public. Do not include sensitive data or key materials.**

## Installation
You'll need `devtools::install_github` to install the package:
```R
devtools::install_github("hud-govt-nz/hud-charts")
```


## Usage
There are pre-configured charts:
* `plot_line`: Simple line chart
* `plot_regional_lines`: Regional small multiples (facets)

They rely on the the themes and colours, which you can also access separately. If you're doing complicated
things, you'll want to do this:
* `hud_theme`: Controls sizes, fonts, base colours etc - you'll always want this
* `hud_colours`: Returns a colour scale that matches the theme

A few options are reference by most of the functions.

#### medium
* print: Dark on white background
* web: Light on dark background

#### layout
* big: Normally what you want
* small: Small charts to insert inline

#### palette_type
* single: Focus on a primary series, with an optional secondary series (e.g. [Seasonally adjusted, actual])
* double: Compare a pair of series (e.g. [Auckland, Wellington])
* categorical: Categories


## Examples
A full set of examples are provided in `example/`. This is a basic workflow using the pre-made charts:
```R
library(tidyverse)
library(hud.charts)

# Last five years
targ_period <- c(Sys.Date() - 365 * 5, Sys.Date())

# Set series order (most important series first)
s <- c("Rest of South Island" = "CPIM.SE6041F",
       "Canterbury" = "CPIM.SE5041F",
       "Rest of North Island" = "CPIM.SE3041F",
       "Wellington" = "CPIM.SE2041F",
       "Auckland" = "CPIM.SE1041F")

# Read and clean
df_long <-
  charts_test_data() %>%
  make_long(s, x = "period") %>%
  filter(period >= targ_period[1], period <= targ_period[2])

# Plot using HUD themes and colours
plot_line(
  df_long,
  palette_type = "categorical", # Change colours here
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
```

If you're doing more complicated stuff, you will want to generate the charts yourself
then add `hud_theme()` and `hud_colours()` separately, e.g.:
```R
library(tidyverse)
library(hud.charts)

# Last five years
targ_period <- c(Sys.Date() - 365 * 5, Sys.Date())

# Set series order (most important series first)
s <- c("Rest of South Island" = "CPIM.SE6041F",
       "Canterbury" = "CPIM.SE5041F",
       "Rest of North Island" = "CPIM.SE3041F",
       "Wellington" = "CPIM.SE2041F",
       "Auckland" = "CPIM.SE1041F")

# Read and clean
df_long <-
  charts_test_data() %>%
  select(period, all_of(s)) %>% # Selects target columns using pretty names
  pivot_longer(-period, names_to = "series") %>%
  mutate(period = as.Date(period), # Must use date types
         series = factor(series, levels = names(s))) %>% # Uses target columns order
  filter(period >= targ_period[1], period <= targ_period[2])

# Plot using HUD themes and colours
ggplot(df_long,
       aes(color = series, x = period, y = value)) +
geom_line(size = 1) +
hud_theme(
  medium = "print",
  layout = "big") +
hud_colours(
  nlevels(df_long$series),
  palette_type = "categorical",
  medium = "print")  +
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
```


## Maintaining this package
If you make changes to this package, you'll need to rerun document from the root directory to update all the R generated files.
```R
library(roxygen2)
roxygenise()
```
