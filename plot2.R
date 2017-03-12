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

# prob 2

prob2 <- NEI %>%
  filter(as.numeric(fips) == 24510) %>%
  group_by(year) %>%
  summarise("TotalEmissions"=sum(Emissions, na.rm = TRUE))

par(mfrow=c(1,2), oma = c(0, 0, 2, 0))
plot(prob2, xlab = "Year", ylab = "Emissions", type = "l")
barplot(height = prob2$TotalEmissions, names.arg=prob1$year, xlab = "Year", 
        ylab = "Emissions")
mtext(text = "PM2.5 emissions for Baltimore City, MD", outer = TRUE, side = 3)

dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
