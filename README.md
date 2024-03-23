# COVID-19 Data Analysis Project (Sprints Big Data Final Project)

This project aims to analyze COVID-19 data using Power BI, Cloudera, HDFS, Hive, and Oozie. It includes visualizations created with Power BI, commands used to manage data with Cloudera and HDFS, as well as Hive queries to process data, and Oozie workflow to export data.

## Data Sample

The dataset used in this project contains COVID-19 statistics for different countries, including total cases, new cases, total deaths, new deaths, total recovered, active cases, serious/critical cases, and other metrics.

| Country | TotalCases | NewCases | TotalDeaths | NewDeaths | TotalRecovered | ActiveCases | SeriousCritical | Tot Cases/1M pop | Deaths/1M pop | TotalTests | Tests/1M pop | CASES per Test | Death in Closed Cases | Rank by Testing rate | Rank by Death rate | Rank by Cases rate | Rank by Death of Closed Cases |
|---------|------------|----------|-------------|-----------|----------------|-------------|-----------------|------------------|----------------|------------|--------------|----------------|----------------------|----------------------|-------------------|---------------------|-------------------------------|
| World   | 22849844   | 267351   | 796376      | 6186      | 15508345       | 6545123     | 61822           | 2931             | 102.2          |            |              | 0.0488         |                      | 52                   | 80                | 61                  |                               |
| USA     | 5746272    | 45341    | 177424      | 1090      | 3095484        | 2473364     | 16817           | 17346            | 536            | 73868332   | 222984       | 331272237      | 0.0542               | 19                   | 10                | 8                   | 53                            |
| Brazil  | 3505097    | 44684    | 112423      | 1234      | 2653407        | 739267      | 8318            | 16474            | 528            | 13748152   | 64616        | 212768400      | 0.0406               | 71                   | 11                | 10                  | 82                            |
| India   | 2904329    | 68507    | 54975       | 981       | 2157941        | 691413      | 8944            | 2102             | 40             | 32661252   | 23636        | 1381863561     | 0.0248               | 123                  | 87                | 90                  | 121                           |


## Power BI Visualizations

1. **Top 10 Death Rate with COVID - Map Visualization**: Shows the top 10 countries with the highest death rates due to COVID-19.
   
2. **Top 10 Testing Rate in a Map**: Visualizes the top 10 countries with the highest testing rates.
   
3. **Top 10 Testing Rate as a Pie Chart**: Represents the testing rates of the top 10 countries as a pie chart.

4. **Death Rate, Total Cases Rate, Tests Rate in Egypt**: Displays death rate, total cases rate, and tests rate specifically for Egypt.

## Cloudera and HDFS Commands

```bash
[root@quickstart cloudera]# mkdir -p /home/cloudera/covid_project/landing_zone/COVID_SRC_LZ/
[root@quickstart cloudera]# hdfs dfs -mkdir -p /user/cloudera/ds/COVID_HDFS_LZ/
[root@quickstart cloudera]# cp /media/sf_shared/covid-19.csv /home/cloudera/covid_project/landing_zone/COVID_SRC_LZ/
[root@quickstart cloudera]# hdfs dfs -put /home/cloudera/covid_project/landing_zone/COVID_SRC_LZ/covid-19.csv /user/cloudera/ds/COVID_HDFS_LZ/
```

## Hive Commands

### The hive commands are stored in hive_commands.sql file.

### Staging Table Schema

| Column               | Data Type |
|----------------------|-----------|
| Country              | VARCHAR(255) |
| TotalCases           | INT       |
| NewCases             | INT       |
| TotalDeaths          | INT       |
| NewDeaths            | INT       |
| TotalRecovered       | INT       |
| ActiveCases          | INT       |
| SeriousCritical      | INT       |
| Tot Cases/1M pop     | FLOAT     |
| Deaths/1M pop        | FLOAT     |
| TotalTests           | INT       |
| Tests/1M pop         | INT       |
| CASES per Test       | FLOAT     |
| Death in Closed Cases| INT       |
| Rank by Testing rate | INT       |
| Rank by Death rate   | INT       |
| Rank by Cases rate   | INT       |
| Rank by Death of Closed Cases | INT |

### ORC Table Schema (Partitioned by Country)

| Column               | Data Type |
|----------------------|-----------|
| TotalCases           | INT       |
| NewCases             | INT       |
| TotalDeaths          | INT       |
| NewDeaths            | INT       |
| TotalRecovered       | INT       |
| ActiveCases          | INT       |
| SeriousCritical      | INT       |
| Tot Cases/1M pop     | FLOAT     |
| Deaths/1M pop        | FLOAT     |
| TotalTests           | INT       |
| Tests/1M pop         | INT       |
| CASES per Test       | FLOAT     |
| Death in Closed Cases| INT       |
| Rank by Testing rate | INT       |
| Rank by Death rate   | INT       |
| Rank by Cases rate   | INT       |
| Rank by Death of Closed Cases | INT |

Partitioning column: Country

### Final Table Schema

| Column               | Data Type |
|----------------------|-----------|
| TotalCases           | INT       |
| NewCases             | INT       |
| TotalDeaths          | INT       |
| NewDeaths            | INT       |
| TotalRecovered       | INT       |
| ActiveCases          | INT       |
| SeriousCritical      | INT       |
| Tot Cases/1M pop     | FLOAT     |
| Deaths/1M pop        | FLOAT     |
| TotalTests           | INT       |
| Tests/1M pop         | INT       |
| CASES per Test       | FLOAT     |
| Death in Closed Cases| INT       |
| Rank by Testing rate | INT       |
| Rank by Death rate   | INT       |
| Rank by Cases rate   | INT       |
| Rank by Death of Closed Cases | INT |
| Country              | VARCHAR(255) |

## Oozie Workflow

The Oozie workflow exports the final table from Hive and is used to generate results in Power BI.
