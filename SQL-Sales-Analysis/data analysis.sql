create table customer (customer_id	int ,
	customer_name varchar(100),
	city varchar(50),
	signup_date	date ,
	email varchar(100)
);

create table orders (order_id int,
	customer_id	int,
	product	varchar (100),
	quantity int,
	price	int,
	order_date date,
	payment_mode varchar(50),
	delivery_status varchar (100)
);

create table employee (employee_id int,
	employee_name varchar(100),
	department varchar (100),
	salary int,
	manager_id int,
	joining_date date
);

	select * from customer;
	select * from employee;
	select * from orders;
	
	select c.customer_name ,
	o.quantity,
	o.product from customer c
	join orders o 
	on c.customer_id = o.customer_id;

---JOIN + SUM + GROUP BY + business analysis---

	SELECT c.customer_name,
       SUM(o.quantity * o.price) AS total_revenue
FROM customer c
JOIN orders o
       ON c.customer_id = o.customer_id
   GROUP BY c.customer_name
   ORDER BY total_revenue DESC
   limit 5 ;

----aggregation + GROUP BY + sorting------
	select product,
	sum(quantity)as total_quantity , sum(price)as total_price
	from orders 
	group by product
	order by total_quantity desc, 
	   total_price desc;

----join----

   select c.city, count(o.order_id) as total_order
	  from customer c
	  join orders o
	    on c.customer_id=o.customer_id
	    group by c.city
   order by total_order desc;


	   
----CASE WHEN / conditional logic-----
select order_id, delivery_status ,
	   case
	   		when delivery_status ='Delivered'
			   then 'completed'
			 when delivery_status='Pending'
			  	then 'in progress'
		else 'cancelled'
		end as final_status
	from orders;
	
-----left join----
	SELECT c.customer_name, o.product,o.quantity
	from customer c
	left join orders o
	on c.customer_id=o.customer_id
	order by c.customer_name, o.quantity desc ;

---cte----

 WITH revenue_table AS (
    SELECT product,
           SUM(quantity * price) AS revenue
    FROM orders
    GROUP BY product
)
  SELECT *
      FROM revenue_table;

----row_number()----
select employee_id ,employee_name , salary,
	row_number() over( order by salary desc)
	  as salary_rank
	     from employee;

-----partition by---

select o.customer_id, c.customer_name,o.price,o.product,
	dense_rank() over(partition by o.customer_id
    	order by o.price desc) as rank_inside_cutsomer
	       from customer c
	    join orders o
	 on c.customer_id=o.customer_id;
	