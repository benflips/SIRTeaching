runSIR <- function(R0, gamma, I0=100, N = 30000000, maxT = 500) {
  # Simulate the SIR model in discrete time steps
  Infected <- I0  # The initial number of people infected (e.g., overseas arrivals)
  TotalN <- N #30000000  # A total population of 30M (approx. population size of Texas or Australia)
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
  out <- cbind(Susceptible, Infected, Recovered)
}

plotSIR <- function(SIRmatrix){
  # first set up the graphics to plot a single graph with smallish margins
  par(mfrow=c(1,1), mar=c(4,4,2,2))
  
  S <- SIRmatrix[,1]
  I <- SIRmatrix[,2]
  R <- SIRmatrix[,3]
  
  TotalN <- S[1]+I[1]
  # generate some values for the time axis (0, 1, 2, ..., MaxT)
  maxT <- length(S)-1
  t <- 0:(maxT)
  
  plot(S~t, type="l", col="black", ylim=c(0, TotalN), ylab="Number")  # first plot the susceptible population in black
  lines(I~t, type="l", col="red")  # add a line with the Infected number in red
  lines(R~t, type="l", col="blue")  # add a line with the Recovered number in blue
  # Add some labels to the plot to help identify the results
  text(x=0, y=S[1]/1.1, labels="Susceptible", pos=4, col="black")
  text(x=maxT, y=R[maxT]/1.1, labels="Recovered", pos=2, col="blue")
  text(x=maxT, y=TotalN/20, labels="Infected", pos=2, col="red")
}

