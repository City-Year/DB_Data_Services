USE [Data_Services]
GO
/****** Object:  Table [dbo].[Master_Staff_Section]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Master_Staff_Section](
	[ID] [varchar](18) NULL,
	[SchoolForce__Staff__c] [varchar](18) NULL,
	[SchoolForce__Section__c] [varchar](18) NULL,
	[SchoolForce__External_Id__c] [varchar](250) NULL
) ON [PRIMARY]

GO
