/* Using MS SQL SERVER environment */

/*Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.*/
select CustomerId , (firstname + ' '+lastname) as fullName , Country from customer where Country <> 'USA'
/*Provide a query only showing the Customers from Brazil.*/
select * from Customer where Country ='Brazil'
/*Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.*/
/*inner join */
SELECT (Customer.firstname + ' '+Customer.lastname) as fullName , Invoice.InvoiceId, Invoice.InvoiceDate, Invoice.BillingCountry
FROM  Customer INNER JOIN
               Invoice ON Customer.CustomerId = Invoice.CustomerId
               where Country ='Brazil'
               
/*Provide a query showing only the Employees who are Sales Agents.*/
select * from Employee where Title like 'Sales % Agent'

/*Provide a query showing a unique list of billing countries from the Invoice table.*/
SELECT distinct BillingCountry FROM  Invoice
/*Provide a query showing the invoices of customers who are from Brazil.*/
SELECT Invoice.*
FROM  Customer INNER JOIN
               Invoice ON Customer.CustomerId = Invoice.CustomerId
                where Country ='Brazil'
                
/*Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.*/
SELECT Invoice.*, (Employee.LastName +' '+ Employee.FirstName) as EmplyeeFullName
FROM  Invoice INNER JOIN
               Customer ON Invoice.CustomerId = Customer.CustomerId INNER JOIN
               Employee ON Customer.SupportRepId = Employee.EmployeeId
               where Employee.Title like 'Sales % Agent'
               order by Invoice.InvoiceId
               
/*Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.*/
SELECT (Customer.FirstName+' '+ Customer.LastName) as 'customerName', Customer.Country, (Employee.LastName +' '+ Employee.FirstName) AS 'EmplyeeFullName', Invoice.Total
FROM  Customer INNER JOIN
               Employee ON Customer.SupportRepId = Employee.EmployeeId INNER JOIN
               Invoice ON Customer.CustomerId = Invoice.CustomerId
               
/*How many Invoices were there in 2009 and 2011? What are the respective total sales for each of those years?*/
SELECT sum(Total)as TotalPerYear , (year(InvoiceDate)) as yearvalue
FROM  Invoice
where  year(InvoiceDate) in (2011,2009)
group by year(InvoiceDate)

/*Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.*/
SELECT count(InvoiceLineId) as TotalNoLineItem
FROM  InvoiceLine 
where InvoiceId = 37

/*Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: GROUP BY*/
SELECT count(InvoiceLineId)as CountInvoiceLine,InvoiceId 
FROM  InvoiceLine
group by InvoiceId

/*Provide a query that includes the track name with each invoice line item.*/
SELECT InvoiceLine.InvoiceLineId, Track.Name
FROM  InvoiceLine INNER JOIN
               Track ON InvoiceLine.TrackId = Track.TrackId
               order by InvoiceId
               
/*Provide a query that includes the purchased track name AND artist name with each invoice line item.*/
SELECT Track.Name as TrackName, Artist.Name AS ArtistName, InvoiceLine.InvoiceLineId
FROM  Track INNER JOIN
               Album ON Track.AlbumId = Album.AlbumId INNER JOIN
               Artist ON Album.ArtistId = Artist.ArtistId INNER JOIN
               InvoiceLine ON Track.TrackId = InvoiceLine.TrackId
               order by InvoiceLineId
               
/*Provide a query that shows the # of invoices per country. HINT: GROUP BY*/
SELECT count(InvoiceId)as TotInvoice ,BillingCountry
FROM  Invoice
group by BillingCountry

/*Provide a query that shows the total number of tracks in each playlist. The Playlist name should be include on the resultant table.*/
SELECT COUNT( Track.TrackId) as TotNoTracks ,Playlist.Name
FROM  Track INNER JOIN
               PlaylistTrack ON Track.TrackId = PlaylistTrack.TrackId INNER JOIN
               Playlist ON PlaylistTrack.PlaylistId = Playlist.PlaylistId
               group by Playlist.Name
               order by TotNoTracks
               
/*Provide a query that shows all the Tracks, but displays no IDs. The resultant table should include the Album name, Media type and Genre.*/
SELECT Track.Name as TrackName, Genre.Name AS GenreName, MediaType.Name AS MediaTypeName, Album.Title as AlbumTitle
FROM  Album INNER JOIN
               Track ON Album.AlbumId = Track.AlbumId INNER JOIN
               Genre ON Track.GenreId = Genre.GenreId INNER JOIN
               MediaType ON Track.MediaTypeId = MediaType.MediaTypeId
               
/*Provide a query that shows all Invoices but includes the # of invoice line items.*/
SELECT Invoice.InvoiceId, count(InvoiceLine.InvoiceLineId) as TotNumberOfInvoiceLine
FROM  Invoice INNER JOIN
               InvoiceLine ON Invoice.InvoiceId = InvoiceLine.InvoiceId
               group by Invoice.InvoiceId
               
/*Provide a query that shows total sales made by each sales agent.*/
SELECT sum(Invoice.Total)as TotalSale,Customer.SupportRepId ,Employee.FirstName
FROM  Employee INNER JOIN
               Customer ON Employee.EmployeeId = Customer.SupportRepId INNER JOIN
               Invoice ON Customer.CustomerId = Invoice.CustomerId
               group by Customer.SupportRepId ,Employee.FirstName
               
/*Which sales agent made the most in sales in 2009?*/
SELECT Top 1 sum(Invoice.Total)as TotalSale,Customer.SupportRepId ,Employee.FirstName
FROM  Employee INNER JOIN
               Customer ON Employee.EmployeeId = Customer.SupportRepId INNER JOIN
               Invoice ON Customer.CustomerId = Invoice.CustomerId
               where Year(Invoice.InvoiceDate) = 2009
               group by Customer.SupportRepId ,Employee.FirstName
               order by TotalSale desc
               
/*Which sales agent made the most in sales in 2010?*/
SELECT TOP (1)  SUM(Invoice.Total) AS TotalSale, Customer.SupportRepId, Employee.FirstName 
FROM  Employee INNER JOIN
               Customer ON Employee.EmployeeId = Customer.SupportRepId INNER JOIN
               Invoice ON Customer.CustomerId = Invoice.CustomerId
               where Year(Invoice.InvoiceDate) = 2010
GROUP BY Customer.SupportRepId, Employee.FirstName, Invoice.InvoiceDate
ORDER BY TotalSale DESC

/*Which sales agent made the most in sales over all?*/
SELECT Top 1 sum(Invoice.Total)as TotalSale,Customer.SupportRepId ,Employee.FirstName
FROM  Employee INNER JOIN
               Customer ON Employee.EmployeeId = Customer.SupportRepId INNER JOIN
               Invoice ON Customer.CustomerId = Invoice.CustomerId
               group by Customer.SupportRepId ,Employee.FirstName
               order by TotalSale desc
               
/*Provide a query that shows the # of customers assigned to each sales agent.*/
SELECT count(Customer.CustomerId) as TotlCust  ,  Employee.FirstName
FROM  Customer INNER JOIN
               Employee ON Customer.SupportRepId = Employee.EmployeeId
               group by  Employee.FirstName
                        

/*Provide a query that shows the total sales per country. Which country's customers spent the most?*/
SELECT sum(Invoice.Total) as Totalspent ,Customer.Country
FROM  Customer INNER JOIN
               Invoice ON Customer.CustomerId = Invoice.CustomerId
               group by Customer.Country
               order by Totalspent desc
               
/*Provide a query that shows the most purchased track of 2013.*/
SELECT count(Invoice.InvoiceId) as TotInvoiceLines ,Track.TrackId
FROM  InvoiceLine INNER JOIN
               Track ON InvoiceLine.TrackId = Track.TrackId INNER JOIN
               Invoice ON InvoiceLine.InvoiceId = Invoice.InvoiceId
               where YEAR(Invoice.InvoiceDate) = 2013
               group by Track.TrackId 
               order by Track.TrackId 
               
/*Provide a query that shows the top 5 most purchased tracks over all.*/
SELECT Top 5 count(Invoice.InvoiceId) as TotInvoiceLines ,Track.TrackId 
FROM  InvoiceLine INNER JOIN
               Track ON InvoiceLine.TrackId = Track.TrackId INNER JOIN
               Invoice ON InvoiceLine.InvoiceId = Invoice.InvoiceId
               group by Track.TrackId 
               order by TotInvoiceLines asc
               
/*Provide a query that shows the top 3 best selling artists.*/
SELECT  Top 3 sum(Invoice.Total) as TotalInvoice, Artist.Name
FROM  Invoice INNER JOIN
               InvoiceLine ON Invoice.InvoiceId = InvoiceLine.InvoiceId INNER JOIN
               Album INNER JOIN
               Artist ON Album.ArtistId = Artist.ArtistId INNER JOIN
               Track ON Album.AlbumId = Track.AlbumId ON InvoiceLine.TrackId = Track.TrackId
               group by Artist.Name
               order by TotalInvoice desc


/*Provide a query that shows the most purchased Media Type.*/
SELECT sum(Invoice.Total) as TotlMostType, MediaType.Name
FROM  MediaType  INNER JOIN
               Track ON MediaType.MediaTypeId = Track.MediaTypeId INNER JOIN
               InvoiceLine ON Track.TrackId = InvoiceLine.TrackId INNER JOIN
               Invoice ON InvoiceLine.InvoiceId = Invoice.InvoiceId
               group by MediaType.Name 
               order by TotlMostType desc
