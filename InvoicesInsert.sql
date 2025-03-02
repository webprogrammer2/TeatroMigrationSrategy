SET IDENTITY_INSERT [dbo].[Invoices] ON

INSERT INTO [dbo].[Invoices]
           ([Id]
		   ,[CustomerId]
           ,[TourId]
           ,[Title]
           ,[FirstName]
           ,[MiddleName]
           ,[LastName]
           ,[Organization]
		   ,[Address1]
		   ,[Address2]
		   ,[City]
		   ,[State]
		   ,[Zip]
           ,[Phone] 
           ,[Email] 
           ,[TotalAmount]
           ,[TotalPayments]
           ,[Voided]
           --,[VoidedDate]
           ,[VoidedComments]
           ,[Comments]
           ,[Confirmed]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[LastModifiedBy]
           ,[LastModifiedDate])

SELECT --top 2000
		i.[id]
	  ,i.[cust_id]
      ,i.[tour_id]
      ,t.[prefix]
	  ,t.[fname]
      ,t.[mname]
      ,IsNull(t.[lname], '')
	  ,t.[school]
	  ,t.[address1]
	  ,t.[address2]
	  ,t.[city]
	  ,t.[state]
	  ,t.[zip]
      ,t.[phone]
      ,t.[email]
	  ,i.[total]
	  ,i.[payments]
	  ,i.[void]
	  ,i.[voided_comments]
	  ,i.[comments]
	  ,i.[confirmed]
	  ,''
	  ,i.[invDate]
	  ,''
	  ,i.[invLastModified]

  FROM TeatroDB.[dbo].[invoices] i
  INNER JOIN TeatroDB.[dbo].[tours] tr ON (i.tour_id = tr.tour_id)
  INNER JOIN TeatroDB.[dbo].[teachers] t ON (i.cust_id = t.teacher_id)




SET IDENTITY_INSERT [dbo].[Invoices] OFF

-- delete Invoices
-- DBCC CHECKIDENT ('[Invoices]', RESEED, 0);