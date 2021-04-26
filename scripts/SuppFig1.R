#Whitmore_et_al_2021
#supp fig 2

library(here)
library(tidyr)
library(dplyr)
library(ggplot2)
library(ggpubr)
library(grid)


##############################
######Supporting figures######
##############################

SupportingFig <- read.csv(here::here("data/PrecipitationData.csv"))

SupportingFig$DateTime <- as.POSIXct(SupportingFig$DateTime, format="%m/%d/%Y %H:%M", tz="UTC")
# convert discharge from m3p per s to L per s
SupportingFig$stn1_Q <- SupportingFig$stn1_Q * 1000

SupportingFig <- SupportingFig %>%
  select(DateTime, ppt_mm, ppt24Tot, stn1_Q)



SupportingFig$Date <- as.Date(SupportingFig$DateTime)
SupportingFig.sum <- SupportingFig %>%
  group_by(Date) %>%
  drop_na(ppt_mm) %>%
  summarize(
    sum.ppt = sum(ppt_mm)) %>%
  drop_na(Date) %>%
  filter(Date > "2019-07-11")
SupportingFig.sum$Time <- "12:00:00"
SupportingFig.sum$DateTime <- paste(SupportingFig.sum$Date,SupportingFig.sum$Time)
SupportingFig.sum$DateTime <-  as.POSIXct(SupportingFig.sum$DateTime, format="%Y-%m-%d %H:%M:%S", tz="UTC")

SupportingFig <- SupportingFig %>%
  filter(DateTime >= "2019-07-12 12:00:00")
SupportingFig.sum <- SupportingFig.sum %>%
  filter(DateTime >= "2019-07-11 12:00:00")

SupportingFig <- full_join(SupportingFig, SupportingFig.sum, by='DateTime')

coeff <- 0.5

ppt.Fig <- ggplot(data=SupportingFig.sum, aes(x=DateTime, y=sum.ppt)) +
  geom_bar(stat="identity", color = "blue", fill="blue") +
 scale_y_continuous(trans = "reverse") +
  xlim(as.POSIXct("2019-07-12 12:00:00"), as.POSIXct("2019-08-15 12:00:00")) +
  theme_bw() +
  theme(panel.background = element_rect(fill = "white", colour = "Black")) +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank())  +
  ylab("Precipitation [mm]") +
  ylab(expression(paste("Precipt. [mm  ", d^-1,"]"))) +
  theme(axis.title.x = element_blank(),
        axis.text.x= element_blank(),
        axis.ticks.x = element_blank()) +
  theme(axis.title.y = element_text(size = 13, vjust=3.0),
        axis.text.y= element_text(size= 12))
  
Q.Fig <- ggplot(data=SupportingFig, 
                aes(x=DateTime, y=stn1_Q)) +
  geom_point(color="green")  +
  xlim(as.POSIXct("2019-07-12 00:00:00"), as.POSIXct("2019-08-15 12:00:00")) +
  theme_bw() +
  theme(panel.background = element_rect(fill = "white", colour = "Black")) +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank())  +
  ylab(expression(paste("Discharge [L ", s^-1,"]"))) +
  xlab("Date") +
  theme(axis.title.x = element_text(size = 13, vjust=-2.0),
        axis.text.x= element_text(size= 12)) +
  theme(axis.title.y = element_text(size = 13, vjust=3.0),
        axis.text.y= element_text(size= 12)) 

suppFig1 <- grid.draw(rbind(ggplotGrob(ppt.Fig), ggplotGrob(Q.Fig), size = "last"))


pdf(here::here('figs/SuppFig1_TEST.pdf'), width = 12, height = 8)
suppFig1
dev.off()

