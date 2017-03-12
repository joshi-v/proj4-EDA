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

point.nei <- NEI %>%
  filter(as.numeric(fips) == 24510, type == "POINT") %>%
  group_by(year) %>%
  summarise("Emission" = sum(Emissions, na.rm = TRUE))

onroad.nei <- NEI %>%
  filter(as.numeric(fips) == 24510, type == "ON-ROAD") %>%
  group_by(year) %>%
  summarise("Emission" = sum(Emissions, na.rm = TRUE))

nonpoint.nei <- NEI %>%
  filter(as.numeric(fips) == 24510, type == "NONPOINT") %>%
  group_by(year) %>%
  summarise("Emission" = sum(Emissions, na.rm = TRUE)) 

nonroad.nei <- NEI %>%
  filter(as.numeric(fips) == 24510, type == "NON-ROAD") %>%
  group_by(year) %>%
  summarise("Emission" = sum(Emissions, na.rm = TRUE))

dev.off()
par(mfrow=c(2,2))

p1 <- ggplot(point.nei, aes(year, Emission)) + labs(y = "Points") + geom_line() + geom_point()
p2 <- ggplot(onroad.nei, aes(year, Emission)) + labs(y = "Onroad") + geom_line() + geom_point()
p3 <- ggplot(nonroad.nei, aes(year, Emission)) + labs(y = "Non-road") + geom_line() + geom_point()
p4 <- ggplot(nonpoint.nei, aes(year, Emission)) + labs(y = "Non-point") + geom_line() + geom_point()

grid.newpage()
pushViewport(viewport(layout = grid.layout(3, 2, heights = unit(c(0.5, 5, 5, 5), "null"))))   
grid.text("Baltimore City PM2.5 Emissions", vp = viewport(layout.pos.row = 1, layout.pos.col = 1:2))
print(p1, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))         
print(p2, vp = viewport(layout.pos.row = 2, layout.pos.col = 2))
print(p3, vp = viewport(layout.pos.row = 3, layout.pos.col = 2))
print(p4, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))
dev.copy(png, file="plot3a.png", height=480, width=480)
dev.off()

prob3 <- NEI %>%
  filter(as.numeric(fips) == 24510) %>%
  group_by(type, year) %>%
  summarise("BCM.Pollution.NEI" = sum(Emissions, na.rm = TRUE))

ggplot(prob3, aes(year, BCM.Pollution.NEI, color = type)) + labs(y = "Non-point")  +
  geom_line() + geom_point()
dev.copy(png, file="plot3a.png", height=480, width=480)
dev.off()
