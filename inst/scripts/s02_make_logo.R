library(hexSticker)
library(showtext)
library(magrittr)
library(dplyr)
library(ggplot2)

font_add_google("Gochi Hand", "gochi")
font_add("consolas", regular = "consola.ttf", bold = "consolab.ttf",
         italic = "consolai.ttf", bolditalic = "consolaz.ttf")

## Automatically use showtext to render text for future devices
showtext_auto()

runoff_data %>%
  dplyr::mutate(
    flood_type = c(rep('Flood_1', 400), rep('Flood_2', 344)) # nolint
  ) %>%
  filter(flood_type == 'Flood_2') %>%
  ggplot(aes(x=time, Q)) + theme_test() +
  geom_rainfallRunoff(
    aes(runoff=Q, prcp=prcp, color=flood_type), coef=15, yint = 1200,
    # rainfall.color='#80b1d3', rainfall.fill = '#80b1d3',
    rainfall.color='#1D6EB0', rainfall.fill = '#1D6EB0',
    width = 40000,
    color = '#8D2A2E',
    linewidth=1
  ) +
  scale_y_precipitation(sec.name = 'Precipitation (mm)', coef = 15) +
  scale_x_datetime(date_labels = "%m/%d") +
  theme(
    legend.position = c(0, 1),
    legend.justification = c(0, 1),
    legend.background = element_blank(),
    legend.key = element_blank(),
    axis.ticks = element_blank(),
    axis.text = element_blank(),
    axis.title = element_blank(),
    strip.background = element_blank(),
    strip.text = element_text(face = 'bold', hjust = 0)
  ) +
  labs(x = NULL) -> p

p <- p + theme_void() + theme_transparent()

sticker(
  p, package="ggRunoff", p_size=25, p_family = 'consolas', p_color = 'white',
  h_fill = '#41C6D9',
  # h_fill = '#7845D0',
  h_color = '#690813',
  s_x=1, s_y=.83, s_width=1.3, s_height=.75,
  spotlight = T, l_alpha = 0.3,
  url = 'www.github.com/cug-xyx/ggRunoff', u_color='black', u_size = 4.5, u_family = 'consolas',
  filename="inst/figures/logo.png"
)
