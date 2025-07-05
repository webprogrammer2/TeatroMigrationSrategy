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

GO