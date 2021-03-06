USE [Data_Services]
GO
/****** Object:  Table [dbo].[Master_Assessment_TBBT]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Master_Assessment_TBBT](
	[SF_ID] [varchar](18) NOT NULL,
	[Student_ID] [varchar](18) NOT NULL,
	[SchoolForce__Type__c] [varchar](18) NOT NULL,
	[SchoolForce__Assessment_Name__c] [varchar](27) NOT NULL,
	[Date_Administered__c] [date] NULL,
	[Number_of_Office_Referrals__c] [int] NULL,
	[Number_of_Detentions__c] [int] NULL,
	[Number_of_Suspensions__c] [int] NULL,
	[SchoolForce__External_Id__c] [varchar](518) NULL,
	[Source_Student_ID] [varchar](256) NULL
) ON [PRIMARY]

GO
