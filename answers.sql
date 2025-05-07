-- 1NF (First Normal Form)

SELECT
    OrderID,
    CustomerName,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n), ',', -1)) AS Product
FROM
    ProductDetail
CROSS JOIN
    (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3) AS numbers
ON
    LENGTH(Products) - LENGTH(REPLACE(Products, ',', '')) >= numbers.n - 1
ORDER BY
    OrderID;

-- 2NF (Second Normal Form)
