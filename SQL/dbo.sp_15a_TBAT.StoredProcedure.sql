USE [Data_Services]
GO
/****** Object:  StoredProcedure [dbo].[sp_15a_TBAT]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_15a_TBAT]
AS
BEGIN

	select a.ID SF_ID, b.*, c.Student_ID Source_Student_ID 
	into #TBAT
	from SDW_Stage_Prod_17.dbo.Assesment__c (nolock) a
	inner join Data_Services.dbo.SF_Assessment_TBAT (nolock) b on a.[External_Id__c] = b.[SchoolForce__External_Id__c]
	inner join Data_Services.dbo.Master_Student (nolock) c on b.Student_ID = c.SF_ID

	insert into Data_Services.dbo.Master_Assessment_TBAT(SF_ID, Student_ID, SchoolForce__Type__c, SchoolForce__Assessment_Name__c, [Date], Number_Of_Absences, Excused_Absences, Number_of_Tardies, Number_Of_Unexcused_Absences, Days_Enrolled__c, SchoolForce__External_Id__c, Source_Student_ID)
	select a.SF_ID, a.Student_ID, a.SchoolForce__Type__c, a.SchoolForce__Assessment_Name__c, a.[Date], a.Number_Of_Absences, a.Excused_Absences, a.Number_of_Tardies, a.Number_Of_Unexcused_Absences, a.Days_Enrolled__c, a.SchoolForce__External_Id__c, a.Source_Student_ID
	from #TBAT (nolock) a
	left outer join Data_Services.dbo.Master_Assessment_TBAT (nolock) d on a.SchoolForce__External_Id__c = d.SchoolForce__External_Id__c
	where d.SchoolForce__External_Id__c is null

	update Data_Services.dbo.Master_Assessment_TBAT
	set Number_Of_Absences = b.Number_Of_Absences
	,Excused_Absences = b.Excused_Absences
	,Number_of_Tardies = b.Number_of_Tardies
	,Number_Of_Unexcused_Absences = b.Number_Of_Unexcused_Absences
	,Days_Enrolled__c = b.Days_Enrolled__c
	from Data_Services.dbo.Master_Assessment_TBAT (nolock) a
	inner join #TBAT (nolock) b on a.SchoolForce__External_Id__c = b.SchoolForce__External_Id__c
END

GO
