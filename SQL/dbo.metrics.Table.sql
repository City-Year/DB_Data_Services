USE [Data_Services]
GO
/****** Object:  Table [dbo].[metrics]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[metrics](
	[District] [varchar](50) NULL,
	[tablename] [varchar](50) NULL,
	[fieldname] [varchar](100) NULL,
	[error_msg] [varchar](100) NULL
) ON [PRIMARY]

GO
