select*
from portfolioproject.dbo.[Nashville housing]
  /* satndardizing date format*/
select SaleDate,convert(date,SaleDate) as Converted_Date
from portfolioproject.dbo.[Nashville housing]
  /** filling null values in proparty adress column**/
select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress, isnull(a.PropertyAddress,b.PropertyAddress)
from portfolioproject.dbo.[Nashville housing] a
join portfolioproject.dbo.[Nashville housing] b
on a.ParcelID=b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null
update a
set a.PropertyAddress=isnull(a.PropertyAddress,b.PropertyAddress)
from portfolioproject.dbo.[Nashville housing] a
join portfolioproject.dbo.[Nashville housing] b
on a.ParcelID=b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null
select ParcelID,PropertyAddress
from portfolioproject.dbo.[Nashville housing]
where PropertyAddress is null
   /* splitting adress**/
select parsename(replace(OwnerAddress,',','.'),3),
parsename(replace(OwnerAddress,',','.'),2),
parsename(replace(OwnerAddress,',','.'),1)
from portfolioproject.dbo.[Nashville housing]
alter table dbo.[Nashville housing]
add ownersplitaddress nvarchar(225)
update dbo.[Nashville housing]
set ownersplitaddress=parsename(replace(OwnerAddress,',','.'),3)
alter table dbo.[Nashville housing]
add ownersplitcity nvarchar(225)
update dbo.[Nashville housing]
set ownersplitcity =parsename(replace(OwnerAddress,',','.'),2)
alter table dbo.[Nashville housing]
add ownersplitstate nvarchar(225)
update dbo.[Nashville housing]
set ownersplitstate=parsename(replace(OwnerAddress,',','.'),1)
  /* Replacing Y,N with Yes,No in soldasvacant column*/
select*from portfolioproject.dbo.[Nashville housing]
select distinct(SoldAsVacant),count(SoldAsVacant)
from portfolioproject.dbo.[Nashville housing]
group by SoldAsVacant
order by 2
select SoldAsVacant,
case when SoldAsVacant='Y' then 'Yes'
     when SoldAsVacant='N' then 'No'
     else SoldAsVacant
	 end
	 from portfolioproject.dbo.[Nashville housing]
update portfolioproject.dbo.[Nashville housing]
set SoldAsVacant=case when SoldAsVacant='Y' then 'Yes'
     when SoldAsVacant='N' then 'No'
     else SoldAsVacant
	 end
select*from portfolioproject.dbo.[Nashville housing]
   /* dropping unlikely use dcolumns*/
alter table portfolioproject.dbo.[Nashville housing]
drop column OwnerAddress,TaxDistrict,HalfBath