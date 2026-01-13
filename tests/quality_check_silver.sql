SELECT gender
FROM bronze.cst_behaviour_raw
WHERE gender <> 'FEMALE' AND gender <> 'Male' AND gender <> 'Prefer not to say';

SELECT gender
FROM bronze.cst_behaviour_raw
WHERE gender <> TRIM(gender);

SELECT purchase_frequency
FROM bronze.cst_behaviour_raw
WHERE purchase_frequency <> TRIM(purchase_frequency);

-- similar tests for next columns.
