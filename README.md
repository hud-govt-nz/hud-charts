# HUD charting tools
**CAUTION: This repo is public. Do not include sensitive data or key materials.**

### Installation from Github (Recommended)
You'll need `devtools::install_github` to install the package:
```
library(devtools)
install_github("hud-govt-nz/hud-charts")
```


### Local installation
You can also just download it and use it locally, but you'll have to update the files manually.

```
library(devtools)
install_local("[PATH GOES HERE]/hud-charts")
```


### Usage
To use the package (NOTE: You'll need to load `showtext` as well). See `example/example.R`:
```
library(ggplot2)
library(showtext)
library(hud.charts)

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
install.packages("roxygen2")
roxygenise()
```

I had real problems installing `roxygen2`, because there's a problem with the upstream library `cli`. It's been fixed, but it's not in the CRAN version as of 29-08-2022. You might need the Github version:
```
library(devtools)
install_github("r-lib/cli")
install_github("r-lib/roxygen2")
library(cli)
library(roxygen2)
roxygenise()
```
