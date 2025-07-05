USE [TeatroManagementVs]

DECLARE @Now DateTime = GetDate()

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

-- NEEDS SOME WORK AFTER INSERT
-- CreatedBy and LastModifiedBy NEEDS TO BE CONVERTED TO USER NVarChar 