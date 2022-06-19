# HUD theme and colours for ggplot2

### Installation from Github (Recommended)
To use this library from the Github source, you'll need:
1. Github access to `hud-govt-nz/hud-themes` [LINK](https://github.com/hud-govt-nz/hud-themes).
2. A Github [Personal Access Token](https://github.com/settings/tokens). Check the `repo` (full control of private repositories) access.

You'll need `devtools::install_github` to install the package:
```
library(devtools)
install_github("hud-govt-nz/hud-themes", auth_token="[TOKEN GOES HERE]")
```

I'm working on getting the IT folks to allow us to make repos public. This would mean we can do the same thing without a PAT.


### Local installation
You can also just download it and use it locally, but you'll have to update the files manually.

```
library(devtools)
install_local("[PATH GOES HERE]/hud.theme")
```


### Usage
To use the package (NOTE: You'll need to load `showtext` as well):
```
library(ggplot2)
library(showtext)
library(hud.theme)

df <- read.csv(file = "temp/ird-kiwisaver-parsed.csv")
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
