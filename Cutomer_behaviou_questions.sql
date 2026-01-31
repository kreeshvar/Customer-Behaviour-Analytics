--select *
--from customer;

----Q1-What is the total revenue genrated by male vs female customers?

--select gender,sum(purchase_amount) as 'Total_Revenue'
--from customer
--group by gender
--order by 2 desc;

----Q2- WHich customers used a discount but still spent more than the average purchase amount?

--select distinct customer_id,purchase_amount
--from customer
--where [discount_applied]='Yes' 
--and purchase_amount>=(select avg(purchase_amount) from customer)

----Q3 Which are the top 5 products with the highest average review rating?

--select top 5 item_purchased,round(avg(review_rating),2) as 'Average_Review_Rating'
--from customer
--group by item_purchased
--order by 2 desc

----Q4 Compare the average Purchase Amounts between Standard and Express Shipping

--Select shipping_type,avg(purchase_amount) as 'Average_Purchase_Amount'
--from customer
--where shipping_type in ('Express','Standard')
--group by shipping_type;

----Q5 Do subscribed customers spend more? Compare average spend and total revenue between subscribers and non-sbscribers?

--select subscription_status,
--count(customer_id) as 'Total_customers',
--avg(purchase_amount) as 'Average_Spend',
--sum(purchase_amount) as 'Total_Revenue'
--from customer
--group by subscription_status
--order by 4,3 desc;

----Q6 Which 5 products have the highest percentage of purchases with discounts applied?

--SELECT 
--    top 5 item_purchased,
--    ROUND(SUM(CASE WHEN discount_applied = 'Yes' THEN 1.0 ELSE 0.0 END) / COUNT(*) * 100,2) AS discount_rate
--FROM customer
--GROUP BY item_purchased
--order by 2 desc;

----Q7 Segment customers into New, Returning, and loyal based
----on their total number of previous purchases and show the count of eacch segment.

--with cte as(select customer_id,
--case when previous_purchases=1 then 'New'
--     when previous_purchases between 2 and 10 then 'Returning'
--     else 'Loyal'
--     end as 'Segment'
--from customer)
--select Segment,
--count(customer_id)as Customer_Count
--from cte
--group by Segment
--order by 2 desc; 

----Q8 What are the top 3 most purchased products within each category?


----select *
----from (select  
----item_purchased,
----category,
----purchase_amount,
----count(customer_id) as 'Total Orders',
----row_number() over(partition by category order by purchase_amount desc) as rowz
----from customer
----group by item_purchased, category, purchase_amount)t1
----where t1.rowz<=3;


--with item as(
--select category,
--item_purchased,
--count(customer_id) as 'Total_orders',
--row_number() over(partition by category order by count(customer_id)desc) as 'rank'
--from customer
--group by category,item_purchased)
--select rank,category,item_purchased,Total_orders
--from item
--where rank<=3;

----Q9 Are customers who are repeat buyers(more than 5 previos purchases) also likely to subscribe?

--select 
--subscription_status,
--count(customer_id) as customer_count
--from customer
--where previous_purchases>5
--group by subscription_status;


----Q10 What is the revenue contribution of each age group?

--select age_group,sum(purchase_amount) as 'Revenue_Contribution'
--from customer
--group by age_group
--order by 2 desc;




