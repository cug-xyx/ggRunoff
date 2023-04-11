#' Title
#'
#' @param coef
#' @param name
#' @param breaks
#' @param minor_breaks
#' @param n.breaks
#' @param labels
#' @param limits
#' @param expand
#' @param na.value
#' @param trans
#' @param guide
#' @param position
#' @param sec.axis
#' @param ...
#'
#' @export
scale_y_precipitation <- function (
  coef = 1,
  name = waiver(), breaks = waiver(), minor_breaks = waiver(),
  n.breaks = NULL, labels = waiver(), limits = NULL, expand = c(0, 0),
  na.value = NA_real_, trans = "identity", guide = waiver(), position = "left",
  sec.axis = waiver(),
  ...
) {
  # if missing sec.axis
  if (length(sec.axis) == 0) {
    sec.axis = ggplot2::sec_axis(
      name = 'second axis',
      trans = ~ (max(.) - .) / coef,
      labels = function(x) x,
    )
  }
  ggplot2::scale_y_continuous(
    name = name, breaks = breaks, minor_breaks = minor_breaks,
    n.breaks = n.breaks, labels = labels, limits = limits, expand = expand,
    na.value = na.value, trans = trans, guide = guide, position = position,
    sec.axis = sec.axis,
    ...
  )
}
