CREATE VIEW [dbo].[vAreaTree]
AS 
	WITH cte_area AS 
	(
		SELECT 
			0 AS TreeLevel,
			a.AreaId,
			a.AreaId AS PrincipalArea,
			a.AreaNombre,
			a.AreaPadreId
		FROM dbo.Area a 
		WHERE a.AreaPadreId IS NULL

		UNION ALL 

		SELECT 
			c.TreeLevel + 1 AS TreeLevel,
			a.AreaId,
			c.PrincipalArea,
			a.AreaNombre,
			a.AreaPadreId
		FROM dbo.Area a 
			JOIN cte_area c ON c.AreaId = a.AreaPadreId
	)
	SELECT 
		ca.TreeLevel,
		ca.AreaId,
		ca.PrincipalArea,
		ca.AreaNombre,
		ca.AreaPadreId
	FROM cte_area ca

