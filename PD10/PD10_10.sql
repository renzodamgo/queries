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