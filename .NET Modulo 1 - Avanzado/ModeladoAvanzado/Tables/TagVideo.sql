﻿CREATE TABLE [dbo].[TagVideo]
(
	TagVideoId INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	TagId INT NOT NULL,
	VideoId INT NOT NULL,
	FOREIGN KEY (TagId) REFERENCES Tag(TagId),
	FOREIGN KEY (VideoId) REFERENCES Video(VideoId)
)