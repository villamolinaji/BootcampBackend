CREATE VIEW [dbo].[vAreaPrincipal]
AS 
	SELECT 
		a.AreaId,
		a.AreaNombre
	FROM dbo.Area a
	WHERE a.AreaPadreId IS NULL	
