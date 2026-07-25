create database customer_behavior;
show databases;
select * from customer;

select gender,sum(purchase_amount) as revenue
from customer 
group by gender;

select avg(purchase_amount) from customer;

select customer_id,purchase_amount
from customer
where discount_applied = 'yes' and purchase_amount >= (select avg(purchase_amount) from customer);

select item_purchased,Round(avg(review_rating),2) as avg_rr
from customer 
group by item_purchased
order by avg_rr desc
limit 5;


select shipping_type,Round(AVG(purchase_amount),2)
from customer
where shipping_type in ('Standard','Express')
group by shipping_type;

select subscription_status,
count(customer_id) as total_customer,
avg(purchase_amount) as avg_spend,
sum(purchase_amount) as revenue
from customer
group by subscription_status
order by revenue,avg_spend desc;

SELECT item_purchased,
       ROUND(
           100 * SUM(CASE
                        WHEN discount_applied = 'Yes' THEN 1
                        ELSE 0
                     END) / COUNT(*),
           2
       ) AS discount_rate
       
       
FROM customer
GROUP BY item_purchased
ORDER BY discount_rate DESC
LIMIT 5;

WITH customer_type as (
select customer_id,previous_purchases,
CASE
	WHEN previous_purchases=1 THEN 'new'
	WHEN previous_purchases BETWEEN 2 AND 10 THEN 'Returning'
    ELSE 'Loyal'
    END AS Customer_segment
from customer
)
select customer_segment, count(*) as "Number of customere"
from customer_type
group by customer_segment;

select * from customer;


with item_counts as(
select category,
item_purchased,
COUNT(customer_id) as total_orders,
ROW_NUMBER() over(partition by category order by count(customer_id) desc) as item_rank
from customer
group by category,item_purchased
)
select item_rank,category,item_purchased,total_orders
from item_counts
where item_rank <=3;

select count(customer_id),
subscription_status
from customer
where previous_purchases>=5 
group by subscription_status;

select age_group,
sum(purcahse_amount) as total_revenue
from customer
group by age_group
order by total_revenue desc;







 
