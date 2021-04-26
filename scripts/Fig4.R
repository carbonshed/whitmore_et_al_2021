#Whitmore_et_al_2021
#fig 4

library(here)
library(dplyr)
library(tidyverse)
library(reshape)
library(reshape2)
library(ggplot2)
library(lubridate)
library(ggpubr)

####

df <- read.csv(here::here("data/KatStn1_df.csv"))
df$DateTime <- as.POSIXct(df$DateTime, format="%m/%d/%Y %H:%M", tz="UTC")
df$kkin <- as.character(df$kkin)
df$kkin[is.na(df$kkin)] <- "keff"
df <- df %>%
  select(DateTime,stn1_Q,K600.effective,kkin,K600.eq1,V1_adjusted,Flux_1) %>%
  filter(DateTime > as.POSIXct("2019-07-12 00:00:00"))
# convert discharge from m3p per s to L per s
df$stn1_Q <- df$stn1_Q * 1000


#########Now stack graphs for all key variables
df.diurnal <- subset(df, 
                     DateTime > as.POSIXct('2019-07-26 14:00:00', tz="UTC") &
                       DateTime < as.POSIXct('2019-07-29 14:00:00', tz="UTC"))
df.diurnal.melt <- df.diurnal %>%
  select(DateTime, K600.effective, stn1_Q, V1_adjusted, Flux_1 )

df.diurnal.melt <- melt(data = df.diurnal.melt, id.vars = "DateTime")

Diurnal <- ggplot(data = df.diurnal.melt, aes(DateTime, value, color=variable)) +
  geom_point() + 
  scale_color_manual(name = NULL,
                     breaks = c("K600.effective","V1_adjusted","Flux_1","stn1_Q"),                      
                     values = c("#F8766D","#7CAE00","#C77CFF","#00A5FF"),
                     labels=c(K600.effective = expression(paste(italic('k')[600] ," [m ", d^-1,"]")),
                              V1_adjusted = expression(paste(italic('p'),"CO"[2] ," [ppm]")),
                              Flux_1 = expression(paste("CO"[2]," Flux [",mu,"mol ", m^-2, s^-1,"]")),
                              stn1_Q = expression(paste("Discharge [L ", s^-1,"]")))) +
  guides(color = guide_legend(
    label.position = "left", ncol=2)) +
  scale_x_datetime(name = NULL, date_breaks = "1 day", date_labels = "%b %d\n%l:%M %p") +
  facet_grid(variable ~ ., scales = "free_y") +
  theme_bw() +
  theme(axis.title.x = element_text(size = 15, hjust= 3.0),
        axis.text.x= element_text(size= 13),
        axis.title.y = element_blank(),
        axis.title.y.right = element_text(color = "steelblue", size=15, vjust=3.0),
        axis.text = element_text(size = 13),
        axis.title = element_text(size=15)) +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        strip.background = element_blank(),
        panel.border = element_rect(colour = "black", fill = NA)) +
  theme(strip.text.y = element_blank()) +
  theme(legend.text=element_text(size=12),
        legend.position = 'top',  legend.justification='right',
        legend.spacing.x = unit(1.0, 'cm')
  ) +
  theme(
    legend.box.background = element_rect(color="black", size=.5) ,
    legend.box.margin = margin(3, 3, 3, 3)) 


###########

df <- read.csv(here::here("data/KatStn1_df.csv"))

df$DateTime <- as.POSIXct(df$DateTime, format="%m/%d/%Y %H:%M", tz="UTC")
df$DateTime <- df$DateTime - 17*60
df$Date <- as.Date(df$DateTime)

# convert discharge from m3p per s to L per s
df$stn1_Q <- df$stn1_Q * 1000

Max.summary <- df %>% 
  group_by(Date) %>% 
  summarize(
    stn1_Q = max(stn1_Q),
    K600.effective= max(K600.effective, na.rm=TRUE),
    V1_adjusted= max(V1_adjusted, na.rm=TRUE),
    Flux_1 = max(Flux_1, na.rm=TRUE),
    tempC_421 = max(tempC_421, na.rm=TRUE))

#Melt

#left join

Max.summary_Q <- left_join(Max.summary[c("Date","stn1_Q")],df[c("Date","stn1_Q","DateTime")], by = c("Date", "stn1_Q"))
Max.summary_Q$Q_Max <- format(Max.summary_Q$DateTime,"%H:%M:%S")
Max.summary_Q$stn1_Q <- NULL
Max.summary_Q$DateTime <- NULL

Max.summary_k <- left_join(Max.summary[c("Date","K600.effective")],df[c("Date","K600.effective","DateTime")], by = c("Date", "K600.effective"))
Max.summary_k$k_Max <- format(Max.summary_k$DateTime,"%H:%M:%S")
Max.summary_k$K600.effective <- NULL
Max.summary_k$DateTime <- NULL

Max.summary_V <- left_join(Max.summary[c("Date","V1_adjusted")],df[c("Date","V1_adjusted","DateTime")], by = c("Date", "V1_adjusted"))
Max.summary_V$V1_Max <- format(Max.summary_V$DateTime,"%H:%M:%S")
Max.summary_V$V1_adjusted <- NULL
Max.summary_V$DateTime <- NULL

Max.summary_F <- left_join(Max.summary[c("Date","Flux_1")],df[c("Date","Flux_1","DateTime")], by = c("Date", "Flux_1"))
Max.summary_F$F_Max <- format(Max.summary_F$DateTime,"%H:%M:%S")
Max.summary_F$Flux_1 <- NULL
Max.summary_F$DateTime <- NULL

#Max.summary_T <- left_join(Max.summary[c("Date","tempC_421")],df[c("Date","tempC_421","DateTime")], by = c("Date", "tempC_421"))
#Max.summary_T$T_Max <- format(Max.summary_T$DateTime,"%H:%M:%S")
#Max.summary_T$tempC_421 <- NULL
#Max.summary_T$DateTime <- NULL

Max.summary <- full_join(Max.summary_F,Max.summary_k, by = "Date")
Max.summary <- full_join(Max.summary,Max.summary_Q, by = "Date")
#Max.summary <- full_join(Max.summary,Max.summary_T, by = "Date")
Max.summary <- full_join(Max.summary,Max.summary_V, by = "Date")
Max.summary.df <- as.data.frame(Max.summary)

#Reshape 
Max.melt <- melt(data = Max.summary.df, id.vars = c("Date"), 
                 measure.vars = c("F_Max", "k_Max","Q_Max","V1_Max"))

Max.melt$Time <- as.numeric(hms(Max.melt$value))/60/60
Max.melt <- Max.melt %>%
  filter(Date != as.Date("2019-07-12"))%>%
  filter(Date != as.Date("2019-08-13"))

max.plot <- ggplot(Max.melt[c("variable","Time")], aes(x=Time, after_stat(density), color=variable, fill=variable)) +
  geom_area(
    size = 1.5, 
    position="identity",
    stat = "bin",
    binwidth=2,
    alpha = 0.5) +
  scale_x_continuous(name = "", breaks=c(0,6, 12, 18, 24), labels = c("00:00","6:00","12:00","18:00","24:00")) +
  scale_y_continuous(name = "Density of\nDaily Maxima") +
  scale_color_manual(name = NULL,
                     breaks = c("k_Max","V1_Max","F_Max","Q_Max"),
                     values = c("#F8766D","#7CAE00","#C77CFF","#00A5FF"),
                     labels=c(k_Max = expression(paste(italic('k')[600])),
                              V1_Max = expression(paste(italic('p'),"CO"[2])),
                              F_Max = expression(paste("CO"[2]," Evasion")),
                              Q_Max = expression(paste("Discharge"))
                              )) +
  scale_fill_manual(name = NULL,
                     breaks = c("k_Max","V1_Max","F_Max","Q_Max"),
                     values = c("#F8766D","#7CAE00","#C77CFF","#00A5FF"),
                     labels=c(k_Max = expression(paste(italic('k')[600])),
                              V1_Max = expression(paste(italic('p'),"CO"[2])),
                              F_Max = expression(paste("CO"[2]," Evasion")),
                              Q_Max = expression(paste("Discharge")))) +
    guides(color = guide_legend(
    label.position = "left",
    label.hjust = 1)) +
  theme_classic() +
  theme(axis.title.x = element_blank(),
        axis.text.x= element_text(size= 14),
        axis.title.y = element_text(size = 18, vjust=2.5),
        axis.text.y= element_text(size= 14),
        legend.title=element_blank(),
        legend.text=element_text(size=18)) + 
  theme(legend.position="top") +
  annotate("rect", xmin = 0, xmax = 6.24, ymin = 0, ymax = 0.4,
           alpha = .2) +
  annotate("rect", xmin = 18.35, xmax = 24, ymin = 0, ymax = 0.4,
           alpha = .2) +
  annotate("text", x = c(5.0,19), y = c(0.3,0.3), 
           label = c("Sunrise", "Sunset"), angle = 90, size=5)


###########
#MINIMUM
###########

Min.summary <- df %>% 
  group_by(Date) %>% 
  summarize(
    stn1_Q = min(stn1_Q),
    K600.effective= min(K600.effective, na.rm=TRUE),
    V1_adjusted= min(V1_adjusted, na.rm=TRUE),
    Flux_1 = min(Flux_1, na.rm=TRUE),
    tempC_421 = min(tempC_421, na.rm=TRUE))


#left join
Min.summary_Q <- left_join(Min.summary[c("Date","stn1_Q")],df[c("Date","stn1_Q","DateTime")], by = c("Date", "stn1_Q"))
Min.summary_Q$Q_Min <- format(Min.summary_Q$DateTime,"%H:%M:%S")
Min.summary_Q$stn1_Q <- NULL
Min.summary_Q$DateTime <- NULL

Min.summary_k <- left_join(Min.summary[c("Date","K600.effective")],df[c("Date","K600.effective","DateTime")], by = c("Date", "K600.effective"))
Min.summary_k$k_Min <- format(Min.summary_k$DateTime,"%H:%M:%S")
Min.summary_k$K600.effective <- NULL
Min.summary_k$DateTime <- NULL

Min.summary_V <- left_join(Min.summary[c("Date","V1_adjusted")],df[c("Date","V1_adjusted","DateTime")], by = c("Date", "V1_adjusted"))
Min.summary_V$V1_Min <- format(Min.summary_V$DateTime,"%H:%M:%S")
Min.summary_V$V1_adjusted <- NULL
Min.summary_V$DateTime <- NULL

Min.summary_F <- left_join(Min.summary[c("Date","Flux_1")],df[c("Date","Flux_1","DateTime")], by = c("Date", "Flux_1"))
Min.summary_F$F_Min <- format(Min.summary_F$DateTime,"%H:%M:%S")
Min.summary_F$Flux_1 <- NULL
Min.summary_F$DateTime <- NULL

#Min.summary_T <- left_join(Min.summary[c("Date","tempC_421")],df[c("Date","tempC_421","DateTime")], by = c("Date", "tempC_421"))
#Min.summary_T$T_Min <- format(Min.summary_T$DateTime,"%H:%M:%S")
#Min.summary_T$tempC_421 <- NULL
#Min.summary_T$DateTime <- NULL

Min.summary <- full_join(Min.summary_F,Min.summary_k, by = "Date")
Min.summary <- full_join(Min.summary,Min.summary_Q, by = "Date")
#Min.summary <- full_join(Min.summary,Min.summary_T, by = "Date")
Min.summary <- full_join(Min.summary,Min.summary_V, by = "Date")


#Reshape 
Min.melt <- melt(data = as.data.frame(Min.summary), id.vars = c("Date"), 
                 measure.vars = c("F_Min", "k_Min","Q_Min",
                                  #"T_Min",
                                  "V1_Min"))

Min.melt$Time <- as.numeric(hms(Min.melt$value))/60/60
Min.melt <- Min.melt %>%
  filter(Date != as.Date("2019-07-12")) %>%
  filter(Date != as.Date("2019-08-13"))


min.plot <- ggplot(Min.melt[c("variable","Time")], aes(x=Time, after_stat(density), color=variable, fill=variable )) +
  geom_area(
    size = 1.5, 
    position="identity",
    stat = "bin",
    binwidth=2,
    alpha = 0.5) +
  scale_x_continuous(name = "", breaks=c(0,6, 12, 18, 24), labels = c("00:00","6:00","12:00","18:00","24:00"), position = "top") +
  scale_y_reverse(name = "Density of\nDaily Minima") +
  scale_color_manual(name = NULL,
                     breaks = c("k_Min","V1_Min","F_Min","Q_Min","T_Min"),
                     values = c("#F8766D","#7CAE00","#C77CFF","#00A5FF","#E7861B"),
                     labels=c(k_Min = expression(paste(italic('k')[600])),
                              V1_Min = expression(paste(italic('p'),"CO"[2])),
                              F_Min = expression(paste("CO"[2]," Evasion")),
                              Q_Min = expression(paste("Discharge")),
                              T_Min = "Temperature")) +
  scale_fill_manual(name = NULL,
                    breaks = c("k_Min","V1_Min","F_Min","Q_Min","T_Min"),
                    values = c("#F8766D","#7CAE00","#C77CFF","#00A5FF","#E7861B"),
                    labels=c(k_Max = expression(paste(italic('k')[600])),
                             V1_Max = expression(paste(italic('p'),"CO"[2])),
                             F_Max = expression(paste("CO"[2]," Evasion")),
                             Q_Max = expression(paste("Discharge")),
                             T_Max = "Temperature")) +
  guides(fill = guide_legend(
    label.position = "left",
    label.hjust = 1)) +
  theme_classic() +
  theme(axis.title.x = element_blank(),
        axis.text.x= element_text(size= 14),
        axis.title.y = element_text(size = 18, vjust=2.5),
        axis.text.y= element_text(size= 14),
        legend.title=element_blank(),
        legend.text=element_text(size=18)) + 
  annotate("rect", xmin = 0, xmax = 6.24, ymin = 0, ymax = 0.4,
           alpha = .2) +
  annotate("rect", xmin = 18.35, xmax = 24, ymin = 0, ymax = 0.4,
           alpha = .2) +
  annotate("text", x = c(5.0,19), y = c(0.3,0.3), 
           label = c("Sunrise", "Sunset"), angle = 90, size=5)


full <- ggarrange(max.plot, min.plot,  
          ncol = 1, common.legend = TRUE,
          legend = "top")

g <- ggarrange(NULL,Diurnal, NULL, full, nrow=1,
               labels = c("A","","","B"),
               font.label = list(size = 24, color = "black", face = "bold"),
               widths = c(.1,.75,.1,1),
               heights = c(1,1,1,1))


pdf(here::here('figs/Fig4_TEST.pdf'), width = 12, height = 6)
g
dev.off()
