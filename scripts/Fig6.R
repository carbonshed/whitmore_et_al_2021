#Whitmore_et_al_2021
#fig6

library(here)
library(lubridate)
library(ggplot2)
library(ggpubr)
library(reshape2)


###############
###FIGURE 6####
###############
synoptic.df <- read.csv(here::here("data/Synoptic_Km600.csv"))
synoptic.df$dist.asCharakter <- as.character(synoptic.df$dist.m.AVE)
#get rid of na AND keffective negative value
synoptic.df_subset <- na.omit(synoptic.df)
synoptic.df <- subset(synoptic.df, DOY !=  210)

##synoptic by date
synoptic.df.melt <- melt(synoptic.df[,c("Date","dist.m.AVE","K600.eq1","K600.effective", "Q_m3perS")], 
                         id=c("Date","dist.m.AVE","Q_m3perS"))
# New facet label names for Date
date.labs <- c("July 18th", "July 25th", "July 31st", "August 6th","August 12th")
names(date.labs) <- c("2019-07-19", "2019-07-26", "2019-08-01","2019-08-07","2019-08-13")
# convert discharge from m3p per s to L per s
synoptic.df.melt$Q_LperS <- synoptic.df.melt$Q_m3perS * 1000


f.6 <- ggplot(synoptic.df.melt, aes(x = Date, y = value, fill=variable)) + 
  geom_boxplot(position = position_dodge(), size =1) + 
  theme(strip.text.x = element_text(size = 13, color = "black", face = "bold")) +
  scale_y_log10(limits = c(3,400),breaks = c(3, 10, 30, 100, 300))+
  scale_x_discrete(breaks=c("2019-07-19", "2019-07-26", "2019-08-01","2019-08-07","2019-08-13"),
                   labels = c("July 18", "July 25", "July 31", "Aug 6","Aug 12")) +
  ylab(expression(paste(italic('k')[600]," [m ", d^-1,"]"))) +
  xlab("Collection date") +
  labs(fill=expression()) +
  scale_fill_discrete( labels=c(expression(paste(italic('k')[600-K])), expression(paste(italic('k')[600-M])))) +
  
  theme_classic()+
  theme(axis.title.x = element_text(size = 25, vjust=-2.0),
        axis.text.x= element_text(size= 20)) +
  theme(axis.title.y = element_text(size = 25, vjust=3.0),
        axis.text.y= element_text(size= 20)) +
  theme(legend.title=element_text(size=20)) +
  theme(legend.text=element_text(size=20))+
  theme(
    legend.box.background = element_rect(color="black", size=1),
    legend.box.margin = margin(1, 6, 6, 6))  +
  theme(plot.margin=unit(c(1,1,1,1),"cm")) 


pdf(here::here("figs/Fig6.pdf"),
    width = 10,
    height = 6)
f.6
dev.off()
