USE [TeatroManagementVS]

SET IDENTITY_INSERT [dbo].[InvoiceDetails] ON

INSERT INTO [dbo].[InvoiceDetails]
           ([Id]
		   ,[InvoiceId]
           ,[EventoId]
           ,[TeachersQty]
           ,[StudentsQty]
           ,[TeachersPrice]
           ,[StudentsPrice]
           ,[Discount]
           ,[SubTotal]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[LastModifiedBy]
           ,[LastModifiedDate])


SELECT --TOP 100 
	   d.[id]
      ,d.[invId]
      ,d.[eventId]
      ,IsNull(d.[teachers], 0)
      ,IsNull(d.[students], 0)
      ,IsNull(d.[teachersPrice], 0.00)
      ,IsNull(d.[studentsPrice], 0.00)
      ,IsNull(d.[studentDiscount], 0.00)
      ,IsNull(d.[subTotal], 0.00)
	  ,''
	  ,GetDate()
	  ,''
	  ,GetDate()
  FROM Teatro20250629.[dbo].[inv_det] d
  INNER JOIN Teatro20250629.[dbo].[invoices] i ON (d.invId = i.id)
  INNER JOIN Teatro20250629.[dbo].[events] e ON (d.eventId = e.id)
  WHERE e.tour_id > 0 -- because there are some orfans records



SET IDENTITY_INSERT [dbo].[InvoiceDetails] OFF



