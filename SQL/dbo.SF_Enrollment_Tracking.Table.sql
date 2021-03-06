USE [Data_Services]
GO
/****** Object:  Table [dbo].[SF_Enrollment_Tracking]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SF_Enrollment_Tracking](
	[SchoolForce__Active__c] [int] NOT NULL,
	[SchoolForce__Current_Record__c] [int] NOT NULL,
	[SchoolForce__Start_Date__c] [date] NULL,
	[SchoolForce__Student_Section__c] [varchar](18) NOT NULL,
	[SchoolForce__Student__c] [varchar](18) NOT NULL,
	[Reference_Id__c] [varchar](255) NULL
) ON [PRIMARY]

GO
