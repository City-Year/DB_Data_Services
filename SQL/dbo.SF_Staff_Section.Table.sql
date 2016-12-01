USE [Data_Services]
GO
/****** Object:  Table [dbo].[SF_Staff_Section]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SF_Staff_Section](
	[SF_Staff_ID] [varchar](18) NULL,
	[SF_Section_ID] [varchar](18) NULL,
	[Active] [int] NOT NULL,
	[SchoolForce__External_Id__c] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
