﻿/*
Deployment script for ModeladoAvanzado

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "ModeladoAvanzado"
:setvar DefaultFilePrefix "ModeladoAvanzado"
:setvar DefaultDataPath "C:\Users\JoseMolina\AppData\Local\Microsoft\VisualStudio\SSDT\ModeladoAvanzado"
:setvar DefaultLogPath "C:\Users\JoseMolina\AppData\Local\Microsoft\VisualStudio\SSDT\ModeladoAvanzado"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                CURSOR_DEFAULT LOCAL 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET PAGE_VERIFY NONE,
                DISABLE_BROKER 
            WITH ROLLBACK IMMEDIATE;
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367)) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
PRINT N'Creating Table [dbo].[Area]...';


GO
CREATE TABLE [dbo].[Area] (
    [AreaId]      INT           NOT NULL,
    [AreaPadreId] INT           NULL,
    [AreaNombre]  NVARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([AreaId] ASC)
);


GO
PRINT N'Creating Table [dbo].[Autor]...';


GO
CREATE TABLE [dbo].[Autor] (
    [AutorId]     INT            NOT NULL,
    [Nombre]      NVARCHAR (200) NOT NULL,
    [Descripcion] NVARCHAR (MAX) NOT NULL,
    [Twitter]     NVARCHAR (500) NULL,
    [GitHub]      NVARCHAR (500) NULL,
    PRIMARY KEY CLUSTERED ([AutorId] ASC)
);


GO
PRINT N'Creating Table [dbo].[Curso]...';


GO
CREATE TABLE [dbo].[Curso] (
    [CursoId]  INT            NOT NULL,
    [Titulo]   NVARCHAR (100) NOT NULL,
    [AreaId]   INT            NOT NULL,
    [Resumen]  NVARCHAR (MAX) NOT NULL,
    [CursoURL] NVARCHAR (250) NOT NULL,
    PRIMARY KEY CLUSTERED ([CursoId] ASC)
);


GO
PRINT N'Creating Table [dbo].[CursoAutor]...';


GO
CREATE TABLE [dbo].[CursoAutor] (
    [CursoAutorId] INT NOT NULL,
    [CursoId]      INT NOT NULL,
    [AutorId]      INT NOT NULL,
    PRIMARY KEY CLUSTERED ([CursoAutorId] ASC)
);


GO
PRINT N'Creating Table [dbo].[Leccion]...';


GO
CREATE TABLE [dbo].[Leccion] (
    [LeccionId]        INT            NOT NULL,
    [CursoId]          INT            NOT NULL,
    [VideoID]          INT            NOT NULL,
    [TextoURL]         NVARCHAR (500) NOT NULL,
    [FechaPublicacion] DATETIME       NOT NULL,
    PRIMARY KEY CLUSTERED ([LeccionId] ASC)
);


GO
PRINT N'Creating Table [dbo].[Subscripcion]...';


GO
CREATE TABLE [dbo].[Subscripcion] (
    [SubscripcionId] INT            NOT NULL,
    [Nombre]         NVARCHAR (200) NOT NULL,
    PRIMARY KEY CLUSTERED ([SubscripcionId] ASC)
);


GO
PRINT N'Creating Table [dbo].[SubscripcionUsuario]...';


GO
CREATE TABLE [dbo].[SubscripcionUsuario] (
    [SubscripcionUsuarioId] INT      NOT NULL,
    [SubscripcionId]        INT      NOT NULL,
    [UsuarioId]             INT      NOT NULL,
    [FechaSubscripcion]     DATETIME NOT NULL,
    PRIMARY KEY CLUSTERED ([SubscripcionUsuarioId] ASC)
);


GO
PRINT N'Creating Table [dbo].[SubscripcionVideo]...';


GO
CREATE TABLE [dbo].[SubscripcionVideo] (
    [SubscripcionVideoId] INT NOT NULL,
    [SubscripcionId]      INT NOT NULL,
    [VideoId]             INT NOT NULL,
    PRIMARY KEY CLUSTERED ([SubscripcionVideoId] ASC)
);


GO
PRINT N'Creating Table [dbo].[Tag]...';


GO
CREATE TABLE [dbo].[Tag] (
    [TagId] INT           NOT NULL,
    [Tag]   NVARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([TagId] ASC)
);


GO
PRINT N'Creating Table [dbo].[TagCurso]...';


GO
CREATE TABLE [dbo].[TagCurso] (
    [TagCursoId] INT NOT NULL,
    [TagId]      INT NOT NULL,
    [CursoId]    INT NOT NULL,
    PRIMARY KEY CLUSTERED ([TagCursoId] ASC)
);


GO
PRINT N'Creating Table [dbo].[TagVideo]...';


GO
CREATE TABLE [dbo].[TagVideo] (
    [TagVideoId] INT NOT NULL,
    [TagId]      INT NOT NULL,
    [VideoId]    INT NOT NULL,
    PRIMARY KEY CLUSTERED ([TagVideoId] ASC)
);


GO
PRINT N'Creating Table [dbo].[Usuario]...';


GO
CREATE TABLE [dbo].[Usuario] (
    [UsuarioId]  INT            NOT NULL,
    [Nombre]     NVARCHAR (200) NOT NULL,
    [Email]      NVARCHAR (500) NOT NULL,
    [Contraseña] BINARY (64)    NOT NULL,
    PRIMARY KEY CLUSTERED ([UsuarioId] ASC)
);


GO
PRINT N'Creating Table [dbo].[Video]...';


GO
CREATE TABLE [dbo].[Video] (
    [VideoId]  INT            NOT NULL,
    [VideoURL] NVARCHAR (500) NOT NULL,
    PRIMARY KEY CLUSTERED ([VideoId] ASC)
);


GO
PRINT N'Creating Table [dbo].[Visualizacion]...';


GO
CREATE TABLE [dbo].[Visualizacion] (
    [VisualizacionId]    INT      NOT NULL,
    [VideoId]            INT      NOT NULL,
    [UsuarioId]          INT      NULL,
    [FechaVisualizacion] DATETIME NOT NULL,
    PRIMARY KEY CLUSTERED ([VisualizacionId] ASC)
);


GO
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[Area]...';


GO
ALTER TABLE [dbo].[Area] WITH NOCHECK
    ADD FOREIGN KEY ([AreaPadreId]) REFERENCES [dbo].[Area] ([AreaId]);


GO
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[Curso]...';


GO
ALTER TABLE [dbo].[Curso] WITH NOCHECK
    ADD FOREIGN KEY ([AreaId]) REFERENCES [dbo].[Area] ([AreaId]);


GO
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[CursoAutor]...';


GO
ALTER TABLE [dbo].[CursoAutor] WITH NOCHECK
    ADD FOREIGN KEY ([CursoId]) REFERENCES [dbo].[Curso] ([CursoId]);


GO
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[CursoAutor]...';


GO
ALTER TABLE [dbo].[CursoAutor] WITH NOCHECK
    ADD FOREIGN KEY ([AutorId]) REFERENCES [dbo].[Autor] ([AutorId]);


GO
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[Leccion]...';


GO
ALTER TABLE [dbo].[Leccion] WITH NOCHECK
    ADD FOREIGN KEY ([CursoId]) REFERENCES [dbo].[Curso] ([CursoId]);


GO
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[Leccion]...';


GO
ALTER TABLE [dbo].[Leccion] WITH NOCHECK
    ADD FOREIGN KEY ([VideoID]) REFERENCES [dbo].[Video] ([VideoId]);


GO
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[SubscripcionUsuario]...';


GO
ALTER TABLE [dbo].[SubscripcionUsuario] WITH NOCHECK
    ADD FOREIGN KEY ([SubscripcionId]) REFERENCES [dbo].[Subscripcion] ([SubscripcionId]);


GO
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[SubscripcionUsuario]...';


GO
ALTER TABLE [dbo].[SubscripcionUsuario] WITH NOCHECK
    ADD FOREIGN KEY ([UsuarioId]) REFERENCES [dbo].[Usuario] ([UsuarioId]);


GO
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[SubscripcionVideo]...';


GO
ALTER TABLE [dbo].[SubscripcionVideo] WITH NOCHECK
    ADD FOREIGN KEY ([SubscripcionId]) REFERENCES [dbo].[Subscripcion] ([SubscripcionId]);


GO
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[SubscripcionVideo]...';


GO
ALTER TABLE [dbo].[SubscripcionVideo] WITH NOCHECK
    ADD FOREIGN KEY ([VideoId]) REFERENCES [dbo].[Video] ([VideoId]);


GO
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[TagCurso]...';


GO
ALTER TABLE [dbo].[TagCurso] WITH NOCHECK
    ADD FOREIGN KEY ([TagId]) REFERENCES [dbo].[Tag] ([TagId]);


GO
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[TagCurso]...';


GO
ALTER TABLE [dbo].[TagCurso] WITH NOCHECK
    ADD FOREIGN KEY ([CursoId]) REFERENCES [dbo].[Curso] ([CursoId]);


GO
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[TagVideo]...';


GO
ALTER TABLE [dbo].[TagVideo] WITH NOCHECK
    ADD FOREIGN KEY ([TagId]) REFERENCES [dbo].[Tag] ([TagId]);


GO
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[TagVideo]...';


GO
ALTER TABLE [dbo].[TagVideo] WITH NOCHECK
    ADD FOREIGN KEY ([VideoId]) REFERENCES [dbo].[Video] ([VideoId]);


GO
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[Visualizacion]...';


GO
ALTER TABLE [dbo].[Visualizacion] WITH NOCHECK
    ADD FOREIGN KEY ([VideoId]) REFERENCES [dbo].[Video] ([VideoId]);


GO
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[Visualizacion]...';


GO
ALTER TABLE [dbo].[Visualizacion] WITH NOCHECK
    ADD FOREIGN KEY ([UsuarioId]) REFERENCES [dbo].[Usuario] ([UsuarioId]);


GO
PRINT N'Creating View [dbo].[vAreaPrincipal]...';


GO
CREATE VIEW [dbo].[vAreaPrincipal]
AS 
	SELECT 
		a.AreaId,
		a.AreaNombre
	FROM dbo.Area a
	WHERE a.AreaPadreId IS NULL
GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
CREATE TABLE [#__checkStatus] (
    id           INT            IDENTITY (1, 1) PRIMARY KEY CLUSTERED,
    [Schema]     NVARCHAR (256),
    [Table]      NVARCHAR (256),
    [Constraint] NVARCHAR (256)
);

SET NOCOUNT ON;

DECLARE tableconstraintnames CURSOR LOCAL FORWARD_ONLY
    FOR SELECT SCHEMA_NAME([schema_id]),
               OBJECT_NAME([parent_object_id]),
               [name],
               0
        FROM   [sys].[objects]
        WHERE  [parent_object_id] IN (OBJECT_ID(N'dbo.Area'), OBJECT_ID(N'dbo.Curso'), OBJECT_ID(N'dbo.CursoAutor'), OBJECT_ID(N'dbo.Leccion'), OBJECT_ID(N'dbo.SubscripcionUsuario'), OBJECT_ID(N'dbo.SubscripcionVideo'), OBJECT_ID(N'dbo.TagCurso'), OBJECT_ID(N'dbo.TagVideo'), OBJECT_ID(N'dbo.Visualizacion'))
               AND [type] IN (N'F', N'C')
                   AND [object_id] IN (SELECT [object_id]
                                       FROM   [sys].[check_constraints]
                                       WHERE  [is_not_trusted] <> 0
                                              AND [is_disabled] = 0
                                       UNION
                                       SELECT [object_id]
                                       FROM   [sys].[foreign_keys]
                                       WHERE  [is_not_trusted] <> 0
                                              AND [is_disabled] = 0);

DECLARE @schemaname AS NVARCHAR (256);

DECLARE @tablename AS NVARCHAR (256);

DECLARE @checkname AS NVARCHAR (256);

DECLARE @is_not_trusted AS INT;

DECLARE @statement AS NVARCHAR (1024);

BEGIN TRY
    OPEN tableconstraintnames;
    FETCH tableconstraintnames INTO @schemaname, @tablename, @checkname, @is_not_trusted;
    WHILE @@fetch_status = 0
        BEGIN
            PRINT N'Checking constraint: ' + @checkname + N' [' + @schemaname + N'].[' + @tablename + N']';
            SET @statement = N'ALTER TABLE [' + @schemaname + N'].[' + @tablename + N'] WITH ' + CASE @is_not_trusted WHEN 0 THEN N'CHECK' ELSE N'NOCHECK' END + N' CHECK CONSTRAINT [' + @checkname + N']';
            BEGIN TRY
                EXECUTE [sp_executesql] @statement;
            END TRY
            BEGIN CATCH
                INSERT  [#__checkStatus] ([Schema], [Table], [Constraint])
                VALUES                  (@schemaname, @tablename, @checkname);
            END CATCH
            FETCH tableconstraintnames INTO @schemaname, @tablename, @checkname, @is_not_trusted;
        END
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH

IF CURSOR_STATUS(N'LOCAL', N'tableconstraintnames') >= 0
    CLOSE tableconstraintnames;

IF CURSOR_STATUS(N'LOCAL', N'tableconstraintnames') = -1
    DEALLOCATE tableconstraintnames;

SELECT N'Constraint verification failed:' + [Schema] + N'.' + [Table] + N',' + [Constraint]
FROM   [#__checkStatus];

IF @@ROWCOUNT > 0
    BEGIN
        DROP TABLE [#__checkStatus];
        RAISERROR (N'An error occurred while verifying constraints', 16, 127);
    END

SET NOCOUNT OFF;

DROP TABLE [#__checkStatus];


GO
PRINT N'Update complete.';


GO