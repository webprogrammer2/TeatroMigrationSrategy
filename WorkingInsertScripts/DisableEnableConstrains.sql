USE [TeatroManagementVS];
GO

-- ========================================
-- Disable all FOREIGN KEY and CHECK constraints
-- ========================================
EXEC sp_msforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL';
GO


USE [TeatroManagementVS];
GO
-- ========================================
-- Enable all FOREIGN KEY and CHECK constraints
-- ========================================
EXEC sp_msforeachtable 'ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL';
GO
