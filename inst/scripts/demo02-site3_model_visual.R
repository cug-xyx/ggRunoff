library(data.table)
library(ggplot2)
library(cowplot)
library(ggRunoff)

make_plot <- function(
    dt, m_type = 'calibration',
    x_title = NULL, y_fst_title = 'R', y_sec_title = 'Precipitation (mm)',
    coef = 0.3, yint = 150, rainfall.width = 10,
    hide_fst_y = FALSE, hide_sec_y = FALSE,
    hide_legend = TRUE
) {
  p <-
    dt[model_type == m_type] |>
    ggplot(aes(date, R)) +
    theme_bw() +
    geom_rainfallRunoff(
      aes(runoff=R, prcp=prcp, color=type), coef = coef, yint = yint,
      rainfall.color='#80b1d3', rainfall.fill = '#80b1d3', width = rainfall.width
    ) +
    scale_x_date(expand = c(0, 0)) +
    scale_y_precipitation(sec.name = y_sec_title, coef = coef) +
    scale_color_manual(values = c('red', 'black')) +
    facet_wrap(~facet_lab, ncol=1) +
    theme(
      panel.grid = element_blank(),
      strip.background = element_blank(),
      plot.margin = unit(rep(0, 4), 'mm'),
      legend.position = 'top',
      axis.text = element_text(color='black'),
      axis.text.y.right = element_text(color='#3e89be'),
      axis.ticks.y.right = element_line(color = '#3e89be'),
      axis.title.y.right =element_text(color = '#3e89be')
    ) +
    labs(x = x_title, y = y_fst_title, color=NULL)

  if (hide_sec_y) {
    p <- p + theme(axis.text.y.right = element_blank(),
                   axis.ticks.y.right = element_blank())
  }
  if (hide_fst_y) {
    p <- p + theme(axis.text.y.left = element_blank(),
                   axis.ticks.y.left = element_blank())
  }
  if (hide_legend) p <- p + theme(legend.position = 'none')

  p
}

p_calib <- make_plot(
  st3_data, m_type = 'calibration',
  y_sec_title = NULL, hide_sec_y = T, y_fst_title = 'R (mm)')
p_valid <- make_plot(
  st3_data, m_type = 'validation', y_fst_title = NULL, hide_fst_y = T)
p_legend <- make_plot(st3_data, hide_legend = FALSE) |> get_legend()

ggdraw() +
  draw_plot(p_calib, x=0, y=0.05, width = 0.7, height = 0.9) +
  draw_plot(p_valid, x = 0.7, y=0.05, width = 0.3, height = 0.9) +
  draw_plot(p_legend, x=0.5, y=0.95, height = 0.05, width = 0.1) +
  cowplot::draw_label('Date', x=0.5, y=0.01, vjust = 0, size = 11)

ggsave('inst/figures/20230804-Renmx.jpg', dpi = 600, height = 4, width = 8)
