USE [Data_Services]
GO
/****** Object:  Table [dbo].[Period_Subjects]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Period_Subjects](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Period_Key] [varchar](80) NULL,
	[Period_Order] [int] NULL,
	[SchoolYear] [varchar](18) NULL
) ON [PRIMARY]

GO
