CREATE TABLE [dbo].[SubscripcionUsuario]
(
	SubscripcionUsuarioId INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	SubscripcionId INT NOT NULL,
	UsuarioId INT NOT NULL,
	FechaSubscripcion DATETIME NOT NULL,	
	FOREIGN KEY (SubscripcionId) REFERENCES Subscripcion(SubscripcionId),
	FOREIGN KEY (UsuarioId) REFERENCES Usuario(UsuarioId),
)
