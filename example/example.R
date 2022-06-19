library(ggplot2)
library(showtext)
library(hud.theme)

df <- read.csv(file = "ird-kiwisaver-parsed.csv")
df$period <- as.Date(df$period)

ggplot(df, aes(x = period, y = count, color = reason)) +
geom_line(size = 1) +
hud_theme(medium = "print", layout = "big") +
hud_colours(medium = "print", colours = 2)
