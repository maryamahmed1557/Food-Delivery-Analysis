# Load data from previou
# Plots
source("load_data.R")
# Delivery Time by Order
plot(
  x=seq_along(df$Delivery_Time_min),
  y=df$Delivery_Time_min,
  col ="violet",
  main ="Compare Orders Time",
  xlab="Orders",
  ylab="Time in minutes"
)

# Vehicle Type Pie
x <- table(df$Vehicle_Type)
percentage <- paste0(round(100*x/sum(x)),"%")
pie(x, labels = percentage, main="Compare between vehicle", col=c("violetred", "aliceblue","violet"))
legend("bottomright", legend = c("Cars", "Bikes", "Scooters"), fill= c("violetred","aliceblue","violet"))

# Delivery Time vs Distance
plot(
  y=df$Delivery_Time_min,
  x=df$Distance_km,
  col ="violetred",
  main ="Distance Impact",
  xlab="Distance in kilometer",
  ylab="Time in minutes"
)

# Weather Pie
y <- table(df$Weather)
percentage <- paste0(round(100*y/sum(y)),"%")
pie(y, labels = percentage, main="Compare between Weather", col=c("violetred", "aliceblue","violet", "violetred2", "violetred4"))
legend("topleft", legend = c("Clear", "Windy", "Foggy","Rainy", "Snowy"), fill= c("violetred","aliceblue","violet","violetred2", "violetred4"))

# Histograms
hist(df$Distance_km, col="skyblue", border="blue", main="Distance Frequency", xlab="Distance", ylab="Frequency")
hist(df$Preparation_Time_min, col="aliceblue", border="violetred", main="Preparation Time Frequency", xlab="Preparation Time", ylab="Frequency")

# Boxplot Delivery Time
boxplot(df$Delivery_Time_min, main="Delivery Time", ylab="Time in minutes", col="pink")

# Barplot Traffic Level
traffic_counts <- table(df$Traffic_Level)
barplot(traffic_counts,
        main="Number of Orders by Traffic Level", 
        xlab="Traffic Level", 
        ylab="Number of Orders", 
        col=c("pink","violetred","skyblue"))

# colunms of rating 
df$Customer_Rating <- case_when(
  df$total_min_time_delivery <= 45  ~ 5,     # Very fast ->rating=5
  df$total_min_time_delivery <= 60  ~ 4,     # fast ->rating=4
  df$total_min_time_delivery <= 75  ~ 3,     # good ->rating=3
  df$total_min_time_delivery <= 90  ~ 2,     # slight delay ->rating=2
  TRUE ~ 1                                   # too late ->rating=1
)

df$Customer_Rating <- as.factor(df$Customer_Rating)

# Customer Rating regarding Total Delivery Time
plot(
  x = df$Customer_Rating,
  y = df$total_min_time_delivery,
  main = "Customer Rating regarding Total Delivery Time",
  xlab = "Customer Rating (1-5)",
  ylab = "Total Delivery Time (min)",
  col = "skyblue"
)

#Delivery Time Regarding The Weather Condition
boxplot(df$Delivery_Time_min ~ df$Weather,
        main="Delivery Time Regarding The Weather Condition)",
        xlab="Weather Condition",
        ylab="Delivery Time (min)",
        col=c("violet", "aliceblue", "lightgray", "blue", "skyblue"))

# Delivery Time Regarding Vehicle Type 
boxplot(df$Delivery_Time_min ~ df$Vehicle_Type, 
        main="Delivery Time Regarding Vehicle Type Performance", 
        xlab="Vehicle Type", 
        ylab="Delivery Time (min)", 
        col=c("lightblue", "violet", "pink"))

# Delivery Time Distribution by Time of Day
boxplot(df$Delivery_Time_min ~ df$Time_of_Day,
        main="Delivery Time Distribution by Time of Day",
        xlab="Time of Day",
        ylab="Delivery Time (min)",
        col=c("violetred","blue","violet","pink"))