use magist;

-- How many orders are there in the dataset? 99441 orders
select CASE
	WHEN year(order_estimated_delivery_date)=2018 then "2018"
    WHEN year(order_estimated_delivery_date)=2017 then "2017"
    ELSE "2016"
END AS "year_delivery",
count(*) from orders
group by year_delivery;



-- How many products are there on the products table?   32 951
select count(*) from products;



-- How many of those products were present in actual transactions? 32 951
select product_id
from order_items
order by product_id desc;

--  make sure the product_id is distinct or not needed in the query
SELECT 
    COUNT(*) AS total_product,
    COUNT(product_id) AS count_product,
    COUNT(DISTINCT product_id) AS unique_product_count
FROM
    order_items;


-- What’s the price for the most expensive and cheapest products? 0.85e - 6735e
select 
max(price) as max_price,
min(price) as min_price
from order_items;


-- What are the highest and lowest payment values? (0 or 0,01 if we don't wanna include 0) or 13664.1e
select*from order_payments
order by payment_value asc;

select 
max(payment_value) as max_value,
min(payment_value) as min_value
from order_payments
where payment_value !=0;



-- Is Magist having a user growth by revenue? YES 
select
year(order_purchase_timestamp) as year_bought,
month(order_purchase_timestamp) as month_bought,
round(sum(price),2) as revenue
from order_items oi
join orders o using (order_id)
where order_status= "delivered"
group by year(order_purchase_timestamp), month(order_purchase_timestamp)
order by 
year(order_purchase_timestamp), 
month(order_purchase_timestamp);

-- How many months of data are included in the magist database? 25 months
SELECT 
    TIMESTAMPDIFF(
    MONTH,MIN(order_purchase_timestamp),
        MAX(order_purchase_timestamp)) AS total_months_from_the_dataset
FROM
    orders;


-- How many sellers are there? 3095
select count(*) from sellers;


select -- reviews per score
CASE
	WHEN year(review_creation_date)=2018 THEN "2018"
    WHEN year(review_creation_date)=2017 THEN "2017"
    ELSE "2016"
END AS "year_review",
review_score, count(*) as total_reviews
from order_reviews
group by review_score, year_review
order by 
year_review desc,
review_score desc;

