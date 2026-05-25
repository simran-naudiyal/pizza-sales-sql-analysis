--1.Retrieve all orders placed on 2015-01-01.
select * from orders
where date = '2015-01-01'

--2.List all distinct pizza categories available. 
select distinct(category) from Pizza_Types

--3.Find total number of pizzas ordered.
select sum(quantity) as total_pizzas from order_details

--4.Get the top 5 most frequently ordered pizza types.
select top 5 pt.name, sum(od.quantity) as total from
Pizzas p  join order_details od 
on p.pizza_id = od.pizza_id join Pizza_Types pt 
on p.pizza_type_id = pt.pizza_type_id
group by pt.name
order by total desc

--5.Show order_id and total pizzas ordered in each order.
select order_id , sum(quantity) as total_pizzas from order_details
group by order_id
order by order_id

--6.Find the number of orders placed in each hour of the day.
select  DATEPART(HOUR,time) HOURS, count(order_id) as total_order from orders
group by DATEPART(HOUR,time)
order by HOURS

--7.Find the day of the week on which the maximum number of orders were placed.
select top 1 datename(WEEKDAY,date) as day, count(order_id) as no_of_orders from orders
group by datename(WEEKday,date)
order by no_of_orders desc

--8.Find the earliest and latest order time for each day.
select date, min(time) as earliest, max(time) as latest from orders
group by date
order by date

--9.	Find the total revenue generated from each pizza type.
select sum(od.quantity*p.price) as total_revenue, pt.name from Pizza_Types pt join Pizzas p on pt.pizza_type_id = p.pizza_type_id
join order_details od on od.pizza_id = p.pizza_id
group by pt.name

--10.Which pizza category generated the maximum revenue?
select top 1 sum(od.quantity*p.price) as max_revenue, pt.category from Pizza_Types pt join Pizzas p on pt.pizza_type_id = p.pizza_type_id
join order_details od on od.pizza_id = p.pizza_id
group by pt.category
order by max_revenue desc

--11.Find the average number of pizzas ordered per order.
with cte as (
select order_id, SUM(quantity) as total_pizza
from order_details
group by  order_id)
select avg(total_pizza) as avg_pizzas_per_order
from cte

--12.List the top 3 orders which spent the most.
select Top 3 SUM(od.quantity * p.price) as spent , od.order_id   from order_details od join Pizzas p 
on od.pizza_id = p.pizza_id
group by order_id, p.price
order by spent  desc

--13.Find the cumulative revenue generated throughout the day (running total).
select o.time, o.date, round(sum(quantity*price),2) as revenue ,
sum(round(sum(quantity*price),2))  over( partition by o.date order by o.time) as cumulative_revenue
from orders o join order_details od 
on o.order_id = od.order_id join Pizzas p on od.pizza_id = p.pizza_id
group by o.date, o.time

--14.	Identify the pizza that has been ordered the least number of times.
select TOP 1 pt.name as name ,sum(quantity)  qty from Pizza_Types pt join Pizzas p 
on pt.pizza_type_id = p.pizza_type_id join order_details od
on od.pizza_id = p.pizza_id
group by pt.name
order by qty

--15.	Find the percentage contribution of each pizza category to total revenue.
select pt.category , round(sum(quantity*price),2) as total_revenue,
sum(round(sum(quantity*price),2)) over() as grand_total,
round(sum(quantity*price),2)*100/sum(round(sum(quantity*price),2)) over() as contribution
from Pizza_Types pt join Pizzas p 
on pt.pizza_type_id = p.pizza_type_id join order_details od
on od.pizza_id = p.pizza_id
group by pt.category

--16. Find the max Diffrence(minutes)  of each order placed on each day
with cte as (
select *,
lead(time) over (partition by date order by time) as next_order_time,
datediff(minute, time, lead(time) over (partition by date order by time)) as diff
from orders),
cte2 as (
select *,
dense_rank() over (partition by date order by diff desc) as rnk
from cte)
select * from cte2 
where rnk = 1

--17.find the rolling avg sales of last 3 months
with cte as (
select datepart(month, o.date) as sales_month,
round(sum(od.quantity * p.price),2) as total_revenue
from orders o join order_details od on o.order_id = od.order_id
join pizzas p on od.pizza_id = p.pizza_id
group by datepart(month, o.date))
select  sales_month,total_revenue,round(avg(total_revenue) 
over ( order by sales_month
rows between 2 preceding and current row),2) as rolling_3_month_avg
from cte

--18.compare the Previous Month Sales with the current month and show only declinig sales.

with cte as (
select datepart(month, o.date) as sales_month,sum(od.quantity * p.price) as current_sales
from orders o join order_details od on o.order_id = od.order_id
join pizzas p on od.pizza_id = p.pizza_id
group by month(o.date)),
cte2 as (
select sales_month, current_sales,
 lag(current_sales) over (order by sales_month) as prev_sales from cte)
select  sales_month,prev_sales,current_sales,(current_sales - prev_sales) as sales_drop
from cte2
where current_sales < prev_sales
