#' Show second axis
#'
#' @inheritParams ggplot2::scale_y_continuous
#' @param coef Multiplier for the second axis to be expanded
#' @param sec.name axis name of second axis
#'
#' @import ggplot2
#'
#' @export
scale_y_precipitation <- function (
  name = waiver(), breaks = waiver(), minor_breaks = waiver(),
  n.breaks = NULL, labels = waiver(), limits = NULL, expand = c(0, 0),
  na.value = NA_real_, trans = "identity", guide = waiver(), position = "left",
  sec.axis = waiver(),
  coef = 1, sec.name = 'second axis',
  ...
) {
  # if missing sec.axis
  if (length(sec.axis) == 0) {
    sec.axis = ggplot2::sec_axis(
      name = sec.name,
      trans = ~ (max(.) - .) / coef,
      labels = function(x) x,
    )
  }
  # coef = data$coef
  ggplot2::scale_y_continuous(
    name = name, breaks = breaks, minor_breaks = minor_breaks,
    n.breaks = n.breaks, labels = labels, limits = limits, expand = expand,
    na.value = na.value, trans = trans, guide = guide, position = position,
    sec.axis = sec.axis,
    ...
  )
}
