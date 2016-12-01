USE [Data_Services]
GO
/****** Object:  Table [dbo].[Master_Grade]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Master_Grade](
	[ID] [int] NOT NULL,
	[SchoolForce__Assignment__c] [varchar](18) NULL,
	[SchoolForce__Assignment_Weighting__c] [int] NOT NULL,
	[SchoolForce__Course__c] [varchar](18) NOT NULL,
	[SchoolForce__Grade_Number__c] [varchar](256) NULL,
	[SchoolForce__Points_Grade__c] [int] NOT NULL,
	[SchoolForce__Possible_Points__c] [int] NOT NULL,
	[SchoolForce__Time__c] [varchar](18) NOT NULL,
	[SchoolForce__Student__c] [varchar](18) NOT NULL,
	[SchoolForce__Student_Section__c] [varchar](18) NULL,
	[SchoolForce__Valid_Grade__c] [int] NOT NULL,
	[SchoolForce__External_Id__c] [varchar](256) NULL,
	[SF_ID] [varchar](18) NOT NULL,
	[SchoolForce__Entered_Grade__c] [varchar](255) NULL
) ON [PRIMARY]

GO
