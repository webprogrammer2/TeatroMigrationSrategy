USE [TeatroManagementVs]

DECLARE @Now DateTime = GetDate()

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