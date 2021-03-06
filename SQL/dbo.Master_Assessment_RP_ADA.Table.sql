USE [Data_Services]
GO
/****** Object:  Table [dbo].[Master_Assessment_RP_ADA]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Master_Assessment_RP_ADA](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Student_ID] [varchar](18) NOT NULL,
	[SchoolForce__Type__c] [varchar](18) NULL,
	[SchoolForce__Assessment_Name__c] [varchar](255) NOT NULL,
	[Date_Administered__c] [date] NULL,
	[Average_Daily_Attendance__c] [varchar](256) NULL,
	[Time_Period__c] [varchar](256) NULL,
	[SchoolForce__External_Id__c] [varchar](255) NULL,
	[Source_Student_ID] [varchar](255) NULL,
	[SF_ID] [varchar](18) NULL
) ON [PRIMARY]

GO
