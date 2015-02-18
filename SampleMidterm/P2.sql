2A.
Π mfrid((σ salary>5000 (Owner)⋈Sale) ⋈ (σ color=”black”(Car)⋈ Manufacturer))

2B.
{T| ∃M∈Manufacturers, ∃S∈Sale, ∃O∈Owner, ∃C∈Car (T.mfrid=M.mfrid^
													M.mfrid=C.mfrid^
													C.color=“Black”^
													C.carid=S.saleid^
													S.ownerid=O.ownerid^
													O.salary>5000
												)
}

2C.
SELECT mfrid
FROM Manufacturer, Car, Owner, Sale
WHERE Car.mfrid = Manufacturer.mfrid
AND Car.color = “black”
AND Car.carid = Sale.carid
AND Sale.ownerid = Owner.ownerid
AND Owner.salary > 5000; EECS	484	

2d
This query finds all the salespersonids and prices of sales that took place on October 22 from a Dealership that is located in Ann Arbor

2e
π salespersonid,price((σ loc=”AnnArbor”(Dealer)⋈ Salesperson) ⋈ σ date=”October22”(Sale))

2f
{T|∃P∈Salesperson, ∃D∈Dealers, ∃S∈Sale (T.salespersonid=P.salespersonid ^
											T.price=S.price^
											S.salespersonid=P.salespersonid^
											P.dealerid=D.dealerid^
											D.loc=“AnnArbor”^
											S.date=“October22”
											)
}

2g
SELECT salespersonid
FROM Salesperson, Sale, Car, Manufacturer, Dealer
WHERE Salesperson.salespersonid = Sale.salespersonid
AND Sale.carid = Car.carid
AND Car.mfrid = Manufacturer.mfrid
AND Manufacturer.companyname = “Ford”
AND Salesperson.dealerid = Dealer.dealerid
AND Dealer.loc = “Ann Arbor”
GROUPBY salespersonid
HAVING AVG(price) > 20000

2h
SELECT Owner.ownerid, Owner.name
FROM Owner, Sale, Car
WHERE Owner.ownerid = Sale.saleid
AND Car.carid = Sale.carid
AND Car.color IN (
					SELECT Car.color, COUNT(*)
					FROM Sale, Owner, Car
					WHERE Sale.ownerid = Owner.ownerid
					AND Car.carid = Sale.carid
					AND Owner.salary > 25000
					GROUP BY Car.color
					HAVING COUNT(*) >= ALL(
											 SELECT COUNT(*)
											 FROM Sale, Owner, Car
											 WHERE Sale.ownerid = Owner.ownerid
											 AND Car.carid = Sale.carid Owner.salary > 25000
											 GROUPBY Car.color
										)
					) 