# Packages
#install.packages("arules", dependencies = TRUE)
library(arules)

# Load data
source("load_data.R")

# Prepare data for apriori
apriori_data <- df[, c("Weather", "Traffic_Level", "Time_of_Day", "Vehicle_Type", 
                       "delivery_state", "distance_state", "Preparation_Time", 
                       "experience_yrs_state", "speed_state")]
apriori_data[] <- lapply(apriori_data, as.factor)

trans_data <- as(apriori_data, "transactions")

# Summary and item frequency
summary(trans_data)
itemFrequencyPlot(trans_data, topN=10, type="absolute", col="violetred")

# Generate rules
rules <- apriori(trans_data, parameter = list(supp = 0.01, conf = 0.4, minlen = 2))
summary(rules)

# Late delivery rules
late_rules <- subset(rules, rhs %in% "delivery_state=late")
sorted_late_rules <- sort(late_rules, by = "lift", decreasing = TRUE)
inspect(head(sorted_late_rules, n = 10))