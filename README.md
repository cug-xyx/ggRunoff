# ggRunoff

## Installation

You can install the development version of `ggRunoff` from [GitHub](https://github.com/) with:

```R
# install.packages("remotes")
remotes::install_github("cug-xyx/ggRunoff")
```

## Example

### Flood process line

```R
library(magrittr)
library(ggRunoff)
library(ggplot2)

# load runoff data
data("runoff_data", package = 'ggRunoff')

# get runoff data
dt_runoff <- dplyr::mutate(runoff_data, rof_type = c(rep('flood_1', 400), rep('flood_2', 344))) 
#' the `yint` must be the `maximum` of the plot data
ggplot(dt_runoff, aes(time, prcp)) +
  geom_precipitation(yint=1300, coef=20) +
  geom_line(aes(y=Q)) +
  scale_y_precipitation(coef = 20) +
  facet_wrap(~rof_type, scales = 'free')
ggsave('inst/figures/20230411-geom_runoff.jpg', dpi = 300, height = 4, width = 9)
```

![geom_runoff](inst/figures/20230411-geom_runoff.jpg)

## TODO

- [ ] `scale_y_precipitation`.
- [ ] `facet_wrap` or `facet_grid`, i.e., grouping for calculating `yint`
- [ ] `theme_runoff_prcp`, including `aixs.line.y.right` and other theme settings.
- [ ] Based the runoff and precipitation, calculate the `yint` automatically. Noted that `yint` must larger than the maximum of runoff (y) data.

```R
# times as scaleFactor
scaleFactor <- max(mtcars$cyl) / max(mtcars$hp)
```

