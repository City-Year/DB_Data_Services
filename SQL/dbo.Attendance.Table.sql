USE [Data_Services]
GO
/****** Object:  Table [dbo].[Attendance]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attendance](
	[Student_ID] [varchar](256) NULL,
	[Date] [varchar](256) NULL,
	[Attendance_Status] [varchar](256) NULL,
	[Attendance_Value] [varchar](256) NULL,
	[District] [varchar](256) NULL,
	[RunDate] [varchar](256) NULL,
	[Class_Section_ID] [varchar](256) NULL
) ON [PRIMARY]

GO
