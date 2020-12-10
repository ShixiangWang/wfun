#plot_roc(pROC::aSAH, markers = c("s100b", "wfns"), response = "outcome")

plot_roc <- function(
  df, markers, response = "Response", direction = "<",
  legend.position = "right",
  smooth = FALSE,
  auc = TRUE,
  ci = TRUE,
  add_ref_line = TRUE) {
  nm <- length(markers)
  if (length(direction) == 1L & nm != 1L) {
    direction <- rep(direction, nm)
  }

  ROC_LIST <- purrr::map2(
    markers,
    direction,
    ~ pROC::roc(df[[response]], df[[.x]], direction = .y)
  ) %>% purrr::set_names(markers)

  p <- pROC::ggroc(
    ROC_LIST,
    aes = c("color", "linetype"),
    legacy.axes = TRUE
  ) +
    scale_color_discrete("") +
    scale_linetype_discrete("") +
    scale_x_continuous(expand = expansion()) +
    scale_y_continuous(expand = expansion())
    theme(legend.position = legend.position)

  if (add_ref_line) {
    p <- p + geom_segment(aes(x = 0, xend = 1, y = 0, yend = 1),
                          color = "grey", linetype = "dashed")
  }
  list(
    p = p,
    ROC_LIST = ROC_LIST
  )
}

