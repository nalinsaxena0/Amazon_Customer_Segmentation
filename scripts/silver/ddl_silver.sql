
/*
===============================================================================
DDL Script: Create Silver Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'silver' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/

IF OBJECT_ID ('silver.cst_behaviour', 'U') IS NOT NULL
	DROP TABLE silver.cst_behaviour;
GO

CREATE TABLE silver.cst_behaviour (
customer_id								INT IDENTITY(1,1) PRIMARY KEY,

survey_timestamp						DATETIME NULL,
age										INT NULL,
gender									NVARCHAR(50) NULL,

purchase_frequency						NVARCHAR(50) NULL,
purchase_categories						NVARCHAR(200) NULL,
personalized_recommendation_frequency	NVARCHAR(50) NULL,
browsing_frequency						NVARCHAR(50) NULL,
product_search_method					NVARCHAR(50) NULL,
search_result_exploration				NVARCHAR(50) NULL,

customer_reviews_importance				INT NULL,
add_to_cart_browsing					NVARCHAR(50) NULL,
cart_completion_frequency				NVARCHAR(50) NULL,
cart_abandonment_factors				NVARCHAR(200) NULL,
save_for_later_frequency				NVARCHAR(50) NULL,

review_left								NVARCHAR(50) NULL,
review_reliability						NVARCHAR(50) NULL,
review_helpfullness						NVARCHAR(50) NULL,
personalized_recommendation_fy			NVARCHAR(50) NULL,

rating_accuracy							INT NULL,
shopping_satisfaction					INT NULL,
service_appreciation					INT NULL,

improvement_areas						NVARCHAR(MAX) NULL
);
GO
