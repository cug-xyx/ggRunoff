GeomRainfallRunoff <- ggplot2::ggproto(
  "GeomRainfallRunoff", ggplot2::GeomLine,

  default_aes = ggplot2::aes(
    colour = "black",
    fill = 'black',
    linewidth = 0.1,
    linetype = 1,
    alpha = NA,
    width = NA,

    rainfall.color = 'blue',
    rainfall.fill = 'blue',
    yint = NA, coef = 1
  ),

  # 必要的aes参数
  required_aes = c("x", "runoff", "prcp"),

  # Transform the data before any drawing takes place
  setup_data = function(data, params) {
    prcp_max = max(data$prcp, na.rm=T)
    runoff_max = max(data$runoff, na.rm=T)

    data$width <- data$width %||% params$width %||% resolution(data$x, FALSE)
    data$yint <- params$yint %||% pmax(prcp_max, runoff_max, na.rm=T)
    # 保证降雨在径流的1/3位置
    #' `不知道如何传递给 scale_y_prcp 函数中`
    # data$coef <- params$coef %||% (runoff_max * 1/3 / prcp_max) %||% 1
    data$coef <- params$coef %||%  1

    # color
    data$rainfall.fill = params$rainfall.fill
    data$rainfall.color = params$rainfall.color

    # 为了让panel中囊括全部范围的y
    data$y = data$runoff
    transform(
      data,
      xmin = x - width/2, xmax = x + width/2, width = NULL,
      ymin = yint - prcp * coef, ymax = yint
    )
  },

  draw_panel = function(data, panel_params, coord) {
    df_rainfall = data
    # prepare rainfall data
    data$y = data$runoff

    # prepare runoff data
    df_rainfall$fill = data$rainfall.fill
    df_rainfall$colour = data$rainfall.colour
    df_rainfall$linetype = 'solid'
    df_rainfall$linewidth = 0.1

    grid::gList(
      ggplot2::GeomLine$draw_panel(data, panel_params, coord),
      ggplot2::GeomTile$draw_panel(df_rainfall, panel_params, coord)
    )
  }

  #' `直接改变 data，或许可以避免使用coef`
  # compute_group = function(data, scales, fun_slope = slope_mk) {
  #   cal_slope(data, fun_slope)
  # }

  #' `draw_panel 和 draw_group 的区别`
  # draw_group = function(self, data, panel_params, coord,
  #                       fun_slope = slope_mk, na.rm = FALSE) {
  #   df <- cal_slope(data, fun_slope)
  #   GeomAbline$draw_panel(df, panel_params, coord)
  # }
)

#' Draw precipitation bar on the top of the panel
#'
#' @inheritParams ggplot2::geom_tile
#' @param rainfall.color color of rainfall
#' @param rainfall.fill fill of rainfall
#' @param coef Multiplier for the second axis to be expanded
#'
#' @importFrom ggplot2 layer
#' @importFrom rlang list2
#'
#' @export
geom_rainfallRunoff <- function(
  mapping = NULL, data = NULL, stat = "identity",
  position = "identity", ..., linejoin = "mitre",
  na.rm = FALSE, show.legend = NA, inherit.aes = TRUE,
  rainfall.color = 'black', rainfall.fill = 'black',
  coef = 1
) {
  ggplot2::layer(
    geom = GeomRainfallRunoff,
    data = data,
    mapping = mapping,
    stat = stat,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = rlang::list2(
      na.rm = na.rm,
      rainfall.color = rainfall.color,
      rainfall.fill = rainfall.fill,
      coef = coef,
      ...
    )
  )
}
