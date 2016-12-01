USE [Data_Services]
GO
/****** Object:  Table [dbo].[Behavior]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Behavior](
	[Student_ID] [varchar](256) NULL,
	[Incident_Date] [varchar](256) NULL,
	[Offense] [varchar](256) NULL,
	[Consequence] [varchar](256) NULL,
	[District] [varchar](256) NULL,
	[RunDate] [varchar](256) NULL
) ON [PRIMARY]

GO
