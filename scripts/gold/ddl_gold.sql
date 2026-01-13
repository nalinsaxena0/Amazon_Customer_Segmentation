/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================
Script Purpose:
    This script creates views for the Gold layer in the data warehouse. 
    The Gold layer represents the final dimension and fact tables (Star Schema)

    Each view performs transformations and combines data from the Silver layer 
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
===============================================================================
*/

--Creating VIEW gold.dim_customer
CREATE OR ALTER VIEW gold.dim_customer AS
SELECT
	customer_id,
	survey_timestamp,
	age,
	CASE
		WHEN age BETWEEN 18 AND 25 THEN '18-25'
		WHEN age BETWEEN 26 AND 35 THEN '26-35'
		WHEN age BETWEEN 36 AND 45 THEN '36-45'
		WHEN age BETWEEN 46 AND 60 THEN '46-60'
		ELSE '60+'
	END AS age_group,
	gender
FROM silver.cst_behaviour;
GO

--Creating VIEW gold.dim_purchase_behaviour
CREATE OR ALTER VIEW gold.dim_purchase_behaviour AS
SELECT
	customer_id,
	purchase_frequency,
	purchase_categories,
	personalized_recommendation_frequency,
	customer_reviews_importance
FROM silver.cst_behaviour;
GO

--Creating VIEW gold.dim_browsing_behaviour
CREATE OR ALTER VIEW gold.dim_browsing_behaviour AS
SELECT
	customer_id,
	browsing_frequency,
	product_search_method,
	search_result_exploration
FROM silver.cst_behaviour;
GO

-- Creating VIEW gold.dim_review_behaviour
CREATE OR ALTER VIEW gold.dim_review_behaviour AS
SELECT
	customer_id,
	review_left,
	review_reliability,
	review_helpfullness,
	personalized_recommendation_fy AS recommendation_helpfulness
FROM silver.cst_behaviour;
GO
