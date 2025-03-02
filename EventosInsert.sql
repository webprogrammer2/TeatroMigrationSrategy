USE [TeatroManagementDb2]

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
	  ,GetDate()
	  ,Convert(NVarchar(50),[userId])
      ,GetDate()
      
  FROM TeatroDB.[dbo].[events] e
  INNER JOIN TeatroDB.[dbo].[tours] t ON (e.tour_id = t.tour_id)

SET IDENTITY_INSERT [dbo].[Eventos] OFF


-- Check for violations
/*
GO
DBCC CHECKCONSTRAINTS ('FK_InvoiceDetails_Eventos_EventoId');
GO

DELETE FROM Eventos
DBCC CHECKIDENT ('TeatroManagementDev.dbo.Eventos', RESEED, 0)
*/

