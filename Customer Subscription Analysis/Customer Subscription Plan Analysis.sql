/* How many customers are there?*/
select count(distinct customer_id) as customers from subscriptions;


/* What is the monthly distribution of customers going for trial plan*/
select month(s.start_date) as month, count(DISTINCT s.customer_id) as customer_distribution
from subscriptions s join plans p 
on s.plan_id =p.plan_id
where p.plan_name ='trial'
group by month;


/*List the plans and the count of each plans that were subscribed after 2020 */
select p.plan_name, count(s.plan_id) as no_of_subscribers
from subscriptions s join plans p
on s.plan_id=p.plan_id
where start_date >= '2021-01-01'
group by plan_name;


/*What is the customer count and percentage of customers who have churned*/
with cte as(select count(distinct customer_id) as churn_customers from subscriptions s join plans p
on s.plan_id=p.plan_id 
where p.plan_name='churn')

select c.churn_customers,round(100*c.churn_customers/count(distinct s.customer_id),1) as Churn_Customer_Percentage from subscriptions s join cte c;


/*How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?*/
with cte1 as (SELECT customer_id, plan_name, p.plan_id, 
ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY p.plan_id) as plan_rank
FROM plans p
INNER JOIN subscriptions s
ON p.plan_id = s.plan_id),

cte2 as(select count(distinct customer_id) as churn_customers 
from cte1 where plan_id=4 and plan_rank=2)

select q.churn_customers, round(100*q.churn_customers/count(distinct s.customer_id),0) as Churn_Customer_Percentage 
from cte2 q join subscriptions s;


/*How many customers have upgraded to an annual plan in 2020?*/
Select count(distinct customer_id) as Customers_annual_plan
from subscriptions s join plans p 
on s.plan_id =p.plan_id
where p.plan_name='pro annual' and year(start_date)=2020;


/*How many days on average does it take for a customer to upgrade to an annual plan from the day they join*/
with trial_plan as(SELECT start_date from subscriptions s join plans p on s.plan_id =p.plan_id
WHERE plan_name='trial'),

annual_plan as(SELECT start_date from subscriptions s join plans p on s.plan_id =p.plan_id
WHERE plan_name='pro annual')

SELECT round(avg(datediff(annual_plan.start_date, trial_plan.start_date)), 2)AS avg_conversion_days
FROM trial_plan JOIN annual_plan;


/*What is the percentage of customers who converted to becoming paid customer after the trial.*/
SELECT plan_name, round(100 *count(DISTINCT customer_id) /
			    (SELECT count(DISTINCT customer_id) AS 'distinct customers'
                FROM subscriptions), 2) AS 'customer percentage'
FROM subscriptions
JOIN plans USING (plan_id)
WHERE plan_name != 'trial'
GROUP BY plan_name
ORDER BY plan_id;

/*How many customers downgraded from a pro monthly to a basic monthly plan in 2020?*/
WITH next_plan_cte AS (
SELECT 
  customer_id, 
  plan_id, 
  start_date,
  LEAD(plan_id, 1) OVER(PARTITION BY customer_id ORDER BY plan_id) as next_plan
FROM subscriptions)

SELECT 
  COUNT(*) AS downgraded
FROM next_plan_cte
WHERE start_date <= '2020-12-31'
  AND plan_id = 2 
  AND next_plan = 1;
