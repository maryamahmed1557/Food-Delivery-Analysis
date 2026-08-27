#library(readr)
#install.packages("ggplot2")
library(ggplot2)
#install.packages("read")
library(readr)
#install.packages("rpart")
source("load_data.R")
#select numeric features
x<-df[,c("Distance_km","Preparation_Time_min","speed_kmh","total_min_time_delivery",
         "Delivery_Time_min","Courier_Experience_yrs")]
head(x)
#scale all numeric features
x_scaled<-scale(x)
head(x_scaled)
#elbow method
wss<-sapply(1:10,function(k){
  kmeans(x_scaled,centers=k,nstart=25)$tot.withinss
})
plot(1:10,wss,type="b",
     xlab="Number of clusters(k)",
     ylab="within-cluster sum of squares",
     main="Elbow Method")
#assign a cluster label to each row
set.seed(123)
k<-3
kmean<-kmeans(x_scaled,centers=k,nstart=25)
df$cluster<-factor(kmean$cluster)
table(df$cluster)
#calculate summary statistics
library(dplyr)
summary<-df%>%group_by(cluster)%>%summarise(count=n(),
                                            mean_distance=mean(Distance_km),
                                            mean_prep=mean(Preparation_Time_min),
                                            mean_speed=mean(speed_kmh))
summary
#distance vs delivery time
library(ggplot2)
ggplot(df,aes(Distance_km,Delivery_Time_min,color=cluster))+
  geom_point()+
  scale_color_manual(values =c("purple","pink","#8A1538"))+
  theme_minimal()+
  labs(title = "Clusters Based on Distance and Delivery time")
#Distance vs Speed
ggplot(df,aes(Distance_km,speed_kmh,color=cluster))+
  geom_point()+
  scale_color_manual(values =c("purple","pink","#8A1538"))+
  theme_minimal()+
  labs(title = "Clusters Based on Distance and Speed")