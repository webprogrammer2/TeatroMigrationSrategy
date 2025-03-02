CREATE FUNCTION [dbo].[DistanceFunc]
(
	@Latitude1 decimal(11,6),
	@Longitude1 decimal(11,6),
	@Latitude2 decimal(11,6),
	@Longitude2 decimal(11,6)
)

RETURNS decimal(11, 6)	--returns distance in miles

AS

BEGIN
	--If the 2 locations are the same, return 0 miles
	IF @Latitude1 = @Latitude2 AND @Longitude1 = @Longitude2
		RETURN 0

	--Convert the points from degrees to radians
	SET @Latitude1 = @Latitude1 * PI() / 180
	SET @Longitude1 = @Longitude1 * PI() / 180
	SET @Latitude2 = @Latitude2 * PI() / 180
	SET @Longitude2 = @Longitude2* PI() / 180

	--Temp var
	DECLARE @Distance decimal(18,13)
	SET @Distance = 0.0

	--Compute the distance
	SET @Distance = SIN(@Latitude1) * SIN(@Latitude2) + COS(@Latitude1) *
			COS(@Latitude2) * COS(@Longitude2 - @Longitude1)

	--Are the latitude and longitude points the same? Return 0
	IF @distance = 1	
		RETURN 0

	--Convert to miles (3963 = earth's radius)
	RETURN 3963 * (-1 * ATAN(@Distance / SQRT(1 - @Distance * @Distance)) + PI() / 2)
END
GO
/****** Object:  UserDefinedFunction [dbo].[DistanceFunc2]    Script Date: 7/7/2024 12:51:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[DistanceFunc2] 
(
	@Latitude1 decimal(11,6),
	@Longitude1 decimal(11,6),
	@Latitude2 decimal(11,6),
	@Longitude2 decimal(11,6)
)
RETURNS decimal(11, 6)	--returns distance in miles
AS
BEGIN
	--If the 2 locations are the same, return 0 miles
	IF @Latitude1 = @Latitude2 AND @Longitude1 = @Longitude2
		RETURN 0

	--Convert the points from degrees to radians
	SET @Latitude1 = @Latitude1 * PI() / 180
	SET @Longitude1 = @Longitude1 * PI() / 180
	SET @Latitude2 = @Latitude2 * PI() / 180
	SET @Longitude2 = @Longitude2* PI() / 180

	--Temp var
	DECLARE @Distance decimal(18,13)
	SET @Distance = 0.0

	--Compute the distance
	SET @Distance = SIN(@Latitude1) * SIN(@Latitude2) + COS(@Latitude1) *
			COS(@Latitude2) * COS(@Longitude2 - @Longitude1)

	--Are the latitude and longitude points the same? Return 0
	IF @distance = 1	
		RETURN 0

	--Convert to miles (3963 = earth's radius)
	RETURN 3963 * (-1 * ATAN(@Distance / SQRT(1 - @Distance * @Distance)) + PI() / 2)

END
GO
/****** Object:  UserDefinedFunction [dbo].[RadiusFunc]    Script Date: 7/7/2024 12:51:06 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[RadiusFunc]

(
	@ZipCode nchar(5),
	@Miles decimal(18, 9)
)

RETURNS
	@MaxLongLats TABLE
	(
		Latitude decimal(10,8),
		Longitude decimal(11,8),
		MaxLatitude decimal(10,8),
		MinLatitude decimal(10,8),
		MaxLongitude decimal(11,8),
		MinLongitude decimal(11,8)
	)
AS

BEGIN
	--Declare variables
	DECLARE @Latitude decimal(10,8), @Longitude decimal(11,8)
	DECLARE @MaxLatitude decimal(10, 8), @MinLatitude decimal(10, 8)
	DECLARE @MaxLongitude decimal(11, 8), @MinLongitude decimal(11, 8)

	--Get the Lat/Long of the zipcode
	SELECT @Latitude = Latitude, @Longitude = Longitude
	FROM dbo.ZipCodes
	WHERE Zip = @ZipCode

	--Zipcode not found?
	IF @@ROWCOUNT = 0
		RETURN 

	--Determine the maxes (69.17 is the # of miles/degree)
	SET @MaxLatitude = @Latitude + @Miles / 69.17
	SET @MinLatitude = @Latitude - (@MaxLatitude - @Latitude)
	SET @MaxLongitude = @Longitude + @Miles / (COS(@MinLatitude * PI() / 180) * 69.17)
	SET @MinLongitude = @Longitude - (@MaxLongitude - @Longitude)

	--Insert data into return table
	INSERT INTO @MaxLongLats
		(Latitude, Longitude, MaxLatitude, MinLatitude, MaxLongitude, MinLongitude)
	SELECT @Latitude, @Longitude, @MaxLatitude, @MinLatitude, @MaxLongitude, @MinLongitude
	RETURN
END
GO