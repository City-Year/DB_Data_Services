USE [Data_Services]
GO
/****** Object:  Table [dbo].[OCPS_MP_Grades]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OCPS_MP_Grades](
	[Student_ID] [varchar](50) NULL,
	[Marking_Period] [varchar](50) NULL,
	[class_Section_ID] [varchar](50) NULL,
	[Grade_Value] [varchar](50) NULL,
	[Weighted_Value] [varchar](50) NULL,
	[GPA_Value] [varchar](50) NULL
) ON [PRIMARY]

GO
