USE [Data_Services]
GO
/****** Object:  Table [dbo].[SF_Student_Section]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SF_Student_Section](
	[SchoolFore__Active__c] [int] NOT NULL,
	[SchoolForce__Section__c] [varchar](250) NULL,
	[SchoolForce__Student__c] [varchar](18) NOT NULL,
	[SchoolForce__External_Id__c] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
