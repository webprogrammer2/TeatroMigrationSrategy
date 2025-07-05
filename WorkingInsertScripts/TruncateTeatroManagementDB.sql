USE TeatroManagementVS

-- STEP 1: Drop Foreign Key Constraints
--ALTER TABLE [dbo].[EventoCheckin] DROP CONSTRAINT [FK_EventoCheckin_InvoiceDetails];
ALTER TABLE [dbo].[Checkins] DROP CONSTRAINT [FK_Checkins_Invoices_InvoiceId];
ALTER TABLE [dbo].[EmailLogs] DROP CONSTRAINT [PK_EmailLogs]; -- No FK, just primary key for completeness
ALTER TABLE [dbo].[InvoiceDetails] DROP CONSTRAINT [FK_InvoiceDetails_Eventos_EventoId];
ALTER TABLE [dbo].[InvoiceDetails] DROP CONSTRAINT [FK_InvoiceDetails_Invoices_InvoiceId];
ALTER TABLE [dbo].[Payments] DROP CONSTRAINT [FK_Payments_Invoices_InvoiceId];
ALTER TABLE [dbo].[Invoices] DROP CONSTRAINT [FK_Invoices_Customers_CustomerId];
ALTER TABLE [dbo].[Invoices] DROP CONSTRAINT [FK_Invoices_Tours];
/*
ALTER TABLE [dbo].[AspNetUserTokens] DROP CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId];
ALTER TABLE [dbo].[AspNetUserRoles] DROP CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId];
ALTER TABLE [dbo].[AspNetUserRoles] DROP CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId];
ALTER TABLE [dbo].[AspNetUserLogins] DROP CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId];
ALTER TABLE [dbo].[AspNetUserClaims] DROP CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId];
ALTER TABLE [dbo].[AspNetRoleClaims] DROP CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId];
*/
ALTER TABLE [dbo].[Eventos] DROP CONSTRAINT [FK_Eventos_Shows_ShowId];
ALTER TABLE [dbo].[Eventos] DROP CONSTRAINT [FK_Eventos_Theaters_TheaterId];
ALTER TABLE [dbo].[Eventos] DROP CONSTRAINT [FK_Eventos_Tours_TourId];

ALTER TABLE [dbo].[TheaterImages] DROP CONSTRAINT [FK_TheaterImages_Theaters_TheaterId];
ALTER TABLE [dbo].[Tours] DROP CONSTRAINT [FK_Tours_Companies_CompanyId];

-- STEP 2: Truncate All Tables
--TRUNCATE TABLE [dbo].[EventoCheckin];
TRUNCATE TABLE [dbo].[Checkins];
TRUNCATE TABLE [dbo].[EmailLogs];
TRUNCATE TABLE [dbo].[InvoiceDetails];
TRUNCATE TABLE [dbo].[Payments];
TRUNCATE TABLE [dbo].[Invoices];
/*
	TRUNCATE TABLE [dbo].[AspNetUserTokens];
	TRUNCATE TABLE [dbo].[AspNetUserRoles];
	TRUNCATE TABLE [dbo].[AspNetUserLogins];
	TRUNCATE TABLE [dbo].[AspNetUserClaims];
	TRUNCATE TABLE [dbo].[AspNetRoleClaims];
*/
TRUNCATE TABLE [dbo].[Eventos];
TRUNCATE TABLE [dbo].[Shows];
TRUNCATE TABLE [dbo].[TheaterImages];
TRUNCATE TABLE [dbo].[Theaters];
TRUNCATE TABLE [dbo].[Tours];
TRUNCATE TABLE [dbo].[Companies];
TRUNCATE TABLE [dbo].[Customers];
/*
	TRUNCATE TABLE [dbo].[AspNetUsers];
	TRUNCATE TABLE [dbo].[AspNetRoles];
*/
TRUNCATE TABLE [dbo].[AppDefaults];
TRUNCATE TABLE [dbo].[ZipCodes];
--TRUNCATE TABLE [dbo].[__EFMigrationsHistory];

-- STEP 3: Re-Add Constraints

ALTER TABLE [dbo].[Checkins] ADD CONSTRAINT [FK_Checkins_Invoices_InvoiceId]
    FOREIGN KEY ([InvoiceId]) REFERENCES [dbo].[Invoices]([Id]) ON DELETE CASCADE;

ALTER TABLE [dbo].[InvoiceDetails] ADD CONSTRAINT [FK_InvoiceDetails_Eventos_EventoId]
    FOREIGN KEY ([EventoId]) REFERENCES [dbo].[Eventos]([Id]) ON DELETE CASCADE;

ALTER TABLE [dbo].[InvoiceDetails] ADD CONSTRAINT [FK_InvoiceDetails_Invoices_InvoiceId]
    FOREIGN KEY ([InvoiceId]) REFERENCES [dbo].[Invoices]([Id]) ON DELETE CASCADE;

ALTER TABLE [dbo].[Payments] ADD CONSTRAINT [FK_Payments_Invoices_InvoiceId]
    FOREIGN KEY ([InvoiceId]) REFERENCES [dbo].[Invoices]([Id]) ON DELETE CASCADE;

ALTER TABLE [dbo].[Invoices] ADD CONSTRAINT [FK_Invoices_Customers_CustomerId]
    FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE CASCADE;

ALTER TABLE [dbo].[Invoices] ADD CONSTRAINT [FK_Invoices_Tours]
    FOREIGN KEY ([TourId]) REFERENCES [dbo].[Tours]([Id]);
/*
	ALTER TABLE [dbo].[AspNetUserTokens] ADD CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId]
		FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers]([Id]) ON DELETE CASCADE;

	ALTER TABLE [dbo].[AspNetUserRoles] ADD CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId]
		FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers]([Id]) ON DELETE CASCADE;

	ALTER TABLE [dbo].[AspNetUserRoles] ADD CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId]
		FOREIGN KEY ([RoleId]) REFERENCES [dbo].[AspNetRoles]([Id]) ON DELETE CASCADE;

	ALTER TABLE [dbo].[AspNetUserLogins] ADD CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId]
		FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers]([Id]) ON DELETE CASCADE;

	ALTER TABLE [dbo].[AspNetUserClaims] ADD CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId]
		FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers]([Id]) ON DELETE CASCADE;

	ALTER TABLE [dbo].[AspNetRoleClaims] ADD CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId]
		FOREIGN KEY ([RoleId]) REFERENCES [dbo].[AspNetRoles]([Id]) ON DELETE CASCADE;
*/
ALTER TABLE [dbo].[Eventos] ADD CONSTRAINT [FK_Eventos_Shows_ShowId]
    FOREIGN KEY ([ShowId]) REFERENCES [dbo].[Shows]([Id]) ON DELETE CASCADE;

ALTER TABLE [dbo].[Eventos] ADD CONSTRAINT [FK_Eventos_Theaters_TheaterId]
    FOREIGN KEY ([TheaterId]) REFERENCES [dbo].[Theaters]([Id]) ON DELETE CASCADE;

ALTER TABLE [dbo].[Eventos] ADD CONSTRAINT [FK_Eventos_Tours_TourId]
    FOREIGN KEY ([TourId]) REFERENCES [dbo].[Tours]([Id]) ON DELETE CASCADE;

ALTER TABLE [dbo].[TheaterImages] ADD CONSTRAINT [FK_TheaterImages_Theaters_TheaterId]
    FOREIGN KEY ([TheaterId]) REFERENCES [dbo].[Theaters]([Id]) ON DELETE CASCADE;

ALTER TABLE [dbo].[Tours] ADD CONSTRAINT [FK_Tours_Companies_CompanyId]
    FOREIGN KEY ([CompanyId]) REFERENCES [dbo].[Companies]([Id]) ON DELETE CASCADE;