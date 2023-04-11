GeomPrecipitation <- ggproto(
  "GeomPrecipitation", GeomTile,

  default_aes = aes(
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

#' Title
#'
#' @param mapping
#' @param data
#' @param stat
#' @param position
#' @param ...
#' @param linejoin
#' @param na.rm
#' @param show.legend
#' @param inherit.aes
#'
#' @export
geom_precipitation <- function(mapping = NULL, data = NULL, stat = "identity",
                               position = "identity", ..., linejoin = "mitre",
                               na.rm = FALSE, show.legend = NA, inherit.aes = TRUE) {
  layer(
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
