# HUD theme and colours for ggplot2
**CAUTION: This repo is public. Do not include sensitive data or key materials.**

### Installation from Github (Recommended)
You'll need `devtools::install_github` to install the package:
```
library(devtools)
install_github("hud-govt-nz/public-hud-themes")
```


### Local installation
You can also just download it and use it locally, but you'll have to update the files manually.

```
library(devtools)
install_local("[PATH GOES HERE]/public-hud-themes")
```


### Usage
To use the package (NOTE: You'll need to load `showtext` as well). See `example/example.R`:
```
library(ggplot2)
library(showtext)
library(hud.theme)

df <- read.csv(file = "ird-kiwisaver-parsed.csv")
df$period <- as.Date(df$period)

ggplot(df, aes(x = period, y = count, color = reason)) +
geom_line(size = 1) +
hud_theme(medium = "print", layout = "big") +
hud_colours(medium = "print", colours = 2)
```


### Maintaining this package
If you make changes to this package, you'll need to rerun document from the root directory to update all the R generated files.
```
library("devtools")
install_github("klutometis/roxygen")
library(roxygen2)

document()
```
