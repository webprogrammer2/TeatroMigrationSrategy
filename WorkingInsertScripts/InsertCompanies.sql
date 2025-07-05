
USE TeatroManagementVS

SET IDENTITY_INSERT [dbo].[Companies] ON


INSERT INTO [dbo].[Companies]
           ([Id]
		   ,[Name]
           ,[CompanyAbbr]
           ,[PhoneNumber]
           ,[Address]
           ,[LogoPath]
           ,[LogoName]
           ,[LogoImage]
           ,[Message]
           ,[Website]
           ,[IsDefault]
           ,[Inactive]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[LastModifiedBy]
           ,[LastModifiedDate])

SELECT [company_id]
      ,IsNull([company_name], '')
      ,IsNull([company_abbr], '')
      ,IsNull([company_phone], '')
      ,IsNull([company_address], '')
      ,[company_logo_path]
      ,[company_logo_name]
      ,''
      ,[company_message]
      ,[company_website]
      ,0
	  ,0
	  ,'System'
	  ,GetDate()
	  ,'System',
	  GetDate()
  FROM [Teatro20250629].[dbo].[companies]

  SET IDENTITY_INSERT [dbo].[Companies] OFF