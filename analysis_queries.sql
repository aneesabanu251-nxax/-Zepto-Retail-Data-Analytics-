select*from zepto_v2;
select count(*) from zepto_v2,
use zepto;
---#sample data----
select *from zepto_v2
limit 10;

-----#null valus------
select*from zepto_v2
where name is null
or
category is null
or
mrp is null
or
discountPercent is null
or
availableQuantity is null
or
discountedSellingPrice is null
or
weightInGms is null
or
outOfStock is null
or 
quantity is null;
describe zepto_v2;

----#different product categories----
select distinct Category 
from zepto_v2
order by Category;

------#products in stock vs out of stock -------
select outOfStock, count(*)
from zepto_v2
group by outOfStock;

-----# product names present multiple times----
select name, count(outOfStock) as "number of Stock Keeping Units"
from zepto_v2
group by name
having count(outOfStock)>1
order by count(outOfStock) DESC;

 ------- # its normal that e-commerce datasets that some datas are repeated many times------
 
 ------#data cleaning-----
 ----#product with price = 0-----
 select*from zepto_v2
 where mrp = 0 or discountedSellingPrice = 0;
 
 delete from zepto_v2
 where mrp = 0;

alter table zepto_v2
add column sku_id int not null auto_increment primary key first;
describe zepto_v2;

 update zepto_v2
 set mrp = mrp * 1.1
 where sku_id > 0;
 
 delete from zepto_v2
 where mrp = 0 and sku_id > 0;
 
 ----#convert paise to rupees----
 update zepto_v2
 set mrp = mrp /100.0,
 discountedSellingPrice = discountedSellingPrice/100.0
 where sku_id > 0;
 
 select sku_id,mrp,discountedSellingPrice
 from zepto_v2
 limit 10;
 use zepto;
 show tables;
 select count(*) from zepto_v2;
 use zeptoprj;
 select count(*) from zepto_v2;
 
 update zepto_v2
 set mrp = mrp /100.0,
 discountedSellingPrice = discountedSellingPrice/100.0
 where sku_id > 0;
 
select sku_id,mrp,discountedSellingPrice
 from zepto_v2
 limit 10;

alter table zepto_v2
modify column mrp decimal(10,2),
modify column discountedSellingPrice decimal(10,2);

select sku_id,mrp,discountedSellingPrice
 from zepto_v2
 limit 10;
 
 ---# find the top 10 best value products based on the discounted percentage
 select distinct name,mrp,discountPercent
 from zepto_v2
 order by discountPercent desc
 limit 10;
 
 select * from zepto_v2
 describe zepto_v2;
 
 ----# what are the products with high MRP but out of stock
 
 select distinct name,mrp
 from zepto_v2
 where outOfStock = true and mrp > 300
 order by mrp desc
 limit 10;
 
 select count(*) from zepto_v2
 where mrp>300;
 
 select outOfStock,count(*) as count_rows
 from zepto_v2
 group by outOfStock;
 
  select * from zepto_v2
 describe zepto_v2;
 
 select distinct outOfStock from zepto_v2;
 select count(*) from zepto_v2 where mrp > 300
 select count(*) from zepto_v2 where outOfStock = 1;

select name,mrp
from zepto_v2
where outOfStock = true and mrp > 300
order by mrp desc;

---#calculate estimated revenue for each category---
select category,
sum(discountedSellingPrice * availableQuantity) as total_revenue
from zepto_v2
group by Category
order by total_revenue

----#find all products where MRP is greater than 500 and discount is less than 10%

select distinct name,mrp,discountPercent
from zepto_v2
where mrp > 500 and discountPercent < 10
order by mrp desc , discountPercent desc;

----#identify the top 5 categories offering the highest range discount percentage
select category,
 round(avg(discountPercent),2) as avg_discount
 from zepto_v2
 group by category 
 order by avg_discount desc
 limit 5;
 
 ----# find the price per gram for products above 100g and sort best value.
 select distinct name,weightInGms,discountedSellingPrice,
 round(discountedSellingPrice/weightInGms,2) as price_per_gram
 from zepto_v2
 where weightInGms >= 100
 order by price_per_gram;
 
 describe zepto_v2;
 
 -----#group the products into categories like low,medium,bulk.---------
 select distinct name,weightInGms,
 case when weightInGms < 1000 then 'low'
 when weightInGms < 5000 then 'medium'
else 'bulk'
end as weight_category
from zepto_v2;

--------#what is the total inventory weight per category------
select category,
sum(weightInGms * availableQuantity) as total_weight
from zepto_v2
group by category
order by total_weight;