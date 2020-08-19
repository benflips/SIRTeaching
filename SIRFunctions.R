# Simulate the SIR model in discrete time steps
  # code modified from script by Mick McCarthy
runSIR <- function(R0, gamma, I0, N = 100, maxT = 600) {
  Infected <- I0  # The initial number of people infected (e.g., overseas arrivals)
  TotalN <- N # Total population size
  Recovered <- 0
  Susceptible <- TotalN - Infected - Recovered
  
  MaxT <- maxT  # 500  # how many times steps for the simulation
  
  R0 <- R0 # potential new infections per infected person over the course of the infection
  gamma <- gamma # recovery rate per day of infected people
  beta <- R0 * gamma  # potential new infections per infected person per day
  
  for(t in 1:MaxT){  # for each time step in the simulation is a day
    NewlyI <- beta * Infected[t] * Susceptible[t] / TotalN  # calculate the number of new infections
    NewlyR <- gamma * Infected[t]  # calculate the number of new recoveries
    nextS <- Susceptible[t] - NewlyI  # number of susceptible in the next time step (subtract new infections)
    nextI <- Infected[t] + NewlyI - NewlyR # number of infected in the next time step (add new infections, subtract recoveries)
    nextR <- Recovered[t] + NewlyR # number of recovered in the next time step (add new recoveries)
    # add that new amounts to the previous values
    Susceptible <- c(Susceptible, nextS) 
    Infected <- c(Infected, nextI) 
    Recovered <- c(Recovered, nextR) 
  }
  out <- cbind(S=Susceptible, I=Infected, R=Recovered)
}


# Plot the results using plotly
plotSIR <- function(SIRmatrix){
  pDat <- data.frame(t=0:(nrow(SIRmatrix)-1), SIRmatrix)
  
  fig <- plot_ly(pDat, type = "scatter", mode = "lines") %>%
    add_trace(x=~t, y=~S,
              name = "Susceptible",
              hoverinfo = "text+name",
              text = paste("t=", pDat$t, format(round(pDat$S, 0), big.mark = ","), "%")) %>%
    add_trace(x=~t, y=~I,
              name = "Infected",
              hoverinfo = "text+name",
              text = paste("t=", pDat$t, format(round(pDat$I, 0), big.mark = ","), "%")) %>%
    add_trace(x=~t, y=~R,
              name = "Recovered",
              hoverinfo = "text+name",
              text = paste("t=", pDat$t, format(round(pDat$R, 0), big.mark = ","), "%")) %>%
    layout(yaxis = list(title = list(text = "Percent of population",
                        fixedrange = TRUE)),
           xaxis = list(title = list(text = "Days since first case"))) %>%
    config(displayModeBar = FALSE)
  fig
}

