USE [Data_Services]
GO
/****** Object:  Table [dbo].[SF_Assignment]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SF_Assignment](
	[ID] [int] IDENTITY(373062,1) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[Assignment_Library__c] [nvarchar](18) NOT NULL,
	[SchoolForce__Due_Date__c] [date] NULL,
	[SchoolForce__Picklist_Value__c] [nvarchar](18) NOT NULL,
	[SchoolForce__Include_in_Final_Grade__c] [int] NOT NULL,
	[SchoolForce__Name_in_Gradebook__c] [nvarchar](250) NULL,
	[SchoolForce__Possible_Points__c] [int] NOT NULL,
	[SchoolForce__Time__c] [nvarchar](18) NOT NULL,
	[SchoolForce__Section__c] [nvarchar](250) NULL,
	[SchoolForce__Weighting_Value__c] [int] NOT NULL,
	[SchoolForce__External_Id__c] [nvarchar](250) NULL,
	[Local_Assignment_Type__c] [nvarchar](250) NULL
) ON [PRIMARY]

GO
