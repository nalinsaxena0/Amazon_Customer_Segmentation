/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/

IF OBJECT_ID ('bronze.cst_behaviour_raw', 'U') IS NOT NULL
	DROP TABLE bronze.cst_behaviour_raw;
GO

CREATE TABLE bronze.cst_behaviour_raw (
timestamp									NVARCHAR(500),
age											NVARCHAR(500),
gender										NVARCHAR(500),
purchase_frequency							NVARCHAR(500),
purchase_categories							NVARCHAR(500),
personalized_recommendation_frequency		NVARCHAR(500),
browsing_frequency							NVARCHAR(500),
product_search_method						NVARCHAR(500),
search_result_exploration					NVARCHAR(500),
customer_reviews_importance					NVARCHAR(500),
add_to_cart_browsing						NVARCHAR(500),
cart_completion_frequency					NVARCHAR(500),
cart_abandonment_factors					NVARCHAR(500),
saveforlater_frequency						NVARCHAR(500),
review_left									NVARCHAR(500),
review_reliability							NVARCHAR(500),
review_helpfulness							NVARCHAR(500),
personalized_recommendation_fy				NVARCHAR(500),
recommendation_helpfullness					NVARCHAR(500),
rating_accuracy								NVARCHAR(500),
shopping_satisfaction						NVARCHAR(500),
service_appreciation						NVARCHAR(500),
improvment_areas							NVARCHAR(500)
);
GO

