#Whitmore_et_al_2021
#fig3

library(here)
library(ggplot2)
library(ggpubr)

###############
###FIGURE 3####
###############

df <- read.csv(here::here("data/KatStn1_df.csv"))

df$DateTime <- as.POSIXct(df$DateTime, format="%m/%d/%Y %H:%M", tz="UTC")

# convert discharge from m3p per s to L per s
df$stn1_Q <- df$stn1_Q * 1000

#hysterises: we want to highlight 3 days at high, med and low discharge
#high: 7/15/2019 or 7/24/2019
#med: 7/18/2019 or 8/4/2019
#low: 8/2/2019 or 8/12/2019 or 8/13/2019
high <- subset(df, 
               DateTime < as.POSIXct('2019-07-24 23:55:00', tz="UTC") &
                 DateTime > as.POSIXct('2019-07-24 00:05:00', tz="UTC"))
high$hyst <- "high"
med <- subset(df, 
              DateTime < as.POSIXct('2019-07-18 23:55:00', tz="UTC") &
                DateTime > as.POSIXct('2019-07-18 00:05:00', tz="UTC"))
med$hyst <- "medium"
low <- subset(df, 
              DateTime < as.POSIXct('2019-08-02 23:55:00', tz="UTC") &
                DateTime > as.POSIXct('2019-08-02 00:05:00', tz="UTC"))
low$hyst <- "low"
hyst <- rbind(high,med,low)


####Plot#####

df$kkin <- as.character(df$kkin)
df$kkin[is.na(df$kkin)] <- "keff"
#jpeg('k600vTime_2021-02-10.jpg')
#dev.off()
coeff <- .5
k600vTime <- ggplot() + 
  geom_ribbon(data=subset(df, !is.na(stn1_Q)), aes(x=DateTime, ymin=0, ymax=stn1_Q*coeff, linetype = "1"), 
              alpha=.3, 
              fill="steelblue",
              color="steelblue", size = 1 ) +
  geom_point(data=df, aes(x= DateTime, y= K600.effective, color="darksalmon"), size = 2.5, alpha=.6) +
  scale_y_continuous(
                     name=expression(paste(" ", italic('k')[600] ," [m ", d^-1,"]")),
                     sec.axis = sec_axis(~./coeff, name = expression(paste("Discharge [L ", s^-1,"]")))) + 
  xlab("Date") +
  xlim(c(as.POSIXct('2019-07-12 00:00:00', format = "%Y-%m-%d %H:%M:%S"),
         as.POSIXct('2019-08-15 00:00:00', format = "%Y-%m-%d %H:%M:%S"))) +
  geom_point(data=df, aes(x=DateTime, y=K600.eq1, fill=kkin), shape=17,
             color="black", size=4)+
  geom_point(data=df, aes(x=DateTime, y=K600.eq1, fill=kkin), shape=17,
             color="white", size=1)+
  guides(fill=guide_legend(title=NULL, order = 2),
         col=guide_legend(title=NULL, order = 1, size=15),
         linetype=guide_legend(title=NULL, size=15)) +
  scale_color_manual(values = c("darksalmon"),
                     labels=c(expression(paste(italic('k')[600-M])),expression(paste(italic('k')[600-K])))) +
  scale_fill_manual(values = c(17,17), breaks=c("", "Kkin"),
                    labels=c("", expression(paste(italic('k')[600-K])))) +
  scale_linetype_manual(values= 1, labels= expression(paste("  ","Discharge"))) +
  theme_classic()+
  theme(axis.title.x = element_text(size = 18, hjust= 3.0),
        axis.text.x= element_text(size= 15),
        axis.title.y = element_text(color = "black", size=15, vjust=3.0),
        axis.title.y.right = element_text(color = "steelblue", size=15, vjust=3.0),
        axis.text = element_text(size = 15),
        axis.title = element_text(size=18)) +
  theme(legend.title=element_text(size=18),
        legend.text=element_text(size=15),
        legend.position = 'top',  legend.justification='right') +
  theme(
    legend.box.background = element_rect(color="black", size=.5) ,
    legend.box.margin = margin(4, 4, 4, 4)
  ) 

######K600 V Q

k600vsDischarge  <- ggplot(df, aes(x= stn1_Q, y= K600.effective)) +
  xlim(0,65) +
  ylab(expression(paste(italic('k')[600] ," [m ", d^-1,"]"))) +
  xlab(expression(paste("Discharge [L ", s^-1,"]"))) +
  geom_point(aes(shape="Km"), size = 3, color="grey" ) +
  geom_point(data=hyst, aes(x=stn1_Q, y=K600.effective, color=hyst), size=3)+ 
  geom_point(data=df, aes(x=stn1_Q, y=K600.eq1, fill=kkin),
             shape=17, color="Black", size=4)+
  geom_point(data=df, aes(x=stn1_Q, y=K600.eq1, fill=kkin),
             shape=17, color="white", size=1)+
  geom_point(data=hyst, aes(x=stn1_Q, y=K600.eq1),
             shape=17, color="Black", size=4)+
  geom_point(data=hyst, aes(x=stn1_Q, y=K600.eq1, color=hyst),
             shape=17, size=1)+ 
  geom_smooth(aes(y = K600.effective, linetype = "ghgh"), method = lm, se = FALSE, size = 1, fullrange=TRUE) +
  geom_smooth(aes(y = K600.eq1, linetype = "k600.K"), method = lm, se = FALSE, size = 1, fullrange=TRUE) +
  theme_classic()+
  theme(axis.title.x = element_text(size = 18, vjust=-1.0),
        axis.text.x= element_text(size= 14),
        axis.title.y = element_text(size = 18, vjust=2.5),
        axis.text.y= element_text(size= 14),
        legend.title=element_text(size=18),
        legend.text=element_text(size=14)) +
  scale_color_manual(breaks = c("medium", "high", "low"), 
                     values=c("coral1", "cyan", "darkorchid1"),
                     labels=c("July 18", "July 24","August 2")) +
 scale_shape_manual(values = 16,labels=expression(paste("  ",italic('k')[600-M]))) +
  scale_fill_manual(values = c(17,17), breaks=c("NA", "Kkin"),
                    labels=c("", expression(paste("  ",italic('k')[600-K]))))+
  scale_linetype_manual(values = c("solid","twodash"),
                        labels=c(expression(paste(italic('k')[600-M])),expression(paste(italic('k')[600-K])))) +
  guides(col = guide_legend(order = 3, title = "Date"),
         fill = guide_legend(order = 2, title=NULL),
         linetype = guide_legend(order = 4, title="Linear Model"),
         shape = guide_legend(order = 1, title=NULL)) +
  theme(
    legend.justification = c("right", "center"),
    legend.margin = margin(3, 3, 4, 4),
    legend.box.background = element_rect(color="black", size=.5), 
    legend.box.margin = margin(3, 3, 3, 3),
    legend.spacing.x = unit(0.5, 'cm')) +
  coord_fixed() 

all.figs <- ggarrange(NULL,k600vTime, NULL,k600vsDischarge, ncol = 1,
               heights = c(0.2,1,0.2,1),
               labels = c("A","","B",""),
               font.label = list(size = 24, color = "black", face = "bold"),
              # label.x = .1,
              # label.y = .1,
               align="h", common.legend = FALSE
               )
pdf(here::here("figs/Fig3.pdf"), width = 7, height = 8)
all.figs
dev.off()

