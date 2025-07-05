USE [TeatroManagementVS]
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
		,'System'
		,[payDate]
		,'System'
		,[payDate]
  FROM [Teatro20250629].[dbo].[payments]

GO
