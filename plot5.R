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

setwd("C:\\Users\\vivek\\Documents\\Data Science\\Coursera\\Exploratory Data Analysis\\Lecture 04")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

summary(NEI)
str(NEI)

cat("Fraction of NA in the NEI file is:", mean(is.na(NEI)))
cat("Fraction of NA in the SCC file is:", mean(is.na(SCC)))

# problem 5,

prob5 <- NEI %>%
  filter(as.numeric(fips) == 24510, type == "ON-ROAD") %>%
  group_by(year) %>%
  summarise("Auto.Emission" = sum(Emissions, na.rm = TRUE))


ggplot(prob5, aes(year, Auto.Emission)) + labs(ylab = "Auto Emission") + 
  ggtitle("On road PM2.5 emissions for Baltimore City, MD") +
  geom_point() + geom_line()
dev.copy(png, file="plot5.png", height=480, width=480)
dev.off()
