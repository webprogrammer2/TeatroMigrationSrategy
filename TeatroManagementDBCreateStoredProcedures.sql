-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetCheckin]
	-- Add the parameters for the stored procedure here
	@InvoiceId Int,
	@City NvarChar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
		i.Id AS InvoiceId,
		tu.Id AS TourId,
		tu.[Description] AS TourDesc,
		e.Code AS EventCode,
		e.Id AS EventId,
		t.Name AS TheaterName,
		t.Address1 AS TheaterAddress1,
		t.Address2 AS TheaterAddress2,
		t.City AS TheaterCity,
		t.[State] AS TheaterState,
		t.Zip AS TheaterPostalcode,
		e.EventoDate AS EventTime,
		s.[Name] AS ShowName,
		s.Duration AS ShowDuration,
		c.Id AS TeacherId,
		c.Organization AS School,
		c.Prefix AS TeacherPrefix,
		c.FirstName AS FirstName,
		c.LastName AS LastName,
		d.StudentsQty AS Students,
		d.StudentsPrice AS StudentPrice,
		d.TeachersQty AS Teachers,
		d.TeachersPrice AS TeacherPrice,
		i.TotalAmount AS InvoiceTotal,
		i.TotalPayments AS Payments
		FROM InvoiceDetails d
		INNER JOIN Invoices i ON (d.InvoiceId = i.Id)
		INNER JOIN Tours tu ON (i.TourId = tu.Id)
		INNER JOIN Customers c ON (i.CustomerId = c.Id)
		INNER JOIN Eventos e ON (d.EventoId = e.Id)
		INNER JOIN Shows s ON (e.ShowId = s.Id)
		INNER JOIN Theaters t ON (e.TheaterId = t.Id)
		WHERE 1=1
		and t.City = @City
		and i.Id = @InvoiceId
END
GO
/****** Object:  StoredProcedure [dbo].[GetCheckinEventCities]    Script Date: 7/7/2024 12:51:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetCheckinEventCities]
	-- Add the parameters for the stored procedure here
	@TourId Int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
		e.City AS City,
		t.[Name] as TheaterName,
		t.Address1 AS TheaterAddress1,
		t.Address2 AS TheaterAddress2,
		t.City AS TheaterCity,
		t.[State] AS TheaterState,
		t.Zip AS TheaterPostalCode,
		CAST(e.EventoDate AS Date) AS EventDate
		FROM Eventos e
		INNER JOIN Theaters t ON (e.TheaterId = t.Id)
		WHERE e.TourId = @TourId
		GROUP BY e.City, t.[Name], t.Address1, t.Address2, t.City, t.[State], t.Zip, CAST(e.EventoDate AS Date)
		ORDER BY CAST(e.EventoDate AS Date)
END
GO
/****** Object:  StoredProcedure [dbo].[GetCheckinInvoicesByTour]    Script Date: 7/7/2024 12:51:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetCheckinInvoicesByTour]
	-- Add the parameters for the stored procedure here
	@TourId Int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
		i.Id AS InvoiceId,
		i.CreatedDate AS InvoiceDate,
		e.City AS City,
		t.[Description] AS TourDesc,
		t.Id AS TourId,
		v.[Name] AS TheaterName, 
		v.Address1 AS TheaterAddress1,
		v.Address2 AS TheaterAddress2,
		v.City AS TheaterCity,
		v.[State] AS TheaterState,
		v.Zip AS TheaterPostalCode,
		c.Id AS TeacherId,
		c.Organization AS School,
		c.Prefix AS TeacherPrefix,
		c.FirstName AS FirstName,
		c.LastName AS LastName,
		i.TotalAmount AS InvoiceTotal,
		i.TotalPayments AS Payments

		FROM Invoices i
		INNER JOIN InvoiceDetails d ON (i.Id = d.InvoiceId)
		INNER JOIN Tours t ON (i.TourId = t.Id)
		INNER JOIN Customers c ON (i.CustomerId = c.Id)
		INNER JOIN Eventos e ON (d.EventoId = e.Id)
		INNER JOIN Theaters v ON (e.TheaterId = v.Id)
		WHERE i.Voided = 0 
		AND t.Id = @TourId
		ORDER BY c.Organization
END
GO
/****** Object:  StoredProcedure [dbo].[GetEventosByTour]    Script Date: 7/7/2024 12:51:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetEventosByTour] 
	-- Add the parameters for the stored procedure here
	@TourId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select 
		e.[Id], 
		e.Code, 
		e.EventoDate, 
		IsNull(e.city, '') as EventoCity, 
		IsNUll(e.state, '') as [EventoState], 
		e.[ShowId], 
		s.[Name] as ShowName, 
		e.[TheaterId], 
		t.[Name] as TheaterName, 
		t.City as TheaterCity, 
		IsNull(t.Capacity,0) as Capacity, 
		IsNull((select (sum(d.TeachersQty)+ sum(d.StudentsQty)) from InvoiceDetails d inner join Invoices i  on (d.InvoiceId = i.[Id]) where d.EventoId = e.[Id] and i.Voided = 0),0) as Sold, 
		--(t.capacity - IsNull((select (sum(i.TeachersQty)+ sum(i.StudentsQty)) from InvoiceDetails i inner join invoices inv  on (inv.[id] = i.InvoiceId) where i.EventoId = e.[id] and inv.Voided = 0),0)) as Available, 
		IsNull(e.comments, '') as Comments 
		from 
		Eventos e 
		left outer join Shows s on (e.ShowId=s.[Id]) 
		left outer join Theaters t on (e.TheaterId=t.[Id]) 
		where e.TourId = @TourId 
		order by e.Code
END
GO
/****** Object:  StoredProcedure [dbo].[GetEventoVmById]    Script Date: 7/7/2024 12:51:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetEventoVmById] 
	-- Add the parameters for the stored procedure here
	@EventoId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select 
		e.[Id], 
		e.Code, 
		e.EventoDate, 
		IsNull(e.city, '') as EventoCity, 
		IsNUll(e.state, '') as [EventoState], 
		e.[ShowId], 
		s.[Name] as ShowName, 
		e.[TheaterId], 
		t.[Name] as TheaterName, 
		t.City as TheaterCity, 
		IsNull(t.Capacity,0) as Capacity, 
		IsNull((select (sum(i.TeachersQty)+ sum(i.StudentsQty)) from InvoiceDetails i inner join Invoices inv  on (inv.[Id] = i.[Id]) where i.EventoId = e.[Id] and inv.Voided = 0),0) as Sold, 
		(t.capacity - IsNull((select (sum(i.TeachersQty)+ sum(i.StudentsQty)) from InvoiceDetails i inner join invoices inv  on (inv.[id] = i.InvoiceId) where i.EventoId = e.[id] and inv.Voided = 0),0)) as Available, 
		IsNull(e.comments, '') as Comments 
		from 
		Eventos e 
		left outer join Shows s on (e.ShowId=s.[Id]) 
		left outer join Theaters t on (e.TheaterId=t.[Id]) 
		where e.Id = @EventoId 

END
GO
/****** Object:  StoredProcedure [dbo].[GetInvoiceHeaderById]    Script Date: 7/7/2024 12:51:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetInvoiceHeaderById] 
	-- Add the parameters for the stored procedure here
	@InvoiceId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

--IF object_id('tempdb..#TMP_CUST_SEARCH') IS NOT NULL
--BEGIN 
--    DROP TABLE #TMP_CUST_SEARCH
--END


   SELECT
    i.[id],
	i.CustomerId,
	IsNull(i.Prefix, '') as Prefix,
    IsNull(i.FirstName, '') as FirstName,
	IsNull(i.MiddleName, '') as MiddleName,
    IsNull(i.LastName, '') as LastName,
	IsNull(i.Suffix, '') as Suffix,
	IsNull(i.Title, '') as Title,
	IsNull(i.Email, '') as Email,
	IsNull(i.Phone, '') as Phone,
	IsNull(i.Organization, '') as Organization,
	IsNull(i.Address1, '') as Address1,
	IsNull(i.Address2, '') as Address2,
    IsNull(i.City, '') as City,
	IsNull(i.[State], '') as [State],
    IsNull(i.Zip, '') as Zip,
	IsNull(t.Season, '') as Season,
	IsNull(t.TourYear, 0) as TourYear,
	IsNull(i.Voided, 0) as Voided,
	i.VoidedDate,
	i.VoidedComments,
	i.Confirmed,
	i.Comments,
	i.CreatedDate,
    IsNull(i.LastModifiedDate, i.CreatedDate) as LastModifiedDate,
	SUM(d.SubTotal) as TotalAmount,
	IsNull((select sum(IsNull(amount,0)) from Payments where InvoiceId = i.[Id]),0) as [TotalPayments],
	(select count(Id) from EmailLogs where InvoiceId = i.[id] and Emailtype = 'invoice') as EmailInvoiceCount,
	(select count(Id) from EmailLogs where InvoiceId = i.[id] and Emailtype = 'ticket') as EmailTicketCount
    FROM 
    Invoices i
	inner join InvoiceDetails d on (i.Id = d.InvoiceId)
	inner join Eventos e on (d.EventoId = e.Id)
	inner join Tours t on (e.TourId = t.Id)
	WHERE
		i.Id = @InvoiceId
	GROUP BY 
	i.[id],
	i.CustomerId,
	i.Prefix,
    i.FirstName,
	i.MiddleName,
    i.LastName,
	i.Suffix,
	i.Title,
	i.Email,
	i.Phone,
	i.Organization,
	i.Address1,
	i.Address2,
    i.City,
	i.[State],
	i.Zip,
	t.[Season],
	t.[TourYear],
	i.Voided,
	i.VoidedDate,
	i.VoidedComments,
	i.Confirmed,
	i.Comments,
	i.CreatedDate,
    i.LastModifiedDate
ORDER BY 
	i.LastName,
	i.FirstName

	
END
GO
/****** Object:  StoredProcedure [dbo].[GetInvoicesByCustomer]    Script Date: 7/7/2024 12:51:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetInvoicesByCustomer] 
	-- Add the parameters for the stored procedure here
		@CustomerId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

--IF object_id('tempdb..#TMP_CUST_SEARCH') IS NOT NULL
--BEGIN 
--    DROP TABLE #TMP_CUST_SEARCH
--END


  SELECT
    i.[id],
    i.CreatedDate,
    IsNull(i.LastModifiedDate, i.CreatedDate) as LastModifiedDate,
	i.CustomerId,
    IsNull(i.FirstName, '') as FirstName,
    IsNull(i.LastName, '') as LastName,
	IsNull(i.Organization, '') as Organization,
    IsNull(c.City, '') as City,
    IsNull(c.Zip, '') as Zip,
	IsNull(t.TourYear, 0) as TourYear,
	IsNull(t.Season, '') as Season,
	--SUM(d.SubTotal) as Total,
	IsNull((select SUM(SubTotal) from InvoiceDetails where InvoiceId = i.[id]), 0.00) as Total,
	IsNull(SUM(p.Amount), 0) as [Payments]
	--(SUM(d.SubTotal) - IsNull(SUM(p.Amount), 0)) as [Balance],
	--(select count(Id) from EmailLogs where InvoiceId = i.[id] and Emailtype = 'invoice') as EmailInvoiceCount,
	--(select count(Id) from EmailLogs where InvoiceId = i.[id] and Emailtype = 'ticket') as EmailTicketCount
    FROM 
    Invoices i
    inner join Customers c on (i.CustomerId = c.Id)
	--inner join InvoiceDetails d on (i.Id = d.InvoiceId)
	--inner join Eventos e on (d.EventoId = e.Id)
	inner join Tours t on (i.TourId = t.id)
	left outer join Payments p on (i.Id = p.InvoiceId)
	WHERE
		i.CustomerId = @CustomerId
	GROUP BY 
	i.[id],
    i.CreatedDate,
	i.CustomerId,
    i.LastModifiedDate,
    i.FirstName,
    i.LastName,
	i.Organization,
	t.TourYear,
	t.Season,
    c.City, 
	c.Zip 
ORDER BY 
	i.Id DESC,
	i.LastName,
	i.FirstName

	
END
GO
/****** Object:  StoredProcedure [dbo].[GetInvoicesByTour]    Script Date: 7/7/2024 12:51:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetInvoicesByTour] 
	-- Add the parameters for the stored procedure here
		@TourId int,
		@Voided bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

--IF object_id('tempdb..#TMP_CUST_SEARCH') IS NOT NULL
--BEGIN 
--    DROP TABLE #TMP_CUST_SEARCH
--END


      SELECT
    i.[id],
    i.CreatedDate,
    IsNull(i.LastModifiedDate, i.CreatedDate) as LastModifiedDate,
	i.CustomerId,
    IsNull(i.FirstName, '') as FirstName,
    IsNull(i.LastName, '') as LastName,
	IsNull(i.Organization, '') as Organization,
    IsNull(c.City, '') as City,
    IsNull(c.Zip, '') as Zip,
	IsNull(t.TourYear, 0) as TourYear,
	IsNull(t.Season, '') as Season,
	--SUM(d.SubTotal) as Total,
	IsNull((select SUM(SubTotal) from InvoiceDetails where InvoiceId = i.[id]),0.00) as Total,
	IsNull(SUM(p.Amount), 0) as [Payments]
	--(SUM(d.SubTotal) - IsNull(SUM(p.Amount), 0)) as [Balance],
	--(select count(Id) from EmailLogs where InvoiceId = i.[id] and Emailtype = 'invoice') as EmailInvoiceCount,
	--(select count(Id) from EmailLogs where InvoiceId = i.[id] and Emailtype = 'ticket') as EmailTicketCount
    FROM 
    Invoices i
    inner join Customers c on (i.CustomerId = c.Id)
	--inner join InvoiceDetails d on (i.Id = d.InvoiceId)
	--inner join Eventos e on (d.EventoId = e.Id)
	inner join Tours t on (i.TourId = t.id)
	left outer join Payments p on (i.Id = p.InvoiceId)
	WHERE IsNull(i.Voided, 0) = @Voided
	AND	i.TourId = @TourId
	GROUP BY 
	i.[id],
    i.CreatedDate,
	i.CustomerId,
    i.LastModifiedDate,
    i.FirstName,
    i.LastName,
	i.Organization,
    c.City, 
	c.Zip,
	t.TourYear,
	t.Season
ORDER BY 
	i.Id DESC,
	i.LastName,
	i.FirstName
	
END
GO
/****** Object:  StoredProcedure [dbo].[GetInvoicesForCheckin]    Script Date: 7/7/2024 12:51:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Alberto Ruiz
-- Create date: 2024-06-29
-- Description:	Get checkin invoices by Tour and City
-- =============================================
CREATE PROCEDURE [dbo].[GetInvoicesForCheckin]
	-- Add the parameters for the stored procedure here
	@TourId Int,
	@City NVarChar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
		i.Id AS InvoiceId,
		t.[Description] AS TourDesc,
		e.City,
		Cast(e.EventoDate AS Date) AS [Date],
		i.FirstName AS FirstName,
		i.LastName AS LastName,
		i.Organization AS Organization,
		i.Address1 as Address1,
		i.Address2 AS Address2,
		i.City AS InvoiceCity,
		i.[State] AS [State],
		i.Zip AS Zip,
		SUM(d.StudentsQty) AS Students,
		SUM(d.TeachersQty) as Teachers,
		SUM(ISNULL(d.StudentsQty, 0.00)) * SUM(ISNULL(d.StudentsPrice, 0.00)) AS Total
		FROM InvoiceDetails d
		INNER JOIN Invoices i ON (d.InvoiceId = i.Id)
		INNER JOIN Tours t ON (i.TourId = t.Id)
		INNER JOIN Customers c ON (i.CustomerId = c.Id)
		INNER JOIN Eventos e ON (d.EventoId = e.Id)

		WHERE 1=1
		and i.TourId = @TourId
		and e.City = @City
		GROUP BY i.Id,
		t.[Description],
		e.City,
		Cast(e.EventoDate AS Date),
		i.FirstName,
		i.LastName,
		i.Organization,
		i.Address1,
		i.Address2,
		i.City,
		i.[State],
		i.Zip
		order by i.Organization
END
GO
/****** Object:  StoredProcedure [dbo].[SalesByTour]    Script Date: 7/7/2024 12:51:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SalesByTour] 
	-- Add the parameters for the stored procedure here
	@TourId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT i.[id]
		,CONVERT(VARCHAR(8), i.CreatedDate, 1) as invDate
		,i.[CustomerId]
		,c.FirstName
		,c.LastName
		,c.Organization
		,i.TotalAmount
		,i.TotalPayments

		,IsNull((select SUM(d.StudentsQty) from InvoiceDetails d where d.InvoiceId = i.[id]), 0) as students
		,IsNull((select SUM(d.TeachersQty) from InvoiceDetails d where d.InvoiceId = i.[id]), 0) as teachers

		,IsNull((select SUM(p.amount) from Payments p where p.InvoiceId = i.[id]), 0) as payments
		,IsNull((i.[TotalAmount] - [TotalPayments]), 0) as balance
		FROM [invoices] i
		INNER JOIN [Customers] c on (i.CustomerId = c.Id)
		where i.Voided = 0
		and i.TourId = @TourId
END
GO
/****** Object:  StoredProcedure [dbo].[SearchCustomers]    Script Date: 7/7/2024 12:51:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SearchCustomers]
	-- Add the parameters for the stored procedure here
	@FirstName varchar(50),
	@LastName varchar(50),
	@Organization varchar(50),
	@Zip varchar(50),
	@CourseSpanish BIT,
	@CourseFrench BIT,
	@CourseEnglish BIT,
	@CourseSocialStudies BIT,
	@CourseArts BIT,
	@CourseAdmin BIT,
	@CourseOther BIT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--DECLARE @IntVariable int;  

	DECLARE @SQLStringSelect nvarchar(MAX);
	DECLARE @SQLStringSpanish nvarchar(50);
	DECLARE @SQLStringFrench nvarchar(50);
	DECLARE @SQLStringEnglish nvarchar(50);
	DECLARE @SQLStringSocialStudies nvarchar(50);
	DECLARE @SQLStringArts nvarchar(50);
	DECLARE @SQLStringSAdmin nvarchar(50);
	DECLARE @SQLStringSOther nvarchar(50);

/* Build the SQL string one time.*/  
SET @SQLStringSelect =  
     N'SELECT 
	   [id]
      ,UPPER([Organization]) AS Organization
      ,UPPER(IsNull([Address1], '''')) + '' '' + UPPER(IsNull([Address2], '''')) as [Address]
      ,UPPER([City]) AS City
      ,UPPER([State]) AS [State]
      ,UPPER([Zip]) AS Zip
      ,UPPER([FirstName]) AS FirstName
      ,UPPER([LastName]) AS LastName
      ,UPPER([Phone]) AS Phone
      ,LOWER([Email]) AS Email 
	  ,0.00 AS Miles
      ,IsNull([CourseSpanish], 0) as CourseSpanish
      ,IsNull([CourseFrench], 0) as CourseFrench
      ,IsNull([CourseEnglish], 0) as CourseEnglish
      ,IsNull([CourseSocialStudies], 0) as CourseSocialStudies
      ,IsNull([CourseArts], 0) as CourseArts
      ,IsNull([CourseAdmin], 0) as CourseAdmin
      ,IsNull([CourseOther], 0) as CourseOther

    FROM Customers 
	WHERE LastName like ''%' + @LastName + '%''
	AND FirstName like ''%' + @FirstName + '%''
	AND Organization like ''%' + @Organization + '%''
	AND Zip like ''%' + @Zip + '%''
	'; 


	IF @CourseSpanish = 1
	BEGIN
	SET @SQLStringSpanish = 'AND CourseSpanish = 1 '
	SET @SQLStringSelect = @SQLStringSelect + @SQLStringSpanish
	END

	IF @CourseFrench = 1
	BEGIN
	SET @SQLStringFrench = 'AND CourseFrench = 1 '
	SET @SQLStringSelect = @SQLStringSelect + @SQLStringFrench
	END

	IF @CourseEnglish = 1
	BEGIN
	SET @SQLStringEnglish = 'AND CourseEnglish = 1 '
	SET @SQLStringSelect = @SQLStringSelect + @SQLStringEnglish
	END

	IF @CourseSocialStudies = 1
	BEGIN
	SET @SQLStringSocialStudies = 'AND CourseSocialStudies = 1 '
	SET @SQLStringSelect = @SQLStringSelect + @SQLStringSocialStudies
	END

	IF @CourseArts = 1
	BEGIN
	SET @SQLStringArts = 'AND CourseArts = 1 '
	SET @SQLStringSelect = @SQLStringSelect + @SQLStringArts
	END

	IF @CourseAdmin = 1
	BEGIN
	SET @SQLStringSAdmin = 'AND CourseAdmin = 1 '
	SET @SQLStringSelect = @SQLStringSelect + @SQLStringSAdmin
	END

	IF @CourseOther = 1
	BEGIN
	SET @SQLStringSOther = 'AND CourseOther = 1 '
	SET @SQLStringSelect = @SQLStringSelect + @SQLStringSOther
	END


	--print @SQLStringSelect
	--exec(@SQLString)
	--EXEC sp_executesql SQLString
EXECUTE sp_executesql @SQLStringSelect;

END
GO
/****** Object:  StoredProcedure [dbo].[SearchCustomersByDistance]    Script Date: 7/7/2024 12:51:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SearchCustomersByDistance] 
	@Zip NvarChar(50), 
	@Miles int, 
	@LastName varchar(50),
	@CourseSpanish BIT,
	@CourseFrench BIT,
	@CourseEnglish BIT,
	@CourseSocialStudies BIT,
	@CourseArts BIT,
	@CourseAdmin BIT,
	@CourseOther BIT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--DECLARE @IntVariable int;  

	DECLARE @SQLStringSelect nvarchar(MAX);

	DECLARE @SQLStringSpanish nvarchar(50);
	DECLARE @SQLStringFrench nvarchar(50);
	DECLARE @SQLStringEnglish nvarchar(50);
	DECLARE @SQLStringSocialStudies nvarchar(50);
	DECLARE @SQLStringArts nvarchar(50);
	DECLARE @SQLStringSAdmin nvarchar(50);
	DECLARE @SQLStringSOther nvarchar(50);

/* Build the SQL string one time.*/  
SET @SQLStringSelect =  
     N'SELECT ZIP.Zip, 
    [dbo].[DistanceFunc](ZIP.Latitude, ZIP.Longitude, RAD.Latitude, RAD.Longitude) As Distance 
    INTO #TempZips 
    FROM ZipCodes ZIP, RadiusFunc(''' + @Zip + ''', ' + Convert(NVarChar(10), @Miles) + ') RAD 
    WHERE (ZIP.Latitude BETWEEN RAD.MinLatitude AND RAD.MaxLatitude) AND 
    (ZIP.Longitude BETWEEN RAD.MinLongitude AND RAD.MaxLongitude) AND 
    (dbo.DistanceFunc(ZIP.Latitude,ZIP.Longitude,RAD.Latitude,RAD.Longitude) <= ' + Convert(NVarChar(10), @Miles) + ' ) 

    SELECT 
	   T.[id]
      ,UPPER(T.[Organization]) AS Organization
      ,UPPER(IsNull(T.[Address1], '''')) + '' '' + UPPER(IsNull(T.[Address2], '''')) as [Address]
      ,UPPER(T.[City]) AS City
      ,UPPER(T.[State]) AS [State]
      ,UPPER(T.[Zip]) AS Zip
      ,UPPER(T.[FirstName]) AS FirstName
      ,UPPER(T.[LastName]) AS LastName
      ,UPPER(T.[Phone]) AS Phone
      ,LOWER(T.[Email]) AS Email 
      ,IsNull(T.[CourseSpanish], 0) as CourseSpanish
      ,IsNull(T.[CourseFrench], 0) as CourseFrench
      ,IsNull(T.[CourseEnglish], 0) as CourseEnglish
      ,IsNull(T.[CourseSocialStudies], 0) as CourseSocialStudies
      ,IsNull(T.[CourseArts], 0) as CourseArts
      ,IsNull(T.[CourseAdmin], 0) as CourseAdmin
      ,IsNull(T.[CourseOther], 0) as CourseOther
	  , Convert(decimal(10,2),round(IsNull(Zips.Distance, 0),2)) AS miles 
    FROM Customers T INNER JOIN 
    #TempZips Zips ON Zips.Zip = T.zip  

    WHERE T.LastName like ''%' + @LastName + '%'' 

	'; 


	IF @CourseSpanish = 1
	BEGIN
	SET @SQLStringSpanish = 'AND CourseSpanish = 1 '
	SET @SQLStringSelect = @SQLStringSelect + @SQLStringSpanish
	END

	IF @CourseFrench = 1
	BEGIN
	SET @SQLStringFrench = 'AND CourseFrench = 1 '
	SET @SQLStringSelect = @SQLStringSelect + @SQLStringFrench
	END

	IF @CourseEnglish = 1
	BEGIN
	SET @SQLStringEnglish = 'AND CourseEnglish = 1 '
	SET @SQLStringSelect = @SQLStringSelect + @SQLStringEnglish
	END

	IF @CourseSocialStudies = 1
	BEGIN
	SET @SQLStringSocialStudies = 'AND CourseSocialStudies = 1 '
	SET @SQLStringSelect = @SQLStringSelect + @SQLStringSocialStudies
	END

	IF @CourseArts = 1
	BEGIN
	SET @SQLStringArts = 'AND CourseArts = 1 '
	SET @SQLStringSelect = @SQLStringSelect + @SQLStringArts
	END

	IF @CourseAdmin = 1
	BEGIN
	SET @SQLStringSAdmin = 'AND CourseAdmin = 1 '
	SET @SQLStringSelect = @SQLStringSelect + @SQLStringSAdmin
	END

	IF @CourseOther = 1
	BEGIN
	SET @SQLStringSOther = 'AND CourseOther = 1 '
	SET @SQLStringSelect = @SQLStringSelect + @SQLStringSOther
	END


	--print @SQLStringSelect

	EXECUTE sp_executesql @SQLStringSelect;

END
GO
/****** Object:  StoredProcedure [dbo].[SearchInvoices]    Script Date: 7/7/2024 12:51:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SearchInvoices] 
	-- Add the parameters for the stored procedure here
	@Id int = NULL,
	@FirstName varchar(50) = NULL,
	@LastName varchar(50) = NULL, 
	@City varchar(50) = NULL,
	@Zip varchar(50) = NULL,
	@DateFrom DateTime = NULL,
	@DateTo DateTime = NULL,
	@Voided Bit = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

--IF object_id('tempdb..#TMP_CUST_SEARCH') IS NOT NULL
--BEGIN 
--    DROP TABLE #TMP_CUST_SEARCH
--END


   SELECT
    i.[id],
    i.CreatedDate,
    i.LastModifiedDate,
	i.CustomerId,
    i.FirstName,
    i.LastName,
	i.Organization,
    IsNull(c.City, '') as City,
    IsNull(c.Zip, '') as Zip,
	--SUM(d.SubTotal) as Total,
	IsNull((select SUM(SubTotal) from InvoiceDetails where InvoiceId = i.[id]), 0.00) as Total,
	IsNull(SUM(p.Amount), 0) as [Payments]
	--(SUM(d.SubTotal) - IsNull(SUM(p.Amount), 0)) as [Balance]
	--(select count(Id) from EmailLogs where InvoiceId = i.[id] and Emailtype = 'invoice') as EmailInvoiceCount,
	--(select count(Id) from EmailLogs where InvoiceId = i.[id] and Emailtype = 'ticket') as EmailTicketCount
    FROM 
    Invoices i
    inner join Customers c on (i.CustomerId = c.Id)
	--inner join InvoiceDetails d on (i.Id = d.InvoiceId)
	--inner join Eventos e on (d.EventoId = e.Id)
	left outer join Payments p on (i.Id = p.InvoiceId)
	WHERE
		((@Id IS NULL) OR (i.[Id] = @Id)) AND
		((@FirstName IS NULL) OR (c.FirstName like '%' + @FirstName + '%')) AND 
		((@LastName IS NULL) OR (c.LastName like '%' + @LastName + '%')) AND 
		((@City IS NULL) OR (c.City = @City)) AND
		((@Zip IS NULL) OR (c.zip = @Zip)) AND
		((@DateFrom IS NULL AND @DateTo IS NULL) OR (i.CreatedDate Between @DateFrom and @DateTo)) AND
		((@Voided IS NULL) OR (i.Voided = @Voided))
	GROUP BY 
	i.[id],
    i.CreatedDate,
    i.LastModifiedDate,
	i.CustomerId,
    i.FirstName,
    i.LastName,
	i.Organization,
    c.City, 
	c.Zip 
ORDER BY 
	i.LastName,
	i.FirstName

	
END
GO
/****** Object:  StoredProcedure [dbo].[SuperSearch]    Script Date: 7/7/2024 12:51:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SuperSearch] 
	@Zip NvarChar(50), 
	@Miles int, 
	@LastName varchar(50),
	@CourseSpanish BIT,
	@CourseFrench BIT,
	@CourseEnglish BIT,
	@CourseSocialStudies BIT,
	@CourseArts BIT,
	@CourseAdmin BIT,
	@CourseOther BIT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--DECLARE @IntVariable int;  

	DECLARE @SQLStringSelect nvarchar(MAX);

	DECLARE @SQLStringSpanish nvarchar(50);
	DECLARE @SQLStringFrench nvarchar(50);
	DECLARE @SQLStringEnglish nvarchar(50);
	DECLARE @SQLStringSocialStudies nvarchar(50);
	DECLARE @SQLStringArts nvarchar(50);
	DECLARE @SQLStringSAdmin nvarchar(50);
	DECLARE @SQLStringSOther nvarchar(50);

/* Build the SQL string one time.*/  
SET @SQLStringSelect =  
     N'SELECT ZIP.Zip, 
    [dbo].[DistanceFunc](ZIP.Latitude, ZIP.Longitude, RAD.Latitude, RAD.Longitude) As Distance 
    INTO #TempZips 
    FROM ZipCodes ZIP, RadiusFunc(''' + @Zip + ''', ' + Convert(NVarChar(10), @Miles) + ') RAD 
    WHERE (ZIP.Latitude BETWEEN RAD.MinLatitude AND RAD.MaxLatitude) AND 
    (ZIP.Longitude BETWEEN RAD.MinLongitude AND RAD.MaxLongitude) AND 
    (dbo.DistanceFunc(ZIP.Latitude,ZIP.Longitude,RAD.Latitude,RAD.Longitude) <= ' + Convert(NVarChar(10), @Miles) + ' ) 

    SELECT 
	   T.[id]
      ,UPPER(T.[Organization]) AS Organization
      ,UPPER(IsNull(T.[Address1], '''')) + '' '' + UPPER(IsNull(T.[Address2], '''')) as [Address]
      ,UPPER(T.[City]) AS City
      ,UPPER(T.[State]) AS [State]
      ,UPPER(T.[Zip]) AS Zip
      ,UPPER(T.[FirstName]) AS FirstName
      ,UPPER(T.[LastName]) AS LastName
      ,UPPER(T.[Phone]) AS Phone
      ,LOWER(T.[Email]) AS Email 
      ,IsNull(T.[CourseSpanish], 0) as CourseSpanish
      ,IsNull(T.[CourseFrench], 0) as CourseFrench
      ,IsNull(T.[CourseEnglish], 0) as CourseEnglish
      ,IsNull(T.[CourseSocialStudies], 0) as CourseSocialStudies
      ,IsNull(T.[CourseArts], 0) as CourseArts
      ,IsNull(T.[CourseAdmin], 0) as CourseAdmin
      ,IsNull(T.[CourseOther], 0) as CourseOther
	  , Convert(decimal(10,2),round(IsNull(Zips.Distance, 0),2)) AS miles 
    FROM Customers T INNER JOIN 
    #TempZips Zips ON Zips.Zip = T.zip  

    WHERE T.LastName like ''%' + @LastName + '%'' 

	'; 


	IF @CourseSpanish = 1
	BEGIN
	SET @SQLStringSpanish = 'AND CourseSpanish = 1 '
	SET @SQLStringSelect = @SQLStringSelect + @SQLStringSpanish
	END

	IF @CourseFrench = 1
	BEGIN
	SET @SQLStringFrench = 'AND CourseFrench = 1 '
	SET @SQLStringSelect = @SQLStringSelect + @SQLStringFrench
	END

	IF @CourseEnglish = 1
	BEGIN
	SET @SQLStringEnglish = 'AND CourseEnglish = 1 '
	SET @SQLStringSelect = @SQLStringSelect + @SQLStringEnglish
	END

	IF @CourseSocialStudies = 1
	BEGIN
	SET @SQLStringSocialStudies = 'AND CourseSocialStudies = 1 '
	SET @SQLStringSelect = @SQLStringSelect + @SQLStringSocialStudies
	END

	IF @CourseArts = 1
	BEGIN
	SET @SQLStringArts = 'AND CourseArts = 1 '
	SET @SQLStringSelect = @SQLStringSelect + @SQLStringArts
	END

	IF @CourseAdmin = 1
	BEGIN
	SET @SQLStringSAdmin = 'AND CourseAdmin = 1 '
	SET @SQLStringSelect = @SQLStringSelect + @SQLStringSAdmin
	END

	IF @CourseOther = 1
	BEGIN
	SET @SQLStringSOther = 'AND CourseOther = 1 '
	SET @SQLStringSelect = @SQLStringSelect + @SQLStringSOther
	END


	print @SQLStringSelect

	EXECUTE sp_executesql @SQLStringSelect;

END
GO