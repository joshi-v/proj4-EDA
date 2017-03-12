rm(list=ls())

install.packages("dplyr")
library(dplyr)
install.packages("tidyr")
library(tidyr)
install.packages("ggplot2")
library(ggplot2)
install.packages("gridExtra")
library(gridExtra)
library(grid)

# read in the files

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# problem 1: all emissions summed by year

prob1 <- NEI %>%
  group_by(year) %>%
  summarise("TotalEmissions" = sum(Emissions, na.rm = TRUE))

par(mfrow=c(1,2))
plot(prob1, xlab = "Year", ylab = "Total PM2.5 emissions", type = "l")
barplot(height = prob1$TotalEmissions, names.arg=prob1$year, xlab = "Year", 
  ylab = "Total PM2.5 Emissions")

dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
