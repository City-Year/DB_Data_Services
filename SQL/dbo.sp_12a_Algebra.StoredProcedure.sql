USE [Data_Services]
GO
/****** Object:  StoredProcedure [dbo].[sp_12a_Algebra]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_12a_Algebra]
AS
BEGIN
	insert into Data_Services.dbo.Master_Assessment_Algebra(Student_ID, SchoolForce__Type__c, SchoolForce__Assessment_Name__c, Date_Administered__c, FSA_Algebra_Score_c, Local_Benchmark__c, SchoolForce__External_Id__c, Assessment_Name, Source_Student_ID, SF_ID)
	select a.Student_ID, a.SchoolForce__Type__c, a.SchoolForce__Assessment_Name__c, a.Date_Administered__c, a.FSA_Algebra_Score_c, a.Local_Benchmark__c, a.SchoolForce__External_Id__c, a.Assessment_Name, a.Source_Student_ID, b.ID SF_ID
	from Data_Services.dbo.SF_Assessment_Algebra (nolock) a 
	inner join SDW_Stage_Prod.dbo.Assesment__c (nolock) b on a.SchoolForce__External_Id__c = b.External_Id__c
	left outer join Data_Services.dbo.Master_Assessment_Algebra (nolock) c on a.SchoolForce__External_Id__c = c.SchoolForce__External_Id__c
	where c.SchoolForce__External_Id__c is null
END

GO
