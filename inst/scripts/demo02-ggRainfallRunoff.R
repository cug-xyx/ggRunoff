library(data.table)
library(magrittr)

ggRainfallRunoff <- function(
    d, time='time', runoff='Q', rainfull='prcp',
    rainfall.color='#80b1d3', prcp.color='black',
    coef = 10, yint = NA
) {
  d$time <- d[[time]]
  d$Q <- d[[runoff]]
  d$prcp <- d[[rainfull]]
  d <- dplyr::select(d, c(time, Q, prcp))
  d

  p <- ggplot(d, aes(time, Q))
  if (is.na(yint)) {
    p <- p +
      geom_rainfallRunoff(
        aes(runoff=Q, prcp=prcp), coef=coef,
        rainfall.color=rainfall.color, rainfall.fill = rainfall.color,
        color = prcp.color, linewidth=0.4
      )
  } else {
    p <- p + geom_rainfallRunoff(
      aes(runoff=Q, prcp=prcp), coef=coef, yint = yint,
      rainfall.color=rainfall.color, rainfall.fill = rainfall.color,
      color = prcp.color, linewidth=0.4
    )
  }
    p <- p +
    scale_y_precipitation(sec.name = NULL, coef = coef)# +
    # scale_x_datetime(date_labels = "%m/%d") +
    # theme_bw() +
    # theme(
    #   axis.ticks = element_blank(),
    #   axis.text.y.right = element_text(color=rainfall.color),
    #   axis.text = element_text(color = 'black'),
    #   axis.text.x = element_text(angle = 60, hjust = 1),
    #   legend.background = element_blank(),
    #   legend.key = element_blank(),
    #   strip.background = element_blank(),
    #   strip.text = element_text(face = 'bold', hjust = 0)
    # ) +
    # # facet_wrap(~id, scales = 'free') +
    # labs(x = NULL, y = NULL)

  p
}


data.table(runoff_data) %>%
  ggRainfallRunoff(
    rainfall.color = '#80b1d3', prcp.color = 'orange',
    yint = 1200, coef = 10
  ) +
  theme_bw()

