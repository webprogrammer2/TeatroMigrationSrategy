USE [TeatroManagementDb2]

SET IDENTITY_INSERT [dbo].[InvoiceDetails] ON

ALTER TABLE [dbo].[InvoiceDetails]
NOCHECK CONSTRAINT FK_InvoiceDetails_Eventos_EventoId;

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
  FROM TeatroDB.[dbo].[inv_det] d
  INNER JOIN TeatroDB.[dbo].[invoices] i ON (d.invId = i.id)
  INNER JOIN TeatroDB.[dbo].[events] e ON (d.eventId = e.id)
  --WHERE e.id is  null

  -- delete  from [dbo].[InvoiceDetails]



--31,541

SET IDENTITY_INSERT [dbo].[InvoiceDetails] OFF

-- try to enable constraint
ALTER TABLE [dbo].[InvoiceDetails]
WITH CHECK CHECK CONSTRAINT FK_InvoiceDetails_Eventos_EventoId;

/*
GO
DBCC CHECKCONSTRAINTS ('FK_InvoiceDetails_Eventos_EventoId');
GO
*/

