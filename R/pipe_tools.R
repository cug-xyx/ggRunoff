#' ggplot pipe tools
#'
#' @param x the left variable
#' @param y the right variable
#'
#' @example R/examples/ex-pipe1.R
#'
#' @export
`%||%` <- function(x, y) {
  if (is.null(x)) y else x
}
