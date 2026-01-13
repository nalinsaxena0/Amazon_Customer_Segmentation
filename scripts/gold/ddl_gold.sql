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

-- Creating VIEW gold.dim_cart_behaviour
CREATE OR ALTER VIEW gold.dim_cart_behavior AS
SELECT 
    customer_id,
    add_to_cart_browsing,
    cart_completion_frequency,
    cart_abandonment_factors,
    save_for_later_frequency
FROM silver.cst_behaviour;
GO

--Creating VIEW gold.dim_satisfaction
CREATE OR ALTER VIEW gold.dim_satisfaction AS
SELECT 
    customer_id,
    rating_accuracy,
    shopping_satisfaction,
    service_appreciation
FROM silver.cst_behaviour;
GO

-- Creating VIEW gold.fact_customer_behaviour
CREATE OR ALTER VIEW gold.fact_customer_behavior AS
SELECT
    c.customer_id,

    -- Foreign Keys (dimension linking)
    c.age_group,
    c.gender,

    pb.purchase_frequency,
    pb.purchase_categories,
    pb.personalized_recommendation_frequency,

    bb.browsing_frequency,
    bb.product_search_method,
    bb.search_result_exploration,

    rb.review_left,
    rb.review_helpfullness,
    rb.recommendation_helpfulness,

    cb.add_to_cart_browsing,
    cb.cart_completion_frequency,
    cb.cart_abandonment_factors,

    s.rating_accuracy,
    s.shopping_satisfaction,
    s.service_appreciation,

    -- Measures for segmentation
    pb.customer_reviews_importance

FROM gold.dim_customer c
LEFT JOIN gold.dim_purchase_behaviour pb 
ON pb.customer_id = c.customer_id
LEFT JOIN gold.dim_browsing_behaviour bb 
ON bb.customer_id = c.customer_id
LEFT JOIN gold.dim_review_behaviour rb 
ON rb.customer_id = c.customer_id
LEFT JOIN gold.dim_cart_behavior cb 
ON cb.customer_id = c.customer_id
LEFT JOIN gold.dim_satisfaction s 
ON s.customer_id = c.customer_id;
GO

