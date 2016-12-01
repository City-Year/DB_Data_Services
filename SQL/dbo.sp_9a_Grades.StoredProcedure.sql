USE [Data_Services]
GO
/****** Object:  StoredProcedure [dbo].[sp_9a_Grades]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_9a_Grades]
AS
BEGIN

	insert into Data_Services.dbo.Master_Grade(ID, SchoolForce__Assignment__c, SchoolForce__Assignment_Weighting__c, SchoolForce__Course__c, SchoolForce__Grade_Number__c, SchoolForce__Points_Grade__c, SchoolForce__Possible_Points__c, SchoolForce__Time__c, SchoolForce__Student__c, SchoolForce__Student_Section__c, SchoolForce__Valid_Grade__c, SchoolForce__External_Id__c, SchoolForce__Entered_Grade__c, SF_ID)
	select a.*, b.ID SF_ID 
	from Data_Services.dbo.SF_Grade (nolock) a
	inner join SDW_Stage_Prod_17.dbo.Grade__c (nolock) b on a.[SchoolForce__External_Id__c] = b.External_Id__c
	left outer join Data_Services.dbo.Master_Grade (nolock) c on a.[SchoolForce__External_Id__c] = c.SchoolForce__External_Id__c
	where c.SchoolForce__External_Id__c is null

	alter index all on Data_Services.dbo.Master_Grade REBUILD

--	exec Data_Services.dbo.sp_Index_Assignment_Grades_Drop

END

GO
