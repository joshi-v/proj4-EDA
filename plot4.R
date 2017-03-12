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

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# problem 4,
matched.coal <- SCC[grepl("Coal" , SCC$Short.Name, ignore.case = TRUE), ]
NEI.coal <- NEI[NEI$SCC %in% matched.coal$SCC, ]

prob4 <- NEI.coal %>%
  group_by(year, type) %>%
  summarise("Coal.Emissions" = sum(Emissions, na.rm = TRUE))

ggplot(prob4, aes(x = factor(year), y = Coal.Emissions, fill = type)) + 
  geom_bar(stat= "identity") + xlab("year") + ylab("Coal-Related PM2.5 Emissions")

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
