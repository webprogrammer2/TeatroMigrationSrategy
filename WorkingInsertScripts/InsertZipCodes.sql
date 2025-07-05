USE [TeatroManagementVS]

INSERT INTO [dbo].[ZipCodes]
           ([Zip]
           ,[Latitude]
           ,[Longitude])



SELECT [ZipCode]
      ,[Latitude]
      ,[Longitude]
  FROM Teatro20250629.[dbo].[ZipCodes]

GO
