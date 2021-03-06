USE [Data_Services]
GO
/****** Object:  Table [dbo].[Assessment_ORL_ADA]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Assessment_ORL_ADA](
	[STD_NBR] [varchar](256) NULL,
	[SCHL_YR] [varchar](256) NULL,
	[SITE_ID] [varchar](256) NULL,
	[CAL_DT] [varchar](256) NULL,
	[ATTENDANCE_STATUS] [varchar](256) NULL,
	[ATTENDANCE_VALUE] [varchar](256) NULL,
	[MARKING_PERIOD] [varchar](256) NULL,
	[District] [varchar](256) NULL,
	[RunDate] [varchar](256) NULL
) ON [PRIMARY]

GO
