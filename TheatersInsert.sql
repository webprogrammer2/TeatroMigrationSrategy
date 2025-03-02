USE [TeatroManagementDb2]

SET IDENTITY_INSERT [dbo].[Theaters] ON

INSERT INTO [dbo].[Theaters]
           ([Id]
		   ,[Name]
           ,[Address1]
           ,[Address2]
           ,[Address3]
           ,[City]
           ,[State]
           ,[Zip]
           ,[Phone]
           ,[Fax]
           ,[Email]
           ,[Url]
           ,[Capacity]
           ,[ContactName]
           ,[ContactPhone]
           ,[ContactCell]
           ,[ContactFax]
           ,[Latitude]
           ,[Longitude]
           ,[Comments]
           ,[Rating]
           ,[StageHeight]
           ,[StageWidth]
           ,[StageDepth]
           ,[ProjectorLocation]
           ,[LastUsed]
           ,[TotalCost]
           ,[Inactive]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[LastModifiedBy]
           ,[LastModifiedDate])


SELECT [id]
      ,IsNull([name],'')
      ,IsNull([address1], '')
      ,[address2]
      ,[address3]
      ,IsNull([city], '')
      ,IsNull([state], '')
      ,IsNull([zip], '')
      ,[phone]
      ,[fax]
	  ,[email]
	  ,[url]
	  ,[capacity]
	  ,[contact_name]
      ,[contact_phone]
      ,[contact_cell]
	  ,[contact_fax]
	  ,[latitude]
      ,[longitude]
	  ,[comments]
	  ,IsNull([rating], 0)
	  ,[stage_height]
      ,[stage_width]
      ,[stage_depth]
      ,[proyector_location]
	  ,[last_used]
      ,[total_cost]
	  ,0
	  ,''
	  ,GetDate()
	  ,''
	  ,GetDate()

  FROM [TeatroDB].[dbo].[theaters]


SET IDENTITY_INSERT [dbo].[Theaters] OFF
