##################################
# HRP2 modeling exercise
# June 2018
#
# Original model, code, and demo developed by Oliver J. Watson at Imperial College London
# https://github.com/OJWatson/hrp2malaRia#hrp2malaria
#
# Watson OJ et al. eLife 2017.
# Modelling the drivers of the spread of Plasmodium falciparum hrp2 gene deletions in sub-Saharan Africa.
# https://elifesciences.org/articles/25008
# Built on Imperial College London's malaria transmission model, described in the methods
#
##################################

##########
# SET-UP #
##########

# Install the development version from github (the package devtools is required):
# If not already installed, type the following command into the console to install devtools:
install.packages("devtools")
library(devtools)
install_github("OJWatson/hrp2malaRia")

# Once installed, the package can be loaded using:
library(hrp2malaRia)


#################
# DEMONSTRATION #
#################
# We can demonstrate the model by simulating 2 populations of 2000 individuals over 20 years.
# Both populations start with 10% frequency of hrp2 deletions and have an annual 
# entomological innoculation rate (EIR - the number of infectious mosquito bites per person per year) of 1

# Population 1: 
#   - only uses rapid diagnostic tests (RDTs) to diagnose malaria
#   - all treatment is based on the RDT result (RDT+ = treatment, RDT- = no treatment)
# Population 2:
#   - uses RDTs for 70% of cases and microscopy for the other 30%
#   - 1/3 of RDT-negative cases receive treatment anyway 

# Population 1
r <- hrp2_Simulation(N=2000, years=20, rdt.det = 0, rdt.nonadherence = 0, EIR=1/365, microscopy.use = 0, fitness = 1)
# Population 2
r2 <- hrp2_Simulation(N=2000, years=20, rdt.det = 0.3, rdt.nonadherence = .3, EIR=1/365, microscopy.use = 0.3, fitness = 1)

# Now, let's plot these - all veriables that begin with S. are series variables collected over time. 
# let's plot the first population
plot(r$S.Times,r$S.N.Dels, xlab = "time (days)", ylab = "hrp2 deletion Frequency", ylim=c(0,1), col="red", type="l", lwd=2)
# and add the second population
lines(r2$S.Times,r2$S.N.Dels,lwd=2)
# and add our legend
legend(1500, .15, legend=c("Only RDT use", "70% RDT use, and 30% nonadherence to RDT negative result"),
       col=c("red", "black"), lty=1, cex=0.8,
       box.lty=2, box.lwd=2)

# Now, run the model again (lines 44-55) to see the run-to-run variability of the model

############
# EXAMPLES #
############

######### South America

# Simulate the situation in South America, based on the following assumptions
#   - 50% of circulating P. falciparum parasites have an hrp2 gene deletion (strains.0 = 2)
#   - 100% microscopy use (microscopy.use = 1)
#   - other parameters similar to above: N=2000, years=20, rdt.det=0, EIR 1/365, fitness=1

###No fitness advantage
r <- hrp2_Simulation(N=2000, years=20, rdt.det = 0, EIR=1/365, microscopy.use = 1, fitness = 1, strains.0 = 2)
  
###Now, lets make a second population with the same assumptions but with a big fitness advantage (fitness=2).
r2 <- hrp2_Simulation(N=2000, years=20, rdt.det = 0, EIR=1/365, microscopy.use = 1, fitness = 2, strains.0 = 2)

  
# Take a quick look at the plots
plot(r$S.Times,r$S.N.Dels, xlab = "time (days)", ylab = "hrp2 deletion Frequency", ylim=c(0,1), col="red", type="l", lwd=2)
lines(r2$S.Times,r2$S.N.Dels,lwd=2)

### Now, let's make a third population that may be closer to reality, a slight fitness advantage (fitness=1.05)
r3 <- hrp2_Simulation(N=2000, years=20, rdt.det = 0, EIR=1/365, microscopy.use = 1, fitness = 1.05, strains.0 = 2)
  
# Finally, let's add the line to the plot
lines(r3$S.Times,r3$S.N.Dels,lwd=2, col="blue")


######### Sub-Saharan Africa

# Simulate the situation in Sub-Saharan Africa, based on the following assumptions
#   - 10% of circulating P. falciparum parasites have an hrp2 gene deletion (strains.0 = 10)
#   - 100% RDT use (microscopy.use = 0)
#   - 20% RDT non-adherence, or people get treated even with a negative RDT result (rdt.nonadherence = 0.2)
#   - other parameters similar to above: N=2000, years=20, rdt.det=0, EIR 1/365, fitness=1

###No fitness advantage
r <- hrp2_Simulation(N=2000, years=20, rdt.det = 0, EIR=1/365, microscopy.use = 0, fitness = 1, strains.0 = 10, rdt.nonadherence = 0.2)

###Now, lets make a second population with the same assumptions but with a big fitness advantage (fitness=2).
r2 <- hrp2_Simulation(N=2000, years=20, rdt.det = 0, EIR=1/365, microscopy.use = 0, fitness = 2, strains.0 = 10, rdt.nonadherence = 0.2)

# Take a quick look at the plots
plot(r$S.Times,r$S.N.Dels, xlab = "time (days)", ylab = "hrp2 deletion Frequency", ylim=c(0,1), col="red", type="l", lwd=2)
lines(r2$S.Times,r2$S.N.Dels,lwd=2)

### Now, let's make a third population that may be closer to reality, a slight fitness advantage (fitness=1.05)
r3 <- hrp2_Simulation(N=2000, years=20, rdt.det = 0, EIR=1/365, microscopy.use = 0, fitness = 1.05, strains.0 = 10, rdt.nonadherence = 0.2)


# Finally, let's add the line to the plot
lines(r3$S.Times,r3$S.N.Dels,lwd=2, col="blue")
