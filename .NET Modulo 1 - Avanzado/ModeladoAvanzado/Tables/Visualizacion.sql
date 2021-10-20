CREATE TABLE [dbo].[Visualizacion]
(
	VisualizacionId INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	VideoId INT NOT NULL,
	UsuarioId INT,
	FechaVisualizacion DATETIME NOT NULL,
	FOREIGN KEY (VideoId) REFERENCES Video(VideoId),
	FOREIGN KEY (UsuarioId) REFERENCES Usuario(UsuarioId)
)
