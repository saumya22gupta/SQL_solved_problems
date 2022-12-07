drop table if exists goldusers_signup;
CREATE TABLE goldusers_signup(userid integer,gold_signup_date date); 

INSERT INTO goldusers_signup(userid,gold_signup_date) 
 VALUES (1,'2017-09-22'),
(3,'2017-04-21');

drop table if exists users;
CREATE TABLE users(userid integer,signup_date date); 

INSERT INTO users(userid,signup_date) 
 VALUES (1,'2014-09-02'),
(2,'2015-01-15'),
(3,'2014-04-11');

drop table if exists sales;
CREATE TABLE sales(userid integer,created_date date,product_id integer); 

INSERT INTO sales(userid,created_date,product_id) 
 VALUES (1,'2017-04-19',2),
(3,'2019-12-18',1),
(2,'2020-07-20',3),
(1,'2019-10-23',2),
(1,'2018-03-19',3),
(3,'2016-10-20',2),
(1,'2016-11-09',1),
(1,'2016-05-20',3),
(2,'2017-09-24',1),
(1,'2017-03-11',2),
(1,'2016-03-11',1),
(3,'2016-11-10',1),
(3,'2017-12-07',2),
(3,'2016-12-15',2),
(2,'2017-11-08',2),
(2,'2018-09-10',3);


drop table if exists product;
CREATE TABLE product(product_id integer,product_name text,price integer); 

INSERT INTO product(product_id,product_name,price) 
 VALUES
(1,'p1',980),
(2,'p2',870),
(3,'p3',330);


select * from sales;
select * from product;
select * from goldusers_signup;
select * from users;

# What is the total amount each user spent on zomato?
select s.userid, sum(p.price) as Amount
from sales s inner join product p
on s.product_id=p.product_id
group by s.userid
order by userid;

# How many days has each customer visited zomato?
select userid, count(distinct(created_date)) as Visits
from sales
group by userid
order by userid;

# What was the first product purchased by each customer?
select * from
(select *, rank() over( partition by userid order by created_date) as rank_customer
from sales) a
where rank_customer=1;

# What is the maximun purchased product and how many times it was purchased by each user?
select userid, count(product_id)
from sales
where product_id=
(select product_id
from sales
group by product_id
order by count(product_id) desc
limit 1)
group by userid
order by userid;

# Which product was most popular for each customer?
select * from
(select*, rank() over(partition by userid order by cnt desc) as rnk
 from
(select userid,product_id, count(product_id) as cnt
from sales
group by userid,product_id
order by userid) a)b
where rnk=1;

# Which item was first purchased by a user after they became a member?
select* from
(select*, rank() over(partition by s.userid order by created_date) as ranking
from
(select s.userid,s.created_date,s.product_id,g.gold_signup_date
from goldusers_signup g inner join sales s
on g.userid=s.userid
and created_date>=gold_signup_date)a) b
where ranking=1;

# Which product was purchased just before the customer became a member?
select * from
(select*, rank() over(partition by s.userid order by created_date desc) as ranking
from
(select s.userid,s.created_date,s.product_id,g.gold_signup_date
from goldusers_signup g inner join sales s
on g.userid=s.userid
and created_date<gold_signup_date)a) b
where ranking=1;

# What are the total number of orders and total amount before a user became a member?
select g.userid,count(s.product_id) as order_number,sum(p.price) as Total_Amount
from goldusers_signup g inner join sales s
on g.userid=s.userid inner join product p
on s.product_id=p.product_id and s.created_date<g.gold_signup_date
group by g.userid
order by g.userid;

#Total points gained by users till now and the product with maximum points.
select * from
(select *, rank() over(partition by userid order by points desc) as ranking from
(select*,
case
	when a.product_id=1 then round(Total_Amount/5)
    when a.product_id=2 then round(Total_Amount/2)
    else round(Total_Amount/5)
end as Points from
(select s.userid,s.product_id,sum(p.price) as Total_Amount
from sales s inner join product p
on s.product_id=p.product_id
group by s.userid,s.product_id
order by s.userid) a) b) c
where ranking=1;
;


