### How many customers are there
```
select count(distinct customer_id) as customers from subscriptions;
```
*RESULT*

<img width="109" alt="image" src="https://user-images.githubusercontent.com/38135441/206838509-cf40e471-eebc-498a-b73f-c096b7973c36.png">

### What is the monthly distribution of customers going for trial plan
```
select month(s.start_date) as month, count(DISTINCT s.customer_id) as customer_distribution
from subscriptions s join plans p 
on s.plan_id =p.plan_id
where p.plan_name ='trial'
group by month;
```
*RESULT*

<img width="220" alt="image" src="https://user-images.githubusercontent.com/38135441/206838810-fd17c66c-8b09-442d-8fb7-7a8fd8d06646.png">

### List the plans and the count of each plans that were subscribed after 2020
```
select p.plan_name, count(s.plan_id) as no_of_subscribers
from subscriptions s join plans p
on s.plan_id=p.plan_id
where start_date >= '2021-01-01'
group by plan_name;
```
*RESULT*

<img width="239" alt="image" src="https://user-images.githubusercontent.com/38135441/206839160-624d7e1c-12f8-4824-b71d-68342ffd0f96.png">

### What is the customer count and percentage of customers who have churned
```
with cte as(select count(distinct customer_id) as churn_customers from subscriptions s join plans p
on s.plan_id=p.plan_id 
where p.plan_name='churn')

select c.churn_customers,round(100*c.churn_customers/count(distinct s.customer_id),1) as Churn_Customer_Percentage from subscriptions s join cte c;

```
*RESULT*

<img width="290" alt="image" src="https://user-images.githubusercontent.com/38135441/206839558-ec33eeae-93d4-4c1b-a235-d9086b7f8e39.png">


### How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number
```
with cte1 as (SELECT customer_id, plan_name, p.plan_id, 
ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY p.plan_id) as plan_rank
FROM plans p
INNER JOIN subscriptions s
ON p.plan_id = s.plan_id),

cte2 as(select count(distinct customer_id) as churn_customers 
from cte1 where plan_id=4 and plan_rank=2)

select q.churn_customers, round(100*q.churn_customers/count(distinct s.customer_id),0) as Churn_Customer_Percentage 
from cte2 q join subscriptions s;
```
*RESULT*

<img width="266" alt="image" src="https://user-images.githubusercontent.com/38135441/206839858-4d15fbaa-0f6a-44b4-a178-ee247feef1b4.png">


### How many customers have upgraded to an annual plan in 2020
```
Select count(distinct customer_id) as Customers_annual_plan
from subscriptions s join plans p 
on s.plan_id =p.plan_id
where p.plan_name='pro annual' and year(start_date)=2020;

```
*RESULT*

<img width="145" alt="image" src="https://user-images.githubusercontent.com/38135441/206840040-77dc8f75-9362-4733-9b08-d8ab8812a881.png">

### How many days on average does it take for a customer to upgrade to an annual plan from the day they join
```
with trial_plan as(SELECT start_date from subscriptions s join plans p on s.plan_id =p.plan_id
WHERE plan_name='trial'),

annual_plan as(SELECT start_date from subscriptions s join plans p on s.plan_id =p.plan_id
WHERE plan_name='pro annual')

SELECT round(avg(datediff(annual_plan.start_date, trial_plan.start_date)), 2)AS avg_conversion_days
FROM trial_plan JOIN annual_plan;
```
*RESULT*

<img width="134" alt="image" src="https://user-images.githubusercontent.com/38135441/206840102-2b530c7b-4f8a-41bf-bd55-b3838058ded8.png">

### What is the percentage of customers who converted to becoming paid customer after the trial.
```
SELECT plan_name, round(100 *count(DISTINCT customer_id) /
			    (SELECT count(DISTINCT customer_id) AS 'distinct customers'
                FROM subscriptions), 2) AS 'customer percentage'
FROM subscriptions
JOIN plans USING (plan_id)
WHERE plan_name != 'trial'
GROUP BY plan_name
ORDER BY plan_id;
```
*RESULT*

<img width="223" alt="image" src="https://user-images.githubusercontent.com/38135441/206840164-75cfdcf4-0aa2-4d6c-bb54-b3dcb0694629.png">










