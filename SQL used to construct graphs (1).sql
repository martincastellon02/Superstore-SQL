 -- Business questions with Answeres in query form
--How many countries are in the APAC sales region?
 Answer:
 SELECT COUNT(country)
FROM regions 
WHERE UPPER(region) = 'APAC';

>>/ 

 Which products are made by Xerox?

 . SELECT product_name FROM products WHERE product_name LIKE '%Xerox%';

 select distinct product_name
from public.products
where product_name like '%Xerox%'


How many products are made by Xerox

select count (product_id)
from public.products
where product_name like '%Xerox%'

How many distinct products are there. (what is the count       )





-- what was the top sale in 2019
select max (sales)
from public.orders
where date_part ('year',order_date)=
 '2019'

 -- What was the average sale from 2019
 select round(
 avg(sales),2)

from orders
where date_part ('year',order_date)=
 '2019'

--	wat was the average sale in 2019 that used Second class shipping
select avg (sales)
from orders
where date_part ('year',order_date)=
 '2019' 
 and ship_mode ='Second Class'


-- OFFICE HOURS EXPLINATION !!!!!!!!!!!!!!!  11/10
Select segment, 
COUNT(*) 
AS num_sales
	from customers
	group by segment
HAVING Count(*) > 300;



-- What % of all orders were returns with reason "Wrong Color"?
Select round(avg(case
	when reason_returned = 'Wrong Color' 
	then 1 else 0 
	end),4) as Percent_wrong
from orders 
left join returns 
on orders.order_id = returns.order_id;



-- which region had the had the largest total sales in 2019?
select region, sum(sales)
from orders o 
join regions r
on o.region_id = r.region_id
where DATE_PART('year', order_date) = '2019'
group by region
order by 2 desc
limit 1;


-- Which country had the most returns in 2019 and how many returns did they have? 
select r.country, count(*)
from orders o
join regions r  
on o.region_id = r.region_id
join returns x
on x.order_id = o.order_id
where DATE_PART('year', return_date) = '2019'
group by 1
order by 2 desc;



-- what is the total sales by customer segment in 2019?
select segment, cast (Sum(sales) as money)
from orders o 
join customers c
on o.customer_id = c.customer_id
where DATE_PART('year', order_date) = '2019'
group by 1
order by 2 desc
limit 3;

-- which salesperson made the most sales in the united states in 2019 based on orders that were not returned?
select salesperson, count(*) As num_sales
from orders o
left join returns x
on o.order_id = x.order_id
join regions r 
on o.region_id = r.region_id
where country= 'United States'
AND x.order_id is null
AND date_part ('year',order_date)='2019'
group by 1
order by 2 desc 
limit 1;

-- how many orders were made by customers in corporate segment 
SELECT COUNT(*) 
FROM orders
JOIN customers USING (customer_id)
WHERE segment = 'Corporate';

--which orders included photo frame in the name
select distinct product_id
from products  
join orders
using (product_id)
where  product_name like '%Photo Frame%'

--
select quarter, ROUND(AVG(total_profit),2)
from(
select DATE_PART('year',order_date)as order_year,
	CASE
		when DATE_PART('month',order_date) IN(1,2,3)then 'Q1'
		 when DATE_PART('month',order_date) IN(4,5,6)then 'Q2'
		 when DATE_PART('month',order_date) in(7,8,9)then 'Q3'
		 when DATE_PART('month',order_date) in(10,11,12)then 'Q4'
		 End as quarter, SUM(profit) as total_profit
From orders 
group by 1,2) as temp
group by 1;
---
