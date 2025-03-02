SET IDENTITY_INSERT [dbo].[Checkins] ON

INSERT INTO [dbo].[Checkins]
           ([Id]
            ,[InvoiceId]
           ,[EventoId]
           ,[FirstName]
           ,[LastName]
           ,[Organization]
           ,[Address1]
           ,[Address2]
           ,[City]
           ,[State]
           ,[Zip]
           ,[StudentsQty]
           ,[TeachersQty]
           ,[Payment]
           ,[PaymentType]
           ,[PaymentDocument]
           ,[Amount]
           ,[Comments]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[LastModifiedBy]
           ,[LastModifiedDate]
           ,[signature])

SELECT [checkin_id]
      ,[inv_id] 
      ,[event_id]  
      ,[fname]
      ,[lname]
      ,[school_name]
      ,[address1]
      ,[address2]
      ,[city]
      ,[state]
      ,[zip]
      ,[students]
      ,[teachers]
      ,[payment]
      ,[payment_type]
      ,[payment_document]
      ,[payment_amount]
      ,[comments]
      ,'System'
      ,[date_stamp]
      ,'System'
      ,[date_stamp]
      ,[signature]
      
  FROM [TeatroDB].[dbo].[checkin]

SET IDENTITY_INSERT [dbo].[Checkins] OFF



