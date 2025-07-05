USE [TeatroManagementVS]

DECLARE @Now DateTime = GetDate()

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