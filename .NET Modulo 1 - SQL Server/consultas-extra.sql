USE LemonMusic
GO

--Listar las pistas ordenadas por el número de veces que aparecen en playlists de forma descendente
SELECT 
	t.TrackId,
	t.[Name],
	COUNT(pt.PlaylistId)
FROM dbo.Track t
	LEFT JOIN dbo.PlaylistTrack pt ON pt.TrackId = t.TrackId
GROUP BY 
	t.TrackId,
	t.[Name]
ORDER BY 3 DESC

--Listar las pistas más compradas (la tabla InvoiceLine tiene los registros de compras)
SELECT 
	t.TrackId,
	t.[Name]
FROM dbo.Track t
WHERE t.TrackId IN 
(
	SELECT
		il2.TrackId
	FROM dbo.InvoiceLine il2
	GROUP BY il2.TrackId
	HAVING COUNT(il2.TrackID) =
	(
		SELECT TOP 1 COUNT(il.TrackID)
		FROM dbo.InvoiceLine il
		GROUP BY il.TrackId
		ORDER BY 1 DESC
	)
)

--Listar los artistas más comprados
SELECT 
	a.ArtistId,
	a.[Name]
FROM dbo.Artist a
WHERE a.ArtistId IN 
(
	SELECT
		a2.ArtistId
	FROM dbo.InvoiceLine il2
		JOIN dbo.Track t2 ON t2.TrackId = il2.TrackId
		JOIN dbo.Album a2 ON a2.AlbumId = t2.AlbumId
	GROUP BY a2.ArtistId
	HAVING COUNT(a2.ArtistId) =
	(
		SELECT TOP 1 COUNT(a.ArtistId)
		FROM dbo.InvoiceLine il
			JOIN dbo.Track t ON t.TrackId = il.TrackId
			JOIN dbo.Album a ON a.AlbumId = t.AlbumId
		GROUP BY a.ArtistId
		ORDER BY 1 DESC
	)
)

--Listar las pistas que aún no han sido compradas por nadie
SELECT 
	t.TrackId,
	t.[Name]
FROM dbo.Track t
WHERE NOT EXISTS
(
	SELECT TOP 1 1
	FROM dbo.InvoiceLine il		
	WHERE il.TrackId = t.TrackId
)

--Listar los artistas que aún no han vendido ninguna pista
SELECT 
	a.ArtistId,
	a.[Name]
FROM dbo.Artist a
WHERE NOT EXISTS
(
	SELECT 1
	FROM dbo.Album al	
		JOIN dbo.Track t ON t.AlbumId = al.AlbumId
		JOIN dbo.InvoiceLine il ON il.TrackId = t.TrackId
	WHERE al.ArtistId = a.ArtistId
)
ORDER BY a.[Name]