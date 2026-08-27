#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#
library(shiny)
library(dplyr)
library(ggplot2)
library(arules)
library(readr)
library(rpart)
library(rpart.plot)
library(caret)
# Define UI for application that draws a histogram
ui <- fluidPage(
  tags$head(
  tags$style(HTML("
      body{
      background-color:#FFFFFF;
      font-family:Arial,sans-serif;
      }  
      .well{
      background-color:#FFFFFF;
      border-right:2px solid#FF2F92;
      }
      main-panel,.tab-content{
      background-color:#FFFFFF;
      padding:20px;
      border-radius:10px;
      }
      .nav-tabs>li>a{
      background-color:FFE6F0;
      color:#8B0038;
      font-weight:600;
      border-radius:8px 8px 0 0;
      }
      .nav-tabs>li>a:hover{
       background-color:#FFE1EF;
      }
      .nav-tabs>li.active>a
     ,.nav-tabs>li.active>a:focus
     ,.nav-tabs>li.active>a:hover
     {
      background-color:#FF2F92;
      color:#FFFFFF
     }
      .well p,
      .well lebel,
      .well h4{
      color:#8B0038;
      }
      h4{
      color:#C4005A;
      font-weight:800;
      }
      p{
      color:#4A0020;
      font-size:14px
      }
      .button,.btn{
      background-color:#FF2F92;
      color:#fff;
      border:none;
      border-radius:6px;
      font-weight:600;
      }
      .button:hover,.btn:hover{
      background-color:#D6006A;
      }
      .irs--shiny .irs-bar{
      background-color:#FF77B7 !important;
      border-color:#FF2F92 !important;
      }
      .irs--shiny .irs-from{
      background-color:#FF2F92 !important;
      border-color:#FF2F92 !important;
      }
      .irs--shiny .irs-to{
      background-color:#D6006A !important;
      border-color:#D6006A !important;
      }
      .irs--shiny .irs-single{
      background-color:#FF2F92 !important;
      color:#FFFFFF !important;
      border-color:#D6006A !important;
      border-radius:7px !important;
      font-weight:bold !important;
      }
      .irs--siny .irs-single:before{
      border-top-color:#7B2E71 !important;
      }
      .irs--shiny .irs-handle{
      background-color:#FF2F92 !important;
      border-color:#8B0038 !important;
      }
      .irs-grid-text{
      color:#8B0038;
      }
      lable[for='file']{
      color:#8B0038 !important;
      font-weight:700 !important;
      font-size:15px !important;
      display:block !impoetant;
      margin-bottom:10px !important;
      }
      .shiny-input-container[data-shiny-input-type='file']{
      color:#8B0038;
      }
      .shiny-input-container .input-group .form-control {
        color: #8B0038 !important;
        background-color: #FFFFFF !important;
        border: 1px solid #FF2F92 !important;
        border-radius: 4px !important;
        padding: 8px 12px !important;
        font-size: 14px !important;
      }
      .shiny-input-container .input-group .form-control::placeholder {
        color: #C4005A !important;
        opacity: 0.7 !important;
        font-style: italic !important;
      }
      .shiny-input-container .input-group .form-control:not(:placeholder-shown) {
        color: #FF2F92  !important;
        font-weight: 500 !important;
        border-color: #D6006A !important;
      }
      @media(max-width:768px){
      .well{padding:12px !important;}
      }
      table {
      width: 100%;
      border-collapse: collapse;
      background-color: #FFFFFF;
      border-radius: 10px;
  overflow: hidden;
  box-shadow: 0 0 10px rgba(255,31,143,0.12);
      }
th {
  background-color: #FF2F92;
  color: #FFFFFF;
  font-weight: 800;
  text-align: center;
  padding: 10px;
  font-size: 14px;
}
td {
  text-align: center;
  padding: 9px;
  color: #8A0040;
  font-weight: 600;
  border-bottom: 1px solid #FFE1EF;
}
tr:nth-child(even) {
  background-color: #FFF1F7;
}
tr:nth-child(odd) {
  background-color: #FFFFFF;
}
tr:hover {
  background-color: #FFD6EB;
  transition: 0.2s ease;
}

.conf-box pre {
  background-color: #FFFFFF !important;   
  color: #8A0040 !important;              
  border: 2px solid #FF2F92 !important;   
  border-radius: 12px !important;
  padding: 15px !important;
  font-size: 14px !important;
  font-weight: 600 !important;
  box-shadow: 0 4px 10px rgba(255,47,146,0.25);
}

                  "))),
    # Application title
    titlePanel("Food Delivery Analysis GUI"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
      sidebarPanel(
        h4("controls"),
        fileInput("file1","Upload Dataset"),
        sliderInput("support","Support Threshold:",min = 0.01,max = 0.95,
                    value = 0.01 ),
        sliderInput("confidence","Confidence Threshold:",min = 0.1,max = 0.95,
                    value = 0.4 ),
        sliderInput("clusters","Clusters Threshold:",min = 3,max = 4,
                    value = 3 ),
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        tabsetPanel(
          tabPanel("Data overview",
                   h4("Data Table"),
                   tableOutput("data_table")
          ),
          tabPanel("Visualizations",
                   plotOutput("plot1"),
                   plotOutput("plot2"),
                   plotOutput("plot3"),
                   plotOutput("plot4"),
                   plotOutput("plot5"),
                   plotOutput("plot6"),
                   plotOutput("plot7"),
                   plotOutput("plot8"),
                   plotOutput("plot9"),
                   plotOutput("plot10"),
                   plotOutput("plot11"),
                   plotOutput("plot12")
          ),
          tabPanel("Clustering",
                   h4("clusters placeholder"),
                   tableOutput("cluster_summary"),
                   h4("Distance vs Delivery Time"),
                   plotOutput("cluster_plot1"),
                   h4("Distance vs Speed"),
                   plotOutput("cluster_plot2")
                   
          ),
          tabPanel("Rules",
                   h4("Rules Table placeholder"),
                   tableOutput("rules_table"),
                   h4("Top Items Frequency"),
                   plotOutput("rules_plot")
                   
          ),
          tabPanel("Decision Tree",
                   h4("Decision Tree Placeholder"),
                   plotOutput("decision_tree_plot"),
                   h4("confusion Matrix"),
                   #verbatimTextOutput("decision_tree_conf"),
                   div(class = "conf-box",
                       verbatimTextOutput("decision_tree_conf")
                   )
                   
          ),
          tabPanel("Insights",
                    h4("Key Insights & Conclusions"),
                    uiOutput("insights_ui")
          )
        )
      )
    )
  )
  # Define server logic required to draw a histogram
  server <- function(input, output) {
    #---Upload Data---
    data = reactive({
      req(input$file1)
      read.csv(input$file1$datapath)})
    #--- code clean---
    clean_data = reactive({
      df = data()
      df = df[,-c(1)]
      sum(duplicated(df))
      df=df[!duplicated(df),]#check repeat data
      summary(df)
      str(df)
      
      #numeric
      df$Distance_km=as.numeric(df$Distance_km)
      df$Preparation_Time_min=as.numeric(df$Preparation_Time_min)
      df$Delivery_Time_min=as.numeric(df$Delivery_Time_min)
      df$Courier_Experience_yrs=as.numeric(df$Courier_Experience_yrs)
      #remove outliers
      #check NA and replace it
      df$Distance_km[is.na(df$Distance_km)] = mean(df$Distance_km,na.rm = TRUE)
      df$Preparation_Time_min[is.na(df$Preparation_Time_min)] = mean(df$Preparation_Time_min,na.rm = TRUE)
      df$Delivery_Time_min[is.na(df$Delivery_Time_min)] = mean(df$Delivery_Time_min,na.rm = TRUE)
      df$Courier_Experience_yrs[is.na(df$Courier_Experience_yrs)] = mean(df$Courier_Experience_yrs,na.rm = TRUE)
      #text
      fill_na_mode <- function(x){
        x <- as.character(x)
        mode_val <- names(sort(table(x), decreasing = TRUE))[1]
        x[is.na(x) | x == ""] <- mode_val
        return(x)
      }
      df$Time_of_Day    <- fill_na_mode(df$Time_of_Day)
      df$Weather        <- fill_na_mode(df$Weather)
      df$Traffic_Level  <- fill_na_mode(df$Traffic_Level)
      remove_outliers <- function(x){
        Q1 <- quantile(x, 0.25, na.rm = TRUE)
        Q3 <- quantile(x, 0.75, na.rm = TRUE)
        IQR <- Q3 - Q1
        lower <- Q1 - 1.0 * IQR  
        upper <- Q3 + 1.0 * IQR
        x >= lower & x <= upper
      }
      boxplot(df$Delivery_Time_min, main="Before Removing Outliers" ,col = "#FFE1EF")
      df <- df[
        remove_outliers(df$Distance_km) &
          remove_outliers(df$Preparation_Time_min) &
          remove_outliers(df$Delivery_Time_min) &
          remove_outliers(df$Courier_Experience_yrs),
      ]
      boxplot(df$Delivery_Time_min,main="After Removing Outliers" ,col ="#FF2F92")
      
      #feature engineering
      df$speed_kmh<-df$Distance_km/(df$Preparation_Time_min/60)
      df$total_min_time_delivery<-df$Preparation_Time_min+df$Delivery_Time_min
      #flags
      df$late_delivery_flag<-ifelse(df$total_min_time_delivery>73,"late","on_time")
      #table number of items 
      table(df$Vehicle_Type)
      table(df$Courier_Experience_yrs)
      table(df$Weather)
      table(df$Traffic_Level)
      summary(df$total_min_time_delivery)
      numeric_cols <- c("Delivery_Time_min", "Distance_km", "Preparation_Time_min")
      #condition columns
      df$delivery_state <- case_when(
        df$total_min_time_delivery > 73 ~ "late",
        df$total_min_time_delivery < 55 ~ "Early",
        TRUE ~ "on Time"
      )
      
      df$distance_state <-case_when(
        df$Distance_km > 10.15 ~ "long distance",
        df$Distance_km < 5.10 ~ "short distance",
        TRUE ~ "median distance"
      )
      df$Preparation_Time <- case_when(
        df$Preparation_Time_min > 17 ~ "Slow_prep",
        TRUE ~ "Fast_prep"
      )
      
      df$experience_yrs_state <- case_when(
        df$Courier_Experience_yrs >= 5 ~ "high experience",
        TRUE ~ "low experience"
      )
      
      df$speed_state <-case_when(
        df$speed_kmh <= 11.671 ~ "slow",
        TRUE~"fast"
      )
      #conversion type
      df$Weather<-as.factor(df$Weather)
      df$Traffic_Level<-as.factor(df$Traffic_Level)
      df$Time_of_Day<-as.factor(df$Time_of_Day)
      df$Vehicle_Type<-as.factor(df$Vehicle_Type)
      df$speed_state<-as.factor(df$speed_state)
      df$experience_yrs_state<-as.factor(df$experience_yrs_state)
      df$Preparation_Time<-as.factor(df$Preparation_Time)
      df$distance_state<-as.factor(df$distance_state)
      df$delivery_state<-as.factor(df$delivery_state)
      
      df
    })
    #---code show data overview--
    output$data_table = renderTable({
      clean_data()
    })
    #---code visualizations--
    output$plot1 = renderPlot({
      df = clean_data()
      #par(mfrow=c(2,4),mar=c(4,4,3,2))
      # Delivery Time by Order
      plot(
        x=seq_along(df$Delivery_Time_min),
        y=df$Delivery_Time_min,
        col ="violet",
        main ="Compare Orders Time",
        xlab="Orders",
        ylab="Time in minutes"
      )
    })
    # Vehicle Type Pie
    output$plot2 = renderPlot({
      df = clean_data()
      x <- table(df$Vehicle_Type)
      percentage <- paste0(round(100*x/sum(x)),"%")
      pie(x, labels = percentage, main="Compare between vehicle", col=c("violetred", "aliceblue","violet"))
      legend("bottomright", legend = c("Cars", "Bikes", "Scooters"), fill= c("violetred","aliceblue","violet"))
    })
    # Delivery Time vs Distance
    output$plot3 = renderPlot({
      df = clean_data()
      plot(
        y=df$Delivery_Time_min,
        x=df$Distance_km,
        col ="violetred",
        main ="Distance Impact",
        xlab="Distance in kilometer",
        ylab="Time in minutes"
      )
    })
    # Weather Pie
    output$plot4 = renderPlot({
      df = clean_data()
      y <- table(df$Weather)
      percentage <- paste0(round(100*y/sum(y)),"%")
      pie(y, labels = percentage, main="Compare between Weather", col=c("violetred", "aliceblue","violet", "violetred2", "violetred4"))
      legend("topleft", legend = c("Clear", "Windy", "Foggy","Rainy", "Snowy"), fill= c("violetred","aliceblue","violet","violetred2", "violetred4"))
    })
    # Histograms
    output$plot5 = renderPlot({
      df = clean_data()
      hist(df$Distance_km, col="skyblue", border="blue", main="Distance Frequency", xlab="Distance", ylab="Frequency")
      hist(df$Preparation_Time_min, col="aliceblue", border="violetred", main="Preparation Time Frequency", xlab="Preparation Time", ylab="Frequency")
    })
    # Delivery Time Regarding Vehicle Type 
    output$plot6 = renderPlot({
      df = clean_data()
      boxplot(df$Delivery_Time_min ~ df$Vehicle_Type, 
              main="Delivery Time Regarding Vehicle Type Performance", 
              xlab="Vehicle Type", 
              ylab="Delivery Time (min)", 
              col=c("lightblue", "violet", "pink"))
    })
    # Delivery Time Distribution by Time of Day
    output$plot7 = renderPlot({
      df = clean_data()
      boxplot(df$Delivery_Time_min ~ df$Time_of_Day,
              main="Delivery Time Distribution by Time of Day",
              xlab="Time of Day",
              ylab="Delivery Time (min)",
              col=c("violetred","blue","violet","pink"))
    })
    #----------------------------------------------------
    # colunms of rating 
    output$plot8 = renderPlot({
      df =clean_data()
      df$Customer_Rating <- case_when(
        df$total_min_time_delivery <= 45  ~ 5,     # Very fast ->rating=5
        df$total_min_time_delivery <= 60  ~ 4,     # fast ->rating=4
        df$total_min_time_delivery <= 75  ~ 3,     # good ->rating=3
        df$total_min_time_delivery <= 90  ~ 2,     # slight delay ->rating=2
        TRUE ~ 1                                   # too late ->rating=1
      )
      df$Customer_Rating = as.factor(df$Customer_Rating)
      boxplot(total_min_time_delivery~Customer_Rating,data=df,
              main = "Rating",ylab = "Total Delivery Time",col="skyblue")
    })
    #Delivery Time Regarding The Weather Condition
    output$plot9 = renderPlot({
      df = clean_data()
      par(mfrow=c(4,1),mar=c(4,4,3,2))
      boxplot(df$Delivery_Time_min ~ df$Weather,
              main="Delivery Time Regarding The Weather Condition)",
              xlab="Weather Condition",
              ylab="Delivery Time (min)",
              col=c("violet", "aliceblue", "lightgray", "blue", "skyblue"))
    })
    # Customer Rating regarding Total Delivery Time
    output$plot10 = renderPlot({
      df = clean_data()
      df$Vehicle_Type=factor(df$Vehicle_Type)
      boxplot(Delivery_Time_min~Vehicle_Type,data=df,
              main = "Customer Rating regarding Total Delivery Time",
              xlab = "Vehicle Type",
              ylab = "Delivery Time (min)",
              col = c("lightblue","violet","pink"))
    })
    # Barplot Traffic Level
    output$plot11 = renderPlot({
      df = clean_data()
      traffic_counts <- table(df$Traffic_Level)
      barplot(traffic_counts,
              main="Number of Orders by Traffic Level", 
              xlab="Traffic Level", 
              ylab="Number of Orders", 
              col=c("pink","violetred","skyblue"))
    })
    # Boxplot Delivery Time
    output$plot12 = renderPlot({
      df = clean_data()
      boxplot(df$Delivery_Time_min, main="Delivery Time", ylab="Time in minutes", col="pink")
    })
    #---k means--
    cluster_data = reactive({
      df = clean_data()
      x<-df[,c("Distance_km","Preparation_Time_min","speed_kmh",
               "total_min_time_delivery","Delivery_Time_min","Courier_Experience_yrs")]
      #scale all numeric features
      x_scaled<-scale(x)
      k = input$clusters
      set.seed(123)
      kmean<-kmeans(x_scaled,centers=k,nstart=25)
      df$cluster<-factor(kmean$cluster)
      df
    })
    #calculate summary statistics
    output$cluster_summary = renderTable({
      df = cluster_data()
      df %>%group_by(cluster)%>%summarise(
        count=n(),
        mean_distance=round(mean(Distance_km),2),
        mean_prep=round(mean(Preparation_Time_min),2),
        mean_speed=round(mean(speed_kmh),2),
        mean_delivery =round(mean(Delivery_Time_min),2))
    })
    #distance vs delivery time
    output$cluster_plot1 = renderPlot({
      df = cluster_data()
      ggplot(df,aes(Distance_km,Delivery_Time_min,color=cluster))+
        geom_point(size=2)+
        scale_color_manual(values =c("purple","pink","#8A1538","#FF8C00"))+
        theme_minimal()+
        labs(title = "Clusters Based on Distance and Delivery time",
             x="Distance(Km)",
             y="Delivery Time (min)")
    })
    #Distance vs Speed
    output$cluster_plot2 = renderPlot({
      df = cluster_data()
      ggplot(df,aes(Distance_km,speed_kmh,color=cluster))+
        geom_point(size=2)+
        scale_color_manual(values =c("purple","pink","#8A1538","#FF8C00"))+
        theme_minimal()+
        labs(title = "Clusters Based on Distance and Speed",
             x= "Distance(Km)" ,
             y = "Speed (Km/h)")
    })
    #----Association rules
    output$rules_table = renderTable({
      df = clean_data()
      apriori_data <- df[, c("Weather", "Traffic_Level", "Time_of_Day", "Vehicle_Type", 
                             "delivery_state", "distance_state", "Preparation_Time", 
                             "experience_yrs_state", "speed_state")]
      apriori_data[] <- lapply(apriori_data, function(x)as.factor(x))
      trans_data <- as(apriori_data, "transactions")
      # Generate rules
      rules <- apriori(trans_data, parameter = list(supp = input$support, 
                                                    conf = input$confidence,  minlen = 2))
      # Late delivery rules
      late_rules <- subset(rules, rhs %in% "delivery_state=late")
      if(length(late_rules)==0){
        return(data.frame(Message="No rules found.Try lower support/confidence"))
      }else{
        sorted_late_rules <- sort(late_rules, by = "lift", decreasing = TRUE)
        return(as(head(sorted_late_rules, 10),"data.frame"))
      }
    })
    output$rules_plot = renderPlot({
      df = clean_data()
      apriori_data <- df[, c("Weather", "Traffic_Level", "Time_of_Day",
                             "Vehicle_Type", "delivery_state", "distance_state", "Preparation_Time", 
                             "experience_yrs_state", "speed_state")]
      apriori_data[] <- lapply(apriori_data, function(x)as.factor(x))
      trans_data <- as(apriori_data, "transactions")
      itemFrequencyPlot(trans_data,topN=10,type = "absolute",col="violetred",
                        main = "Top 10 Items Freqency")
    })
    #tree-------------------
    tree_model_data = reactive({
      df = clean_data()
      select_columns<-c("Traffic_Level","delivery_state","distance_state",
                        "Preparation_Time","experience_yrs_state","speed_state",
                        "Time_of_Day","Weather","Vehicle_Type")
      tree_data<-df[ ,select_columns]
      tree_data$delivery_state<-as.factor(tree_data$delivery_state)
      set.seed(42)
      training<-createDataPartition(tree_data$delivery_state,p=0.8,list = FALSE)
      all_levels<-levels(tree_data$delivery_state)
      train_data<-tree_data[training,]
      test_data<-tree_data[-training,]
      test_data$delivery_state<-factor(test_data$delivery_state,levels = all_levels)
      train_data$delivery_state<-factor(train_data$delivery_state,levels = all_levels)
      # names(df)
      model <-rpart(delivery_state~.,data = train_data,method = "class",
                    control = rpart.control(minsplit = 20 ,minbucket=10,cp=0.02))
      prediction<-predict(model,test_data,type="class")
      conf_matrix<-confusionMatrix(prediction,test_data$delivery_state)
      list(model=model,prediction=prediction,confusion = conf_matrix)
    })
    output$decision_tree_plot = renderPlot({
      tree_obj = tree_model_data()
      rpart.plot(tree_obj$model,
                 type = 4,
                 extra=101,
                 cex =0.6,
                 branch.lwd=1.5,
                 box.palette="pink",
                 shadow.col="pink",
                 branch.col = "#C4005A",
                 main="delivery_state Decision Tree")
    })
    output$decision_tree_conf = renderPrint({
      tree_obj = tree_model_data()
      print(tree_obj$confusion)
    })
    
    #--insight--
    
    output$insights_ui <- renderUI({
      
      tagList(
        
        h4("1. Primary Factors Causing Late Deliveries"),
        p(
          "Late deliveries are mainly influenced by long delivery distances, 
       high traffic levels, slow food preparation times, low courier experience,
       and adverse weather conditions. Orders that combine more than one of these
       factors show a significantly higher probability of delay."
        ),
        
        hr(),
        
        h4("2. Hidden Patterns in Delayed Deliveries (Association Rules)"),
        p(
          "Association rules analysis revealed that certain combinations of conditions
       frequently lead to late deliveries. High traffic combined with long distance,
       bike or scooter usage, and low courier experience are strongly associated
       with delayed orders. These patterns indicate that delays are systematic
       rather than random."
        ),
        
        hr(),
        
        h4("3. Meaningful Order Clusters (K-Means Clustering)"),
        p(
          "Clustering analysis grouped orders into clear operational segments. 
       One cluster represents short-distance, fast deliveries with low risk.
       Another cluster consists of long-distance, high-risk orders with longer
       delivery times. A third group is highly sensitive to traffic conditions.
       These clusters help identify risk levels before dispatch."
        ),
        
        hr(),
        
        h4("4. Predicting Late Deliveries (Decision Tree Model)"),
        p(
          "The decision tree model successfully predicts late deliveries before dispatch.
       The most important predictors are traffic level, distance category, preparation
       speed, courier experience, and weather conditions. The model provides clear
       and interpretable rules that support operational decision-making."
        ),
        
        hr(),
        
        h4("5. Recommended Actions for the Company"),
        tags$ul(
          tags$li("Assign experienced couriers to long-distance and high-risk orders."),
          tags$li("Optimize routing using real-time traffic data."),
          tags$li("Improve restaurant preparation speed during peak hours."),
          tags$li("Apply cluster-based dispatch strategies."),
          tags$li("Use early prediction models to warn customers about potential delays.")
        )
        
      )
    })
    
    }
  shinyApp(ui = ui, server = server)
  
  # Run the application