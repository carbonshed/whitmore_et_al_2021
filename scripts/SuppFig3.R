#Plots for pub
#Whitmore_et_al_2021
#Supplementary fig 3

library(here)
library(dplyr)
library(ggplot2)
library(ggpubr)
library(reshape2)
library(tidyr)


df <- read.csv(here::here("data/KatStn4_df.csv"))

df <- df %>% 
  drop_na(K600.E.stn4)

df$DateTime <- as.POSIXct(df$DateTime, format="%m/%d/%Y %H:%M", tz="UTC")
df$stn1_Q <- df$stn1_Q * 1000

df.clean <- subset(df, 
                   DateTime < as.POSIXct('2019-07-14 11:30:00', tz="UTC")&
                     DateTime > as.POSIXct('2019-07-12 17:30:00', tz="UTC"))

coeff <- .5
k600vTime_stn4 <- ggplot() + 
  geom_ribbon(data=df.clean, aes(x=DateTime, ymin=0, ymax=stn1_Q*coeff, linetype = "1"), 
              alpha=.3, 
              fill="steelblue",
              color="steelblue", size = 1 ) +
  geom_point(data=df.clean, aes(x= DateTime, y= K600.E.stn4, color="darksalmon"), size = 2.5, alpha=.6) +
  scale_x_datetime(date_breaks = "1 day", date_labels = "%b %d\n%l:%M %p") +
  scale_y_continuous(
    name=expression(paste(" ", italic('k')[600] ," [m ", d^-1,"]")),
    sec.axis = sec_axis(~./coeff, name = expression(paste("Discharge [L ", s^-1,"]")))) + 
  xlab("Date") +
  guides(fill=guide_legend(title=NULL, order = 2),
         col=guide_legend(title=NULL, order = 1, size=15),
         linetype=guide_legend(title=NULL, size=15)) +
  scale_color_manual(values = c("darksalmon"),
                     labels=c(expression(paste(italic('k')[600-M])),expression(paste(italic('k')[600-K])))) +
  scale_linetype_manual(values= 1, labels= expression(paste("  ","Discharge"))) +
  theme_classic()+
  theme(axis.title.x = element_text(size = 18, hjust= 3.0),
        axis.text.x= element_text(size= 14),
        axis.title.y = element_text(color = "black", size=15, vjust=3.0),
        axis.title.y.right = element_text(color = "steelblue", size=15, vjust=3.0),
        axis.text = element_text(size = 14),
        axis.title = element_text(size=14)) +
  theme(legend.title=element_text(size=14),
        legend.text=element_text(size=14),
        legend.position = 'right',  legend.justification='center') +
  theme(
    legend.box.background = element_rect(color="black", size=.5) ,
    legend.box.margin = margin(4, 4, 4, 4)
  ) 

######K600 V Q stn4
k600vsDischarge_stn4  <- ggplot(df.clean, aes(x= stn1_Q, y= K600.E.stn4)) +
  ylab(expression(paste(italic('k')[600] ," [m ", d^-1,"]"))) +
  xlab(expression(paste("Discharge [L ", s^-1,"]"))) +
  geom_point( size = 3, color="grey", show.legend = TRUE ) +
  geom_smooth(aes(y = K600.E.stn4, linetype = "ghgh"), method = lm, se = FALSE, size = 1, fullrange=TRUE) +
  theme_classic()+
  theme(axis.title.x = element_text(size = 18, vjust=-1.0),
        axis.text.x= element_text(size= 14),
        axis.title.y = element_text(size = 18, vjust=2.5),
        axis.text.y= element_text(size= 14),
        legend.title=element_text(size=14),
        legend.text=element_text(size=14)) +
  scale_shape_manual(values = 16,labels=expression(paste("  ",italic('k')[600-M]))) +
  scale_linetype_manual(values = c("solid"),
                        labels=c(expression(paste(italic('k')[600-M])))) +
  guides(fill = guide_legend(order = 2, title=NULL),
         linetype = guide_legend(order = 4, title=NULL),
         shape = guide_legend(order = 1, title=NULL)) +
  theme(
    legend.position = 'right',  legend.justification='center',
    legend.margin = margin(3, 3, 4, 4),
    legend.box.background = element_rect(color="black", size=.5), 
    legend.box.margin = margin(3, 3, 4, 4),
    legend.spacing.x = unit(0.5, 'cm')) 


suppfig3 <- ggarrange(k600vTime_stn4, k600vsDischarge_stn4, nrow=2)

pdf(here::here("figs/SuppFig3.pdf"),
    width = 7,
    height = 5)
suppfig3
dev.off()
