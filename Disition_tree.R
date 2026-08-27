# Packages
#install.packages(c("rpart","rpart.plot","caret","RColorBrewer"), dependencies = TRUE)
library(rpart)
library(rpart.plot)
library(caret)
library(RColorBrewer)
#library(ggplot2)
#install.packages("dplR")
#library(dplyr)
# Load data
source("load_data.R")

# Select columns for tree

#condition
#library(dplyr)
summary(df$total_min_time_delivery)
df$delivery_state<-case_when(df$total_min_time_delivery>65~"late" ,
                             df$total_min_time_delivery<55~"Early", TRUE ~"on Time" )
summary(as.numeric(df$Distance_km))
df$distance_state<-case_when(df$Distance_km>10.15~"long distance",
                             df$Distance_km<5.10~"short distance", TRUE~"median distance")
summary(df$Preparation_Time_min)
df$Preparation_Time<-case_when(df$Preparation_Time_min>17~"Slow_prep", 
                               TRUE~"Fast_prep")
summary(df$Courier_Experience_yrs)
df$experience_yrs_state<-case_when(df$Courier_Experience_yrs>=5~"high experience",
                                   df$Courier_Experience_yrs<5~"low experience" )
summary(df$speed_kmh)
df$speed_state<-case_when(df$speed_kmh<=10.629 ~"slow",df$speed_kmh>10.629 ~"fast")

#tree
select_columns<-c("Traffic_Level","delivery_state","distance_state","Preparation_Time",
                  "experience_yrs_state","speed_state","Time_of_Day","Weather","Vehicle_Type")

tree_data<-df[ ,select_columns]
tree_data$delivery_state<-as.factor(tree_data$delivery_state)
set.seed(42)
training<-createDataPartition(tree_data$delivery_state,p=0.80,list = FALSE)
all_levels<-levels(tree_data$delivery_state)
train_data<-tree_data[training,]
test_data<-tree_data[-training,]
test_data$delivery_state<-factor(test_data$delivery_state,levels = all_levels)
train_data$delivery_state<-factor(train_data$delivery_state,levels = all_levels)

str(select_columns)
names(df)
tree_model<-rpart(delivery_state~.,data = train_data,method = "class",
                  control = rpart.control(minsplit = 20,minbucket = 10,cp = 0.02))
prediction<-predict(tree_model,test_data,type="class")
conf_matrix<-confusionMatrix(prediction,test_data$delivery_state)

rpart.plot(tree_model,
           type = 4,
           extra=101,
           cex = 0.6,
           branch.lwd=1.5,
           box.palette="plum",
           shadow.col="darkgray",
           main="delivery_state")
print(conf_matrix)