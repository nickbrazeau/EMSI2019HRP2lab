#' @export

quiet <- function(x) {
  sink(tempfile())
  on.exit(sink())
  invisible(force(x))
}

#' @export
hrp2_Simulation <- function(...){
  quiet(hrp2malaRia::hrp2_Simulation(...))
}

#' @export
extracthrp2results <- function(pop1 = NULL, pop2 = NULL, pop3 = NULL, pop4 = NULL){
  # note, this is a hacky, quick function.
  # does not protect against corner cases and is not overly functional
  # overall, gets the job done for this exercise but is by no means a
  # good/pretty example of R code

  # init
  ret1 <- data.frame(); ret2 <- data.frame(); ret3 <- data.frame(); ret4 <- data.frame()
  # conditionals
  if(!is.null(pop1)){
    ret1 <- data.frame(
      pfinc =    pop1$S.Incidence,
      hrp2prev =  pop1$S.N.Dels,
      time =      pop1$S.Times,
      pop = 1)
  }
  if(!is.null(pop2)){
    ret2 <- data.frame(
      pfinc =    pop2$S.Incidence,
      hrp2prev =  pop2$S.N.Dels,
      time =      pop2$S.Times,
      pop = 2)

  }
  if(!is.null(pop3)){
    ret3 <- data.frame(
      pfinc =    pop3$S.Incidence,
      hrp2prev =  pop3$S.N.Dels,
      time =      pop3$S.Times,
      pop = 3)

  }
  if(!is.null(pop4)){
    ret4 <- data.frame(
      pfinc =    pop4$S.Incidence,
      hrp2prev =  pop4$S.N.Dels,
      time =      pop4$S.Times,
      pop = 2)

  } # end conditionals

  ret <- rbind.data.frame(ret1,ret2,ret3,ret4)
  return(ret)
}

#' @export
plothrp2models <- function(pop1 = NULL, pop2 = NULL, pop3 = NULL, pop4 = NULL, labels = c("")){

  ret <- extracthrp2results(pop1, pop2, pop3, pop4)
  plt <- ret %>%
    dplyr::mutate(pop = factor(pop)) %>%
    ggplot() +
    geom_line(aes(x=time, y=hrp2prev, color = factor(pop))) +
    scale_color_manual(name = "", labels = labels, values = RColorBrewer::brewer.pal(8, "Set1")) +
    xlab("Time (Days)") + ylab("hrp2 Deletion Frequency") +
    theme_minimal() +
    theme(
      plot.title = element_text(hjust=0.5),
      legend.position = "bottom"
    )
  return(plt)
}




#' @export
plotincmodels <- function(pop1 = NULL, pop2 = NULL, pop3 = NULL, pop4 = NULL, labels = c("")){

  ret <- extracthrp2results(pop1, pop2, pop3, pop4)
  plt <- ret %>%
    dplyr::mutate(pop = factor(pop)) %>%
    ggplot() +
    geom_line(aes(x=time, y=pfinc, color = factor(pop))) +
    scale_color_manual(name = "", labels = labels, values = RColorBrewer::brewer.pal(8, "Set1")) +
    xlab("Time (Days)") + ylab("Incidence") +
    theme_minimal() +
    theme(
      plot.title = element_text(hjust=0.5),
      legend.position = "bottom"
    )
  return(plt)
}
