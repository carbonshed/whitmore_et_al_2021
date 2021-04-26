#Whitmore_et_al_2021
#fig5

library(here)
library(ggplot2)
library(ggpubr)

###############
###FIGURE 5####
###############

KinK600 <-  read.csv(here::here("data/Synoptic_Kin600.csv"))
KinK600$dist.as.charakter <- round(KinK600$dist.m, digits=1)
KinK600$dist.as.charakter <- as.character(KinK600$dist.as.charakter)

synoptic.df <- read.csv(here::here("data/Synoptic_Km600.csv"))
synoptic.df$dist.asCharakter <- as.character(synoptic.df$dist.m.AVE)
#get rid of na AND keffective negative value
synoptic.df_subset <- na.omit(synoptic.df)
synoptic.df <- subset(synoptic.df, DOY !=  210)

#Side by side boxplots of synop locations sorted by distance

box.kin <- ggplot(KinK600, aes(x = reorder(dist.as.charakter, K600.eq1, FUN = median), y = K600.eq1, fill=dist.m)) +
  geom_boxplot(size=1)

plot1.kin <- box.kin  + scale_y_log10(limits = c(1,915),breaks = c(3, 10, 30, 100, 300))+
  scale_fill_continuous(breaks = c(50,200), labels = c("50","200"), low="blue", high="red") +
  ylab(expression(paste(italic('k')[600-K] ," [m ", d^-1,"]"))) +
  xlab("Sample Location \nOrdered by Mean") +
  theme_classic()+
  theme(axis.title.x = element_text(size = 20, vjust=-1.0),
        axis.text.x= element_blank()) +
  theme(axis.title.y = element_text(size = 25, vjust=3.0),
        axis.text.y= element_text(size= 20)) +
  theme(legend.title=element_text(size=25)) +
  theme(legend.text=element_text(size=20))+
  labs(fill="Distance from \noutlet [m]") +
  
  theme(plot.margin=unit(c(1,1,1,1),"cm")) +
  
  annotate("text", x = "140.6", y = 400, colour = "black", label = "", size = 5) +
  annotate("text", x = "17", y = 350, colour = "black", label = "", size = 5) +
  annotate("text", x = "34.3", y = 350, colour = "black", label = "", size = 5) +
  annotate("text", x = "51.5", y = 350, colour = "black", label = "", size = 5) +
  annotate("text", x = "37.4", y = 350, colour = "black", label = "", size = 5) +
  annotate("text", x = "12.3", y = 350, colour = "black", label = "", size = 5) +
  annotate("text", x = "47.6", y = 350, colour = "black", label = "", size = 5) +
  annotate("text", x = "25.5", y = 350, colour = "black", label = "", size = 5) +
  annotate("text", x = "56.2", y = 350, colour = "black", label = "", size = 5) +
  annotate("text", x = "4", y = 300, colour = "black", label = "", size = 5)+
  annotate("text", x = "143.7", y = 400, colour = "black", label = "", size = 5) +
  annotate("text", x = "184.1", y = 350, colour = "black", label = "", size = 5) +
  annotate("text", x = "131.8", y = 408, colour = "black", label = "A", size = 5) +
  annotate("text", x = "208.2", y = 350, colour = "black", label = "", size = 5) +
  annotate("text", x = "63.7", y = 400, colour = "black", label = "", size = 5) +
  annotate("text", x = "169.9", y = 520, colour = "black", label = "B", size = 5) +
  annotate("text", x = "81.9", y = 350, colour = "black", label = "", size = 5) +
  annotate("text", x = "225.5", y = 350, colour = "black", label = "", size = 5) +
  annotate("text", x = "154.8", y = 695, colour = "black", label = "C", size = 5) +
  annotate("text", x = "245.2", y = 300, colour = "black", label = "", size = 5)+
  annotate("text", x = "67", y = 350, colour = "black", label = "", size = 5) +
  annotate("text", x = "217.6", y = 915, colour = "black", label = "D", size = 5) +
  annotate("text", x = "124.2", y = 350, colour = "black", label = "", size = 5) +
  annotate("text", x = "204.1", y = 350, colour = "black", label = "", size = 5) +
  annotate("text", x = "129", y = 350, colour = "black", label = "", size = 5) +
  annotate("text", x = "240.1", y = 350, colour = "black", label = "", size = 5) +
  annotate("text", x = "75.9", y = 350, colour = "black", label = "", size = 5) +
  annotate("text", x = "228.2", y = 350, colour = "black", label = "", size = 5) +
  annotate("text", x = "102.8", y = 350, colour = "black", label = "", size = 5) +
  annotate("text", x = "194.9", y = 300, colour = "black", label = "", size = 5)+
  annotate("text", x = "94.1", y = 350, colour = "black", label = "", size = 5) +
  annotate("text", x = "87.7", y = 350, colour = "black", label = "", size = 5) +
  annotate("text", x = "178.7", y = 695, colour = "black", label = "C", size = 5) +
  annotate("text", x = "161.9", y = 350, colour = "black", label = "", size = 5) +
  
  geom_segment(aes(x = "140.6", y = 350, xend = "75.9", yend = 350), size= 1) +
  geom_segment(aes(x = "140.6", y = 350, xend = "140.6", yend = 320), size= 1) +
  geom_segment(aes(x = "75.9", y = 350, xend = "75.9", yend = 320), size= 1) +
  geom_segment(aes(x = "17", y = 450, xend = "228.2", yend = 450), size= 1) +
  geom_segment(aes(x = "17", y = 450, xend = "17", yend = 418), size= 1) +
  geom_segment(aes(x = "228.2", y = 450, xend = "228.2", yend = 418), size= 1) +
  geom_segment(aes(x = "17", y = 600, xend = "194.9", yend = 600), size= 1) +
  geom_segment(aes(x = "17", y = 600, xend = "17", yend = 560), size= 1) +
  geom_segment(aes(x = "194.9", y = 600, xend = "194.9", yend = 560), size= 1) +
  geom_segment(aes(x = "87.7", y = 600, xend = "161.9", yend = 600), size= 1) +
  geom_segment(aes(x = "87.7", y = 600, xend = "87.7", yend = 560), size= 1) +
  geom_segment(aes(x = "161.9", y = 600, xend = "161.9", yend = 560), size= 1) +
  geom_segment(aes(x = "47.6", y = 800, xend = "161.9", yend = 800), size= 1) +
  geom_segment(aes(x = "47.6", y = 800, xend = "47.6", yend = 750), size= 1) +
  geom_segment(aes(x = "161.9", y = 800, xend = "161.9", yend = 750), size= 1)


box2.eff <- ggplot(synoptic.df, aes(x = reorder(dist.asCharakter, K600.effective, FUN = median), y = K600.effective, fill=dist.m.AVE)) +
  geom_boxplot(size=1)

plot2.eff <- box2.eff + theme_classic()  + scale_y_log10(limits = c(1,900),breaks = c(3, 10, 30, 100, 300))+
  scale_fill_gradient(low="blue", high="red")+
  ylab(expression(paste(italic('k')[600-M] ," [m ", d^-1,"]"))) +
  xlab("Sample Location \nOrdered by Mean") +
  theme_classic()+
  theme(axis.title.x = element_text(size = 20, vjust=-1.0),
        axis.text.x= element_blank()
  ) +
  theme(axis.title.y = element_text(size = 25, vjust=3.0),
        axis.text.y= element_text(size= 20)) +
  theme(legend.title=element_text(size=25)) +
  theme(legend.text=element_text(size=20))+
  theme(
    legend.box.background = element_rect(color="black", size=1),
    legend.box.margin = margin(1, 1, 1, 1))  +
  labs(fill="Distance from \noutlet [m]") +
  theme(plot.margin=unit(c(1,1,1,1),"cm")) +
  
  annotate("text", x = "143.7", y = 400, colour = "black", label = "", size = 7) +
  annotate("text", x = "0", y = 480, colour = "black", label = "A", size = 5) +
  annotate("text", x = "245.2", y = 400, colour = "black", label = "", size = 7) +
  annotate("text", x = "169.9", y = 720, colour = "black", label = "B", size = 5) +
  annotate("text", x = "194.9", y = 400, colour = "black", label = "", size = 7) + 
  
  geom_segment(aes(x = "143.7", y = 400, xend = "194.9", yend = 400), size= 1) +
  geom_segment(aes(x = "143.7", y = 400, xend = "143.7", yend = 350), size= 1) +
  geom_segment(aes(x = "194.9", y = 400, xend = "194.9", yend = 350), size= 1) +
  geom_segment(aes(x = "107.8", y = 600, xend = "94.1", yend = 600), size= 1) +
  geom_segment(aes(x = "107.8", y = 600, xend = "107.8", yend = 550), size= 1) +
  geom_segment(aes(x = "94.1", y = 600, xend = "94.1", yend = 550), size= 1) 

## Final plots
g.5 <- ggarrange(plot1.kin, plot2.eff, ncol = 2, labels = c("A", "B"), 
                 font.label = list(size = 30, color = "black", face = "bold", family = NULL),
                 label.x = .1,label.y = 1,
                 align="h", common.legend = TRUE,
                 legend = "right")

pdf(here::here("figs/Fig5.pdf"),
    width = 13,
    height = 6)
g.5
dev.off()
