-- PD 11 Encontrar producto de cada categoria que tuvo la mayor venta en unides durante 1997
-- liste categoria.cod producto.nombre prod,cant vendida

create view prod1996q as 
select p.ProductName,p.CategoryID,ord.Quantity from Products p ,[Order Details] ord,Orders orden 
where p.ProductID = ord.ProductID 
and orden.OrderID = ord.OrderID 
and datepart(year,orden.OrderDate) = 1996

GO

create view productos(prod,cat,prodvendidos) as
select ProductName,CategoryID,sum(Quantity) from prod1996q
group by ProductName,CategoryID

GO



select a.*
from productos a
inner join(

		select cat,max(prodvendidos) maxp from productos
		group by cat) b on a.cat = b.cat and 
		a.prodvendidos = b.maxp
		order by cat asc

/* Version 2
select ca.CategoryID as Categoría, sum(od.Quantity) Cantidades, p.ProductID as CódigoProducto, p.ProductName
from Products p, Categories ca, Orders o, [Order Details] od
where p.CategoryID = ca.CategoryID and o.OrderID = od.OrderID and p.ProductID = od.ProductID and DATEPART(YEAR,o.OrderDate) = 1996
group by ca.CategoryID, p.ProductID, p.ProductName
having sum(od.Quantity) >= ALL(select sum(od.Quantity) from Products as p, Orders as o, [Order Details] as od where
p.CategoryID = ca.CategoryID and p.ProductID = od.ProductID and DATEPART(YEAR,o.OrderDate) = 1996 and o.OrderID = od.OrderID group by p.ProductID)
order by 1 desc*/