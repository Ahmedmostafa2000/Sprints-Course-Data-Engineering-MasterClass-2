CREATE DATABASE IF NOT EXISTS covid_data;

CREATE TABLE IF NOT EXISTS covid_data.staging_table (
    Country VARCHAR(255),
    TotalCases INT,
    ActiveCases INT,
    DeathInClosedCases INT,
    NewCases INT,
    TotalDeaths INT,
    NewDeaths INT,
    TotalRecovered INT,
    SeriousCritical INT,
    DeathsPerMillion FLOAT,
    TotalTests INT,
    CasesPerMillion FLOAT,
    RankByTestingRate INT,
    RankByDeathRate INT,
    RankByCasesRate INT,
    TestsPerMillion FLOAT,
    RankByDeathOfClosedCases INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;

CREATE TABLE IF NOT EXISTS covid_data.orc_table (
    TotalCases INT,
    ActiveCases INT,
    DeathInClosedCases INT,
    NewCases INT,
    TotalDeaths INT,
    NewDeaths INT,
    TotalRecovered INT,
    SeriousCritical INT,
    DeathsPerMillion FLOAT,
    TotalTests INT,
    CasesPerMillion FLOAT,
    RankByTestingRate INT,
    RankByDeathRate INT,
    RankByCasesRate INT,
    TestsPerMillion FLOAT,
    RankByDeathOfClosedCases INT
)
PARTITIONED BY (Country STRING)
STORED AS ORC;


CREATE TABLE IF NOT EXISTS covid_data.final_table (

    TotalCases INT,
    ActiveCases INT,
    DeathInClosedCases INT,
    NewCases INT,
    TotalDeaths INT,
    NewDeaths INT,
    TotalRecovered INT,
    SeriousCritical INT,
    DeathsPerMillion FLOAT,
    TotalTests INT,
    CasesPerMillion FLOAT,
    RankByTestingRate INT,
    RankByDeathRate INT,
    RankByCasesRate INT,
    TestsPerMillion FLOAT,
    RankByDeathOfClosedCases INT,
    Country VARCHAR(255)
)
STORED AS TEXTFILE;


LOAD DATA INPATH '/user/cloudera/ds/COVID_HDFS_LZ/covid-19.csv' INTO TABLE covid_data.staging_table;


INSERT INTO TABLE covid_data.orc_table PARTITION (Country)
SELECT
    TotalCases,
    ActiveCases,
    DeathInClosedCases,
    NewCases,
    TotalDeaths,
    NewDeaths,
    TotalRecovered,
    SeriousCritical,
    DeathsPerMillion,
    TotalTests,
    CasesPerMillion,
    RankByTestingRate,
    RankByDeathRate,
    RankByCasesRate,
    TestsPerMillion,
    RankByDeathOfClosedCases,
    Country
FROM
    covid_data.staging_table LIMIT 50;


INSERT INTO TABLE covid_data.final_table 
SELECT 
    TotalCases,
    ActiveCases,
    DeathInClosedCases,
    NewCases,
    TotalDeaths,
    NewDeaths,
    TotalRecovered,
    SeriousCritical,
    DeathsPerMillion,
    TotalTests,
    CasesPerMillion,
    RankByTestingRate,
    RankByDeathRate,
    RankByCasesRate,
    TestsPerMillion,
    RankByDeathOfClosedCases,
    Country
FROM covid_data.orc_table;
