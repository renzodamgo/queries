/****** Script for SelectTopNRows command from SSMS  ******/
/*


SELECT e1.FirstName, e1.Country, 1.ReportsTo,e2.FirstName,e2.Country
from Employees as e1
JOIN Employees as e2 on  e2.EmployeeID =e1.ReportsTo 


SELECT *from Products as a where a.CategoryID = 5
update Products
set UnitPrice = UnitPrice*1.20
--set a.UnitPrice = a.UnitPrice*1.20
select a.ProductName, a.UnitPrice from Products as a where a.CategoryID =5



-- PD 10 10 Encontrar la categoria a la que pertenece la mayor cantidad de productos
-- Mostrar el nombre de la categoria y la cantidad de proudctos que comprende

select p.CategoryID,count(*) cant
from Products p
group by p.CategoryID

-- PD 11 Encontrar producto de cada categoria que tuvo la mayor venta en unides durante 1997
-- liste categoria.cod producto.nombre prod,cant vendida
GO
create view prod1996q as 
select p.ProductName,p.CategoryID,ord.Quantity from Products p ,[Order Details] ord,Orders orden 
where p.ProductID = ord.ProductID 
and orden.OrderID = ord.OrderID 
and datepart(year,orden.OrderDate) = 1996
GO
create view productos(prod,cat,prodvendidos) as
select ProductName,CategoryID,sum(Quantity) from prod1996q
group by ProductName,CategoryID

select a.*
from productos a
inner join(

		select cat,max(prodvendidos) maxp from productos
		group by cat) b on a.cat = b.cat and 
		a.prodvendidos = b.maxp
		order by cat asc
*/

select ca.CategoryID as Categoría, sum(od.Quantity) Cantidades, p.ProductID as CódigoProducto, p.ProductName
from Products p, Categories ca, Orders o, [Order Details] od
where p.CategoryID = ca.CategoryID and o.OrderID = od.OrderID and p.ProductID = od.ProductID and DATEPART(YEAR,o.OrderDate) = 1996
group by ca.CategoryID, p.ProductID, p.ProductName
having sum(od.Quantity) >= ALL(select sum(od.Quantity) from Products as p, Orders as o, [Order Details] as od where
p.CategoryID = ca.CategoryID and p.ProductID = od.ProductID and DATEPART(YEAR,o.OrderDate) = 1996 and o.OrderID = od.OrderID group by p.ProductID)
order by 1 desc