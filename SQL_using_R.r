# SQL Using R
# PART 1 
# 8 19 2016

# Install "sqldf" package
install.packages("sqldf")
library("sqldf")

# Load data
setwd("Z:/path")
dir()
data <- read.csv("SQL Latest Version Data 7 1 2016.csv")

# Select two columns of interest
count_table <- sqldf("select Name, Classification from data")

# Select two columns, but only for individual 
ind_table <- sqldf("select Name, Classification, from data 
                     where Classification = 'Individual' ")

# Select two columns, but only for individual 
ind_inst_table <- sqldf("select Name, Classification, Cluster from data 
                   where Classification = 'Individual' OR Classification = 'Institutional'")

# Use the "not in" syntax
NOT_ind_inst_table <- sqldf("select Name, Classification, Cluster from data 
                   where Classification not in ('Individual','Institutional') ")

# Select all function
ind_all_table <- sqldf("select * from data where Classification = 'Individual'")

# Aggregate and count   MIS TABLE!!!!
classification_count <- sqldf("select Classification as Class, count(*) as Number from data group by Classification")

# Usage table
usage_table <- sqldf("select *,
            case when Classification in ('Individual','Institutional') then 'Business'
                 when Classification in ('Economic Capital') then 'Regulatory'
                 when Classification in ('Finance/Treasury') then 'Finance'
                 when Classification in ('External Vendor') then 'Vendor'
            ELSE 'Not Bau' END as Usage
            from data")

# Usage summaries
usage_count <- sqldf("select Usage, count(*) from usage_table group by Usage")
usage_count_nested <- sqldf("select Usage, Classification, count(*) from usage_table group by Usage, Classification")

# Convert to year
format(as.Date(strsplit(toString(data$CreatedOn[1]),' ')[[1]][1],format="%m/%d/%Y"),'%Y')
