#' ggplot pipe tools
#'
#' @param x
#' @param y
#'
#' @export
`%||%` <- function(x, y) {
  if (is.null(x)) y else x
}
