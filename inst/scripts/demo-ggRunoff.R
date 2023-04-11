library(data.table)
library(ggplot2)
library(magrittr)


#' the `yint` must be the `maximum` of the plot data
runoff_data %>%
  dplyr::mutate(
    rof_type = c(rep('flood_1', 400), rep('flood_2', 344))
  ) %>%
  ggplot(aes(time, prcp)) +
  geom_precipitation(yint=1300, coef=20) +
  geom_line(aes(y=Q)) +
  scale_y_precipitation(coef = 20) +
  facet_wrap(~rof_type, scales = 'free')
ggsave('inst/figures/20230411-geom_runoff.jpg', dpi = 300, height = 4, width = 9)
