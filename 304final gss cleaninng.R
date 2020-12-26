#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from GSS
# Author: Mengying Li
# Data: 24 Dec 2020
# Contact: mying.li@mail.utoronto.ca 
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the data from X and save the folder that you're 
# interested in to inputs/data 
# - Don't forget to gitignore it!


#### Workspace setup ####
library(haven)
library(tidyverse)
setwd("/Users/zimuli/Downloads")
# Read in the raw data (You might need to change this if you use a different dataset)
raw_data <- read.csv("gss (1).csv")
# Add the labels
raw_data <- labelled::to_factor(raw_data)
# Just keep some variables
feelings_data <- 
  raw_data %>% 
  select(age,
         sex,
         education,
         income_respondent,
         children_in_household,
         marital_status,
         feelings_life)


#### What else???? ####

feelings_data$feelings_life<-as.numeric(feelings_data$feelings_life)
feelings_data$marital_status<-as.factor(feelings_data$marital_status)
feelings_data$sex<-as.factor(feelings_data$sex)
feelings_data$education<-as.factor(feelings_data$education)
feelings_data$income_respondent<-as.factor(feelings_data$income_respondent)
feelings_data$children_in_household<-as.factor(feelings_data$children_in_household)

# binary variable
feelings_data<-
  feelings_data %>%
  mutate(has_partner = 
           ifelse(marital_status == "Married" |
                    marital_status == "Living common-law", 1, 0))


feelings_data$has_partner<-as.factor(feelings_data$has_partner)

feelings_data <-na.omit(feelings_data)

# Saving the survey/sample data as a csv file in my
# working directory
write_csv(feelings_data, "feelings_data.csv")
