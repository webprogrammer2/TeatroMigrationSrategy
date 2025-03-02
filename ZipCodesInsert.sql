USE [TeatroManagementDb2]

INSERT INTO [dbo].[ZipCodes]
           ([Zip]
           ,[Latitude]
           ,[Longitude])



SELECT [ZipCode]
      ,[Latitude]
      ,[Longitude]
  FROM TeatroDB.[dbo].[ZipCodes]

GO


