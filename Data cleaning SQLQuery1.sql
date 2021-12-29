-- standardize date format

select saledate, Convert(Date,saledate)
from Clean.dbo.sheet1$

Update Clean.dbo.sheet1$
Set saledate = Convert(Date,saledate)

-- Populate Property Address data
select propertyaddress
from Clean.dbo.sheet1$
where propertyaddress is null

select *
from Clean.dbo.sheet1$
order by parcelid

select a.parcelid, a.propertyaddress, b.parcelid, b.propertyaddress, isnull(a.propertyaddress, b.propertyaddress)
from Clean.dbo.sheet1$ a
join Clean.dbo.sheet1$ b
	on a.parcelid = b.parcelid
	and a.[UniqueID ] <> b.[UniqueID ]
where a.propertyaddress is null


-- Finding Duplicates
select parcelid, Count(parcelid)
from Clean.dbo.sheet1$
group by parcelid
having count(parcelid) > 1

-- Breaking Address into individual columns
select 
substring(propertyaddress, 1, CHARINDEX(',', propertyaddress) -1 ) as address
from Clean.dbo.sheet1$

alter table Clean.dbo.sheet1$
add propertysplitaddress nvarchar(255);

update Clean.dbo.sheet1$
set propertysplitaddress = SUBSTRING(propertyaddress, 1, CHARINDEX(',', propertyaddress) -1

alter table Clean.dbo.sheet1$
add propertysplitcity nvarchar(255);

update Clean.dbo.sheet1$
set propertysplitcity = SUBSTRING(propertyaddress, 1, CHARINDEX(',', propertyaddress) + 1 , LEN(Propertyaddress))
