USE [Data_Services]
GO
/****** Object:  StoredProcedure [dbo].[sp_10a_Assignment_MP]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_10a_Assignment_MP]
AS
BEGIN

	insert into Data_Services.dbo.Master_Assignment_MP(
	Name, Assignment_Library__c, SchoolForce__Due_Date__c, SchoolForce__Picklist_Value__c, SchoolForce__Include_in_Final_Grade__c, SchoolForce__Name_in_Gradebook__c, 
	SchoolForce__Possible_Points__c, SchoolForce__Time__c, SchoolForce__Section__c, SchoolForce__Weighting_Value__c, Math_Class_Section_ID, Student_ID, Marking_Period, SchoolForce__External_Id__c, ID)
	select a.Name, b.Assignment_Library__c, a.SchoolForce__Due_Date__c, a.SchoolForce__Picklist_Value__c, a.SchoolForce__Include_in_Final_Grade__c, a.SchoolForce__Name_in_Gradebook__c, 
	a.SchoolForce__Possible_Points__c, a.SchoolForce__Time__c, a.SchoolForce__Section__c, a.SchoolForce__Weighting_Value__c, Math_Class_Section_ID, Student_ID, Marking_Period, 
	a.SchoolForce__External_Id__c, b.ID SF_ID
	from Data_Services.dbo.SF_Assignment_MP (nolock) a
	inner join SDW_Stage_Prod_17.dbo.Assignment__c (nolock) b on a.SchoolForce__External_Id__c = b.External_Id__c

END

GO
