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

# problem 6, use the data computed above for Baltimore City, MD

prob6 <- NEI %>%
  filter((as.numeric(fips) == 06037 | as.numeric(fips) == 24510), 
         type == "ON-ROAD") %>%
  group_by(year, fips) %>%
  summarise("Auto.Emission"=sum(Emissions, na.rm = TRUE))

#line plot, dont like it much

ggplot(prob6, aes(year, Auto.Emission, color = fips)) + 
  ggtitle("PM2.5 auto emission data for BC, MD (24510) and LA(06037)") +
         geom_point() + geom_line()
dev.copy(png, file="plot6a.png", height=480, width=480)
dev.off()

# like this

ggplot(prob6, aes(year, Auto.Emission)) + facet_grid(fips~., scales = "free") +
  ggtitle("PM2.5 auto emission data for BC, MD (24510) and LA(06037)") +
  geom_point(shape = 25, fill = "blue") + geom_line(color = "blue")
dev.copy(png, file="plot6.png", height=480, width=480)
dev.off()
