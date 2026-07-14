create table zepto_v2(
 sku_id serial primary KEY,
category varchar(120),
name varchar(150) not null,
mrp numeric(8,2),
discountpercent numeric(5,2),
avaliableQuantity integer,
discountedSellingPrice numeric(8,2),
weightInGrams integer,
outofStock Boolean,
quantity integer
);
