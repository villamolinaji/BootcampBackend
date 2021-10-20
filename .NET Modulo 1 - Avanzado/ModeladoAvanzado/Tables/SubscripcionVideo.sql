CREATE TABLE [dbo].[SubscripcionVideo]
(
	SubscripcionVideoId INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	SubscripcionId INT NOT NULL,
	VideoId INT NOT NULL,
	FOREIGN KEY (SubscripcionId) REFERENCES Subscripcion(SubscripcionId),
	FOREIGN KEY (VideoId) REFERENCES Video(VideoId),
)
