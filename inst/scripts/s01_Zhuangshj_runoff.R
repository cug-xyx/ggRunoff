library(data.table)
library(ggplot2)
library(magrittr)
library(dplyr)

# library(ggRunoff) # private
devtools::load_all('.') # R package `ggRunoff` environment

fread('I:/order_data/Zhuangshj/博罗站.csv') %>%
  mutate(time = lubridate::ymd(time)) %>%
  ggplot(aes(time, pr)) + theme_bw() +
  geom_precipitation(yint = 6000, coef=25, color='blue') +
  geom_line(aes(y=streamflow)) +
  scale_y_precipitation(coef=25, sec.name = '降雨 (mm)') +
  labs(y = expression("流量" * 'm'^3 / "s"), x = NULL)


ggsave('inst/figures/20230627-Zhuangshj.jpg', dpi = 300, height = 4, width = 7)


