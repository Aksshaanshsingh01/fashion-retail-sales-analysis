CREATE DATABASE IF NOT EXISTS fashion_retail;

USE fashion_retail;

CREATE TABLE fashion_sales (
    customer_id INT,
    item VARCHAR(100),
    purchase_amount DECIMAL(10,2),
    purchase_date DATE,
    review_rating DECIMAL(3,1),
    payment_method VARCHAR(50),
    month VARCHAR(7),
    quarter VARCHAR(7),
    day_of_week VARCHAR(20),
    price_band VARCHAR(20)
);

SELECT COUNT(*) AS total_rows
FROM fashion_sales;

