library(data.table)
library(ggplot2)
library(magrittr)

runoff_data %>%
  dplyr::mutate(
    flood_type = c(rep('Flood_1', 400), rep('Flood_2', 344))
  ) %>%
  ggplot(aes(x=time, Q)) + theme_test() +
  geom_rainfallRunoff(
    aes(runoff=Q, prcp=prcp, color=flood_type), coef=20,
    rainfall.color='blue', rainfall.fill = 'blue', linewidth=0.5
  ) +
  scale_y_precipitation(sec.name = 'Precipitation', coef = 20) +
  facet_wrap(~flood_type, scales = 'free') +
  theme(
    legend.position = c(0, 1),
    legend.justification = c(0, 1),
    legend.background = element_blank(),
    legend.key = element_blank()
  )

ggsave('inst/figures/20230411-geom_runoff.jpg', dpi = 300, height = 3, width = 9)
