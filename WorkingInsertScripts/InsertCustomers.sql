USE [TeatroManagementVS]
GO

DECLARE @Now DateTime = GetDate()

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

GO


