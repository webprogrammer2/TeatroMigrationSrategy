USE [TeatroManagementVs]
GO

DECLARE @Now DateTime = GetDate()

-- AspNetRoles

INSERT INTO [dbo].[AspNetRoles] ([Id],[Name],[NormalizedName],[ConcurrencyStamp]) VALUES ('1dcb22fe-3db9-4e6b-92c5-568a58c429ec','TeatroUser','TEATROUSER',4)
INSERT INTO [dbo].[AspNetRoles] ([Id],[Name],[NormalizedName],[ConcurrencyStamp]) VALUES ('60739fe2-fef7-4781-8904-beaf1863043e','ReadOnly','READONLY',6)
INSERT INTO [dbo].[AspNetRoles] ([Id],[Name],[NormalizedName],[ConcurrencyStamp]) VALUES ('6e237f6c-fddb-4472-a554-1bb5883e03db','WebUser','WEBUSER',3)
INSERT INTO [dbo].[AspNetRoles] ([Id],[Name],[NormalizedName],[ConcurrencyStamp]) VALUES ('8fcc0046-121b-4bd1-b314-c4af894389cd','Supervisor','SUPERVISOR',5)
INSERT INTO [dbo].[AspNetRoles] ([Id],[Name],[NormalizedName],[ConcurrencyStamp]) VALUES ('aee102c8-2e8a-4c07-8656-3ef81e24acc3','Owner','OWNER',1)
INSERT INTO [dbo].[AspNetRoles] ([Id],[Name],[NormalizedName],[ConcurrencyStamp]) VALUES ('c435711d-76c0-4439-9202-bb8160ceb407','Admin','ADMIN',2)



-- AppDefaulst

INSERT INTO [dbo].[AppDefaults]
           ([CompanyId]
           ,[TourId])
     VALUES
           (1
           ,1)


-- TOURS

USE [TeatroManagementVs]

DECLARE @Now DateTime = GetDate()

SET IDENTITY_INSERT [dbo].[Tours] ON

INSERT INTO [dbo].[Tours]
           ([Id]
		   ,[CompanyId]
           ,[Description]
           ,[TourYear]
           ,[Season]
           ,[IsOpen]
           ,[Inactive]
           ,[IsDefault]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[LastModifiedBy]
           ,[LastModifiedDate])
     

SELECT [tour_id]
      ,[company_id]
      ,IsNull([tour_desc],'')
      ,IsNull([tour_year], 0)
      --,[tour_season_id]
      ,[tour_season_desc]
      ,[open_tour]
      ,[inactive]
	  ,0
	  ,'System'
	  ,@now
	  ,'System'
	  ,@Now
  FROM Teatro20250629.[dbo].[tours]

  SET IDENTITY_INSERT [dbo].[Tours] OFF



-- COMPANIES

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
  
  -- CUSTOMERS

SET IDENTITY_INSERT [dbo].[Customers] ON

INSERT INTO [dbo].[Customers]
           ([Id]
		   ,[Organization]
           ,[Address1]
           ,[Address2]
           ,[City]
           ,[State]
           ,[Zip]
           ,[Zip4]
           ,[Prefix]
           ,[FirstName]
           ,[MiddleName]
           ,[LastName]
           ,[Suffix]
           ,[Title]
           ,[Phone]
           ,[PhoneExt]
           ,[Phone2]
           ,[Cellular]
           ,[Fax]
           ,[Email]
           ,[ContactPreference]
           ,[CourseSpanish]
           ,[CourseFrench]
           ,[CourseEnglish]
           ,[CourseArts]
           ,[CourseSocialStudies]
           ,[CourseAdmin]
           ,[CourseOther]
           ,[Inactive]
           ,[Comments]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[LastModifiedBy]
           ,[LastModifiedDate])

SELECT DISTINCT t.[teacher_id]
      ,t.[school]
      ,IsNull(t.[address1], '')
      ,t.[address2]
      ,IsNull(t.[city], '')
      ,IsNull(t.[state], '')
      ,IsNull(t.[zip], '')
      ,t.[zip4]
      ,t.[prefix]
      ,IsNull(t.[fname], '')
      ,t.[mname]
      ,IsNull(t.[lname], '')
      ,t.[suffix]
	  ,''
      ,t.[phone]
      ,t.[phone_ext]
      ,t.[phone2]
      --,t.[phone2_ext]
      --,t.[phonehome]
      ,t.[cellular]
      ,t.[fax]
      ,IsNULL(t.[email], '')
	  ,0
      ,t.[course_spanish]
      ,t.[course_french]
      ,t.[course_english]
      ,t.[course_arts]
      ,t.[course_social_studies]
      ,t.[course_admin]
      ,t.[course_other]
	  ,0
	  ,t.[comments]
      --,t.[delete_flag]
	  ,'System'
      ,IsNUll(t.[date_created], @Now)
	  ,'System'
      ,IsNUll(t.[date_modified], @Now)
      
  FROM [TEatro20250629].[dbo].[teachers] t
  --INNER JOIN [SQL2017_468866_hfbdb].[dbo].[invoices] i ON (t.teacher_id = i.cust_id)

  SET IDENTITY_INSERT [dbo].[Customers] OFF

-- EVENTOS
SET IDENTITY_INSERT [dbo].[Eventos] ON

INSERT INTO [dbo].[Eventos]
           ([Id]
		   ,[Code]
           ,[TourId]
           ,[TheaterId]
           ,[ShowId]
           ,[EventoDate]
           ,[PrivateEvento]
           ,[City]
           ,[State]
           ,[DefaultZip]
           ,[Comments]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[LastModifiedBy]
           ,[LastModifiedDate])

SELECT [id]
	  ,[code]
      ,e.[tour_id]
      ,[theaterId]
	  ,[showId]
      ,[eventDate]
      ,IsNull([private_event], 0)
      ,IsNull([city], '')
      ,IsNull([state], '')
	  ,IsNull([defaultZip],'')
      ,IsNull([comments], '')
      ,Convert(NVarchar(50),[userId])
	  ,@Now
	  ,Convert(NVarchar(50),[userId])
      ,@Now
      
  FROM Teatro20250629.[dbo].[events] e
  INNER JOIN Teatro20250629.[dbo].[tours] t ON (e.tour_id = t.tour_id)


SET IDENTITY_INSERT [dbo].[Eventos] OFF

-- invoices
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

SELECT 
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
	  ,'System'
	  ,i.[invDate]
	  ,'System'
	  ,IsNULL(i.[invLastModified], '1900-01-01')

  FROM Teatro20250629.[dbo].[invoices] i
  INNER JOIN Teatro20250629.[dbo].[tours] tr ON (i.tour_id = tr.tour_id)
  INNER JOIN Teatro20250629.[dbo].[teachers] t ON (i.cust_id = t.teacher_id)




SET IDENTITY_INSERT [dbo].[Invoices] OFF

-- SHOWS
SET IDENTITY_INSERT [dbo].[Shows] ON


INSERT INTO [dbo].[Shows]
           ([Id]
		   ,[Name]
           ,[TourId]
           ,[Description]
           ,[Duration]
           ,[ImagePath]
           ,[Comments]
           ,[WebShow]
           ,[WebDescription]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[LastModifiedBy]
           ,[LastModifiedDate])


SELECT [id]     
	  ,[name]
	  ,[tour_id]
	  ,[description]
	  ,[duration]
	  ,''
	  ,''
	  ,[show_web]
      ,[web_description]
      ,'System'
	  ,@Now
	  ,'System'
	  ,@Now
  FROM Teatro20250629.[dbo].[shows]

GO

SET IDENTITY_INSERT [dbo].[Shows] OFF

-- THEATERS

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
	  ,'System'
	  ,@Now
	  ,'System'
	  ,@Now

  FROM [Teatro20250629].[dbo].[theaters]


SET IDENTITY_INSERT [dbo].[Theaters] OFF

-- THEATER_IMAGES

SET IDENTITY_INSERT [dbo].[TheaterImages] ON


INSERT INTO [dbo].[TheaterImages]
           ([Id]
		   ,[ImageName]
           ,[TheaterId]
           ,[FileData]
           ,[Comments]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[LastModifiedBy]
           ,[LastModifiedDate])


SELECT ti.[image_id]
	  ,IsNull(ti.[image_name], '')
      ,ti.[theater_id]
      ,ti.[image]
	  ,ti.[comments]
	  , 'System'
	  ,@Now
	  ,'System'
	  ,@Now
  FROM Teatro20250629.[dbo].[theater_images] ti
  INNER JOIN Teatro20250629.[dbo].[theaters] t ON (t.id = ti.theater_id)

SET IDENTITY_INSERT [dbo].[TheaterImages] OFF

GO