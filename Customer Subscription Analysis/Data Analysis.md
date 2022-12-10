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
