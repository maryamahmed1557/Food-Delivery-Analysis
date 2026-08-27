# 🍔 Food Delivery Analysis

An interactive **R Shiny** application designed to analyze food delivery data, discover patterns, segment customers, and generate useful insights through data analysis and machine learning techniques.

---

## 📌 Overview

The **Food Delivery Analysis** project provides an interactive dashboard for exploring and analyzing food delivery data.

The application performs data cleaning, feature engineering, exploratory analysis, customer segmentation, association rule mining, and decision tree classification.

The results are presented through an interactive graphical interface built with **R Shiny**.

---

## ✨ Key Features

### 🧹 Data Cleaning

* Handle missing values.
* Clean and prepare the dataset.
* Convert variables into suitable formats.
* Prepare the data for analysis and modeling.

### 📊 Exploratory Data Analysis

The application provides visual analysis of the dataset, helping identify:

* Order patterns
* Customer behavior
* Delivery-related trends
* Relationships between different variables

### 👥 Customer Segmentation

The project uses **Clustering** techniques to group customers based on their characteristics and behavior.

This helps identify different customer segments and understand their purchasing patterns.

### 🛒 Association Rule Mining

The application uses **Association Rules** to discover relationships between products and identify frequently occurring combinations.

This can help businesses understand which products are commonly purchased together.

### 🌳 Decision Tree

A **Decision Tree** model is used to analyze the data and identify factors that can influence the target outcome.

The model provides an interpretable way to understand relationships between features.

### 📈 Interactive Dashboard

The entire analysis is presented through an interactive **Shiny dashboard**, allowing users to explore the results dynamically.

---

## 🧠 Data Analysis Techniques

The project combines several analytical techniques:

| Technique               | Purpose                            |
| ----------------------- | ---------------------------------- |
| 🧹 Data Cleaning        | Prepare reliable data for analysis |
| 📊 Exploratory Analysis | Understand patterns and trends     |
| 👥 Clustering           | Segment customers                  |
| 🛒 Association Rules    | Discover product relationships     |
| 🌳 Decision Tree        | Analyze and predict outcomes       |

---

## 🛠️ Technologies & Libraries

### Programming Language

* **R**

### Framework

* **Shiny**

### Libraries

* `shiny`
* `dplyr`
* `ggplot2`
* `arules`
* `readr`
* `rpart`
* `rpart.plot`
* `caret`

---

## 📂 Project Structure

```text id="q7p3vn"
Food-Delivery-Analysis/
│
├── app.R
├── data/
│   └── dataset.csv
│
├── ...
│
└── README.md
```

> The exact structure may vary depending on the final project files.

---

## 🚀 How to Run

### 1. Install R

Make sure **R** is installed on your computer.

### 2. Install Required Packages

Open R or RStudio and run:

```r id="x2v8dy"
install.packages(c(
  "shiny",
  "dplyr",
  "ggplot2",
  "arules",
  "readr",
  "rpart",
  "rpart.plot",
  "caret"
))
```

### 3. Open the Project

Open the project in **RStudio**.

### 4. Run the Application

If the application is contained in `app.R`, run:

```r id="z3j4yc"
shiny::runApp()
```

---

## 📊 Insights

The application helps users understand:

* Customer purchasing behavior.
* Different customer segments.
* Frequently purchased product combinations.
* Important factors affecting outcomes.
* Trends and patterns within food delivery data.

---

## 🌱 What I Learned

Through this project, I gained practical experience in:

* Data cleaning and preprocessing.
* Exploratory Data Analysis.
* Data visualization.
* Customer segmentation using clustering.
* Association Rule Mining.
* Decision Tree modeling.
* Building interactive dashboards with R Shiny.
* Working with multiple R libraries.
* Turning raw data into meaningful insights.

---

## 👩‍💻 Project

This project was developed as part of my practical learning in **Data Analysis and Data Science**.

It gave me the opportunity to apply different analytical techniques to a real-world style dataset and present the results through an interactive application.

---

## ⭐ Future Improvements

Possible future improvements include:

* Adding more advanced machine learning models.
* Improving the dashboard design.
* Adding additional interactive filters.
* Supporting larger datasets.
* Adding more detailed business insights.
* Improving model evaluation and comparison.

---

### 📊 Built with R, Shiny & Data Analysis ❤️
