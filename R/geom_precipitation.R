GeomPrecipitation <- ggplot2::ggproto(
  "GeomPrecipitation", ggplot2::GeomTile,

  default_aes = ggplot2::aes(
    colour = "blue",
    fill = 'blue',
    linewidth = 0.1,
    linetype = 1,
    alpha = NA,
    width = NA,

    yint = NA,
    coef = 1
  ),

  # 必要的aes参数
  required_aes = c("x", "y"),

  # Transform the data before any drawing takes place
  setup_data = function(data, params) {
    data$width <- data$width %||% params$width %||% resolution(data$x, FALSE)
    data$yint <- params$yint  %||% max(data$y)

    data$coef <- params$coef %||% 1

    transform(
      data,
      xmin = x - width/2, xmax = x + width/2, width = NULL,
      ymin = yint - y * coef, ymax = yint
    )
  }
)

#' Draw precipitation bar on the top of the panel
#'
#' @inheritParams ggplot2::geom_tile
#'
#' @importFrom ggplot2 layer
#' @importFrom rlang list2
#'
#' @export
geom_precipitation <- function(mapping = NULL, data = NULL, stat = "identity",
                               position = "identity", ..., linejoin = "mitre",
                               na.rm = FALSE, show.legend = NA, inherit.aes = TRUE) {
  ggplot2::layer(
    geom = GeomPrecipitation,
    data = data,
    mapping = mapping,
    stat = stat,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = rlang::list2(na.rm = na.rm, ...)
  )
}
