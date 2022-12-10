# Customers Subscription Analysis

## Goal of the Project
The CEO of a streaming service company started selling monthly and annual subscriptions, giving their customers unlimited on-demand access to exclusive videos.He wants to ensure all future investment decisions and new features were decided using data. This project focuses on using customer subscription data to answer important business questions.

## Project Description
This project focussess on two tables *Plans* and *Subscription* tables.

<img src="https://8weeksqlchallenge.com/images/case-study-3-erd.png" width=50% height=50%>

#### Plans
Customers can choose which plans to join when they first sign up.

Basic plan customers have limited access and can only stream their videos and is only available monthly at $9.90

Pro plan customers have no watch time limits and are able to download videos for offline viewing. Pro plans start at $19.90 a month or $199 for an annual subscription.

Customers can sign up to an initial 7 day free trial will automatically continue with the pro monthly subscription plan unless they cancel, downgrade to basic or upgrade to an annual pro plan at any point during the trial.

When customers cancel their Foodie-Fi service - they will have a churn plan record with a null price but their plan will continue until the end of the billing period.

#### Subscriptions
Customer subscriptions show the exact date where their specific plan_id starts.

If customers downgrade from a pro plan or cancel their subscription - the higher plan will remain in place until the period is over - the start_date in the subscriptions table will reflect the date that the actual plan changes.

When customers upgrade their account from a basic plan to a pro or annual pro plan - the higher plan will take effect straightaway.

When customers churn - they will keep their access until the end of their current billing period but the start_date will be technically the day they decided to cancel their service.

# Inference
* There are total of 1000 Customers.
* March is the month where the company has lot of subscribers.
* The Customer Churn rate is around 30%.
* There are 92 customers who have churned straight after their initial free trial, which 9% of the customer base.
* Around 195 customers have upgraded to an annual plan in 2020.
* It takes about 95 days on average does it take for a customer to upgrade to an annual plan from the day they join.
* 54.6% of customers choose basic monthly , 53.9% chose pro monthly, 25.8% chose annual and 30% customers churned after their initial trial.



