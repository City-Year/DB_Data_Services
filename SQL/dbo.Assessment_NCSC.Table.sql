USE [Data_Services]
GO
/****** Object:  Table [dbo].[Assessment_NCSC]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Assessment_NCSC](
	[Student_ID] [varchar](255) NULL,
	[Test_Name] [varchar](255) NULL,
	[Performance Level 1] [varchar](255) NULL,
	[Performance Level 2] [varchar](255) NULL,
	[Performance Level 3] [varchar](255) NULL,
	[Performance Level 4] [varchar](255) NULL,
	[Scale Score] [varchar](255) NULL,
	[Raw Score] [varchar](255) NULL,
	[District] [varchar](255) NULL,
	[RunDate] [varchar](255) NULL
) ON [PRIMARY]

GO
