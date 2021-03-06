USE [Data_Services]
GO
/****** Object:  View [dbo].[vw_Staff_Staff_Essentials]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [dbo].[vw_Staff_Staff_Essentials]
AS
SELECT B.Salutation
	,B.FirstName
	,B.LastName
	,A.Staff_Name_for_StaffRcd
	,A.ORG_ID_for_StaffRcd
	,B.SchoolForce__Gender__c
	,B.Id AS Individual__c
FROM Data_Services.dbo.vw_Staff_Contact_Essential_Info AS A LEFT JOIN 
	SDW_Stage.dbo.Contact AS B ON A.TempEmail = B.SchoolForce__ID__c
	
	GROUP BY B.Salutation,B.FirstName,B.LastName,A.Staff_Name_for_StaffRcd,A.ORG_ID_for_StaffRcd,B.SchoolForce__Gender__c
	,B.Id



GO
