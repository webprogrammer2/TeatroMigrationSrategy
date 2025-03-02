USE [TeatroManagementDB2]
GO

INSERT INTO [dbo].[Payments]
           ([InvoiceId]
           ,[PaymentType]
           ,[DocNumber]
           ,[Amount]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[LastModifiedBy]
           ,[LastModifiedDate])
     
SELECT	 [invId]
		,[payType]
		,[docNumber]
		,[amount]
		,'System migration'
		,[payDate]
		,'System migration'
		,[payDate]
  FROM [TeatroDB].[dbo].[payments]

GO




