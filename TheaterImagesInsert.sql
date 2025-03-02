USE [TeatroManagementDb2]

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
	  , ''
	  ,GetDate()
	  ,''
	  ,GetDate()
  FROM TeatroDB.[dbo].[theater_images] ti
  INNER JOIN TeatroDB.[dbo].[theaters] t ON (t.id = ti.theater_id)

SET IDENTITY_INSERT [dbo].[TheaterImages] OFF



