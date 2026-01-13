/*
===============================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
===============================================================================
Script Purpose:
    This stored procedure performs the ETL (Extract, Transform, Load) process to 
    populate the 'silver' schema tables from the 'bronze' schema.
	Actions Performed:
		- Truncates Silver tables.
		- Inserts transformed and cleansed data from Bronze into Silver tables.
		
Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC Silver.load_silver;
===============================================================================
*/

CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME;
	BEGIN TRY
		PRINT '==============================';
        PRINT 'Loading Silver Layer';
        PRINT '==============================';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table; silver.cst_behaviour'
		TRUNCATE TABLE silver.cst_behaviour;
		PRINT 'Inserting Data Into: silver.cst_behaviour';
		INSERT INTO silver.cst_behaviour (
		survey_timestamp,
		age,
		gender,
		purchase_frequency,
		purchase_categories,
		personalized_recommendation_frequency,
		browsing_frequency,
		product_search_method,
		search_result_exploration,
		customer_reviews_importance,
		add_to_cart_browsing,
		cart_completion_frequency,
		cart_abandonment_factors,
		save_for_later_frequency,
		review_left,
		review_reliability,
		review_helpfullness,
		personalized_recommendation_fy,
		rating_accuracy,
		shopping_satisfaction,
		service_appreciation,
		improvement_areas
		)
		
		SELECT 
		TRY_CONVERT( DATETIME, 
					 LEFT(timestamp, CHARINDEX('GMT', timestamp) - 1) ) AS survey_timestamp,
		TRY_CONVERT(INT, age) AS age,
		TRIM(gender) AS gender,

		TRIM(purchase_frequency) AS purchase_frequency,
		TRIM(purchase_categories) AS purchase_categories,
		TRIM(personalized_recommendation_frequency) AS personalized_recommendation_frequency,
		TRIM(browsing_frequency) AS browsing_frequency,
		TRIM(product_search_method) AS product_search_method,
		TRIM(search_result_exploration) AS search_result_exploration,

		TRY_CONVERT(INT, customer_reviews_importance) AS customer_reviews_importance,
		TRIM(add_to_cart_browsing) AS add_to_cart_browsing,
		TRIM(cart_completion_frequency) AS cart_completion_frequency,
		TRIM(cart_abandonment_factors) AS cart_abandonment_factors,
		TRIM(saveforlater_frequency) AS save_for_later_frequency,

		TRIM(review_left) AS review_left,
		TRIM(review_reliability)AS review_reliability, 
		TRIM(review_helpfulness) AS review_helpfulness,
		TRIM(personalized_recommendation_fy) AS personalized_recommendation_fy,

		TRY_CONVERT(INT, rating_accuracy) AS rating_accuracy,
		TRY_CONVERT(INT, shopping_satisfaction) AS shopping_satisfaction,
		TRIM(service_appreciation) AS service_appreciation,

		TRIM(improvment_areas) AS improvement_areas
		FROM bronze.cst_behaviour_raw
	END TRY
	BEGIN CATCH
		PRINT '=========================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================='
	END CATCH
END
