USE LemonMusic
GO

--Listar las pistas (tabla Track) con precio mayor o igual a 1€
SELECT 
	t.TrackId, 	
	t.UnitPrice
FROM dbo.Track t
WHERE t.UnitPrice >= 1

--Listar las pistas de más de 4 minutos de duración
SELECT 
	t.TrackId, 	
	t.Milliseconds, 	
	(t.Milliseconds / 1000 / 60) AS DuracionMinutos	
FROM dbo.Track t
WHERE t.Milliseconds >= (4 * 60 * 1000)

--Listar las pistas que tengan entre 2 y 3 minutos de duración
SELECT 
	t.TrackId, 	
	t.Milliseconds, 	
	(t.Milliseconds / 1000 / 60) AS DuracionMinutos	
FROM dbo.Track t
WHERE t.Milliseconds >= (2 * 60 * 1000) 
AND t.Milliseconds < (4 * 60 * 1000)

--Listar las pistas que uno de sus compositores (columna Composer) sea Mercury
SELECT 
	t.TrackId,
	t.Composer
FROM dbo.Track t
WHERE t.Composer LIKE '%Mercury%'

--Calcular la media de duración de las pistas (Track) de la plataforma
SELECT 
	AVG(t.Milliseconds) AS AverageMilliseconds,
	(AVG(t.Milliseconds) / 1000 / 60) AS AverageMinutos	
FROM dbo.Track t

--Listar los clientes (tabla Customer) de USA, Canada y Brazil
SELECT 
	c.CustomerId,
	c.Country
FROM dbo.Customer c
WHERE c.Country IN ('USA', 'Canada', 'Brazil')

--Listar todas las pistas del artista 'Queen' (Artist.Name = 'Queen')
SELECT 
	t.TrackId,
	ar.ArtistId,
	ar.[Name]
FROM dbo.Track t
	JOIN dbo.Album a ON a.AlbumId = t.AlbumId
	JOIN dbo.Artist ar ON ar.ArtistId = a.ArtistId
		AND ar.[Name] = 'Queen'

SELECT 
	t.TrackId
FROM dbo.Track t
WHERE EXISTS
(
	SELECT TOP 1 1
	FROM dbo.Album a 
	WHERE a.AlbumId = t.AlbumId
	AND a.ArtistId = 51 --Queen
)

--Listar las pistas del artista 'Queen' en las que haya participado como compositor David Bowie
SELECT 
	t.TrackId,
	ar.ArtistId,
	ar.[Name],
	t.Composer
FROM dbo.Track t
	JOIN dbo.Album a ON a.AlbumId = t.AlbumId
	JOIN dbo.Artist ar ON ar.ArtistId = a.ArtistId
		AND ar.[Name] = 'Queen'
WHERE t.Composer LIKE '%David Bowie%'

SELECT 
	t.TrackId,
	t.Composer
FROM dbo.Track t
WHERE EXISTS
(
	SELECT TOP 1 1
	FROM dbo.Album a 
	WHERE a.AlbumId = t.AlbumId
	AND a.ArtistId = 51 --Queen
)
AND t.Composer LIKE '%David Bowie%'

--Listar las pistas de la playlist 'Heavy Metal Classic'
SELECT 
	p.PlaylistId,
	p.[Name] AS PlaylistName,
	t.TrackId,
	t.[Name] AS TrackName
FROM dbo.Playlist p
	JOIN dbo.PlaylistTrack pt ON pt.PlaylistId = p.PlaylistId
	JOIN dbo.Track t ON t.TrackId = pt.TrackId
WHERE p.[Name] = 'Heavy Metal Classic'

--Listar las playlist junto con el número de pistas que contienen
SELECT 
	p.PlaylistId,
	p.[Name] AS PlaylistName,
	COUNT(pt.TrackID) AS Tracks
FROM dbo.Playlist p
	JOIN dbo.PlaylistTrack pt ON pt.PlaylistId = p.PlaylistId
GROUP BY 
	p.PlaylistId,
	p.[Name]

--Listar las playlist (sin repetir ninguna) que tienen alguna canción de AC/DC
SELECT DISTINCT
	--p.PlaylistId,
	p.[Name]
FROM dbo.Playlist p
WHERE EXISTS 
(
	SELECT TOP 1 1
	FROM dbo.PlaylistTrack pt
		JOIN dbo.Track t ON t.TrackId = pt.TrackId
		JOIN dbo.Album a ON a.AlbumId = t.AlbumId
		JOIN dbo.Artist ar ON ar.ArtistId = a.ArtistId
			AND ar.[Name] = 'AC/DC'
	WHERE pt.PlaylistId = p.PlaylistId
)

--Listar las playlist que tienen alguna canción del artista Queen, junto con la cantidad que tienen
SELECT
	p.PlaylistId,
	p.[Name] AS PlaylistName,
	ar.[Name] AS ArtistName,
	COUNT(t.TrackId) AS Tracks
FROM dbo.Playlist p
	JOIN dbo.PlaylistTrack pt ON pt.PlaylistId = p.PlaylistId
	JOIN dbo.Track t ON t.TrackId = pt.TrackId
	JOIN dbo.Album a ON a.AlbumId = t.AlbumId
	JOIN dbo.Artist ar ON ar.ArtistId = a.ArtistId
		AND ar.Name = 'Queen'
GROUP BY 
	p.PlaylistId,
	p.[Name],
	ar.[Name]

--Listar las pistas que no están en ninguna playlist
SELECT 
	t.TrackId
FROM dbo.Track t
WHERE NOT EXISTS
(
	SELECT TOP 1 1
	FROM dbo.PlaylistTrack pt
	WHERE pt.TrackId = t.TrackId
)

SELECT 
	t.TrackId
FROM dbo.Track t
	LEFT JOIN dbo.PlaylistTrack pt ON pt.TrackId = t.TrackId
WHERE pt.PlaylistId IS NULL

--Listar los artistas que no tienen album
SELECT 
	ar.ArtistId,
	ar.[Name]
FROM dbo.Artist ar
WHERE NOT EXISTS
(
	SELECT TOP 1 1
	FROM dbo.Album a
	WHERE a.ArtistId = ar.ArtistId
)

--Listar los artistas con el número de albums que tienen
SELECT 
	ar.ArtistId,
	ar.[Name],
	COUNT(a.AlbumID)
FROM dbo.Artist ar
	LEFT JOIN dbo.Album a ON a.ArtistId = ar.ArtistId
GROUP BY 
	ar.ArtistId,
	ar.[Name]
ORDER BY 3