USE [Data_Services]
GO
/****** Object:  StoredProcedure [dbo].[sp_LA_2_Staff_Contact]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_LA_2_Staff_Contact] @District varchar(255) = 'Standard'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @District = 'LA'
	
	INSERT INTO Data_Services.dbo.Class_Processed(Student_ID
	, Class_Section_ID
	, Class_Period_Name
	, Period
	, Teacher_Name
	, Teacher_First_Name
	, Teacher_Last_Name,District
	)	
	
	SELECT DISTINCT a.Student_ID
	, a.Class_Section_ID
	, Period_Name
	, a.Period
	, a.Teacher_Name
	, SUBSTRING(a.Teacher_Name,CHARINDEX(',', a.Teacher_Name) + 2,LEN(a.Teacher_Name)- CHARINDEX(',', a.Teacher_Name)-1) First_Name
	, SUBSTRING(a.Teacher_Name,0,CHARINDEX(',', a.Teacher_Name)) Last_Name
	, a.District
	FROM Data_Services.dbo.Class (NOLOCK) a LEFT OUTER JOIN 
	Data_Services.dbo.Class_Processed (NOLOCK) b ON 
		a.Student_ID = b.Student_ID AND
		a.Class_Section_ID = b.Class_Section_ID AND
		a.Period = b.Period AND 
		a.Teacher_Name = b.Teacher_Name
	WHERE b.Student_ID IS NULL AND
		b.Class_Section_ID IS NULL AND
		b.Period IS NULL AND
		b.Teacher_Name IS NULL AND  
		a.district = 'LA'

	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Math' WHERE Class_Period_Name LIKE '%MATH%'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Math' WHERE Class_Period_Name LIKE '%Algebra%'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Math' WHERE Class_Period_Name LIKE '%Geometry%'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%English%'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Language%'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Reading%'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Debate%'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Journalism%'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Math' WHERE Class_Period_Name LIKE '%MATH%'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Math' WHERE Class_Period_Name LIKE '%Algebra%'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Math' WHERE Class_Period_Name LIKE '%Geometry%'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%English%'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Language%'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Reading%'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Debate%'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Journalism%'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Academic Assistance&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%ACT Prep&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Advanced Career Readiness&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%ADVISORY SEMINAR&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Advisory&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Math' WHERE Class_Period_Name LIKE '%Algebra I&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Math' WHERE Class_Period_Name LIKE '%Algebra I (K-8)&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Math' WHERE Class_Period_Name LIKE '%Algebra I DL (K-8)&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Math' WHERE Class_Period_Name LIKE '%Algebra II&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%American History%'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%American History (K-8)&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Art&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Art I&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Band&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Beginning Band&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Biology&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Biology (K-8)&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Business English&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Math' WHERE Class_Period_Name LIKE '%Business Math&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Math' WHERE Class_Period_Name LIKE '%Chemistry&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Civics&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%choir&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Clothing & Textiles Occupations&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Computer&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Culinary%'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Customer Service&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Debate&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Early Release&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%EARLY RELEASE (2 PERIODS)&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Education For Careers&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%ELA/Literacy 3&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%ELA/Literacy 4&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%ELA/Literacy 5&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%ELA/Literacy 6&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%ELA/Literacy 7&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%ELA/Literacy 8&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%ELA/Literacy Lab&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%ELA/Literacy SC&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%English I&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%English II&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%English III&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%English IV&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%ESL IV&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Food Services I&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Garden&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%General Elective&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Math' WHERE Class_Period_Name LIKE '%Geometry&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Geography&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Health&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Health Education&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Homeroom&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Intermediate Band&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Intro. Health Care Information Systems&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Journey To Careers&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Kinder Elective&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Lunch' WHERE Class_Period_Name LIKE '%Lunch&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Math' WHERE Class_Period_Name LIKE '%Math 1&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Math' WHERE Class_Period_Name LIKE '%Math 2&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Math' WHERE Class_Period_Name LIKE '%Math 3&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Math' WHERE Class_Period_Name LIKE '%Math 4&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Math' WHERE Class_Period_Name LIKE '%Math 5&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Math' WHERE Class_Period_Name LIKE '%Math 6&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Math' WHERE Class_Period_Name LIKE '%Math 7&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Math' WHERE Class_Period_Name LIKE '%Math 8&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Math' WHERE Class_Period_Name LIKE '%Math K&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Math' WHERE Class_Period_Name LIKE '%Math Lab&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Math' WHERE Class_Period_Name LIKE '%Math SC&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Multimedia Productions&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Music&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Nccer Carpentry I&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Nurse Assistant&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Office Assistant&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Orchestra&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%PE 1&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%PE 2&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%PE 3&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%PE 4&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%PE 5&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%PE 6&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%PE 7&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%PE 8&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%PE K&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Physical Education I&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Physical Education II&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Math' WHERE Class_Period_Name LIKE '%Physics I&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Math' WHERE Class_Period_Name LIKE '%Pre-Calculus&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%PREK &'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Reading 1&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Reading 2&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Reading K&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Reading SC&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Recess' WHERE Class_Period_Name LIKE '%Recess&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Science 1&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Science 2&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Science 3&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Science 4&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Science 5&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Science 6&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Science 7&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Science 8&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Science K&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Science SC&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Social Studies 1&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Social Studies 2&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Social Studies 3&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Social Studies 4&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Social Studies 5&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Social Studies 6&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Social Studies 7&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Social Studies 8&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Social Studies K&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Social Studies SC&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Social Studies%'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Science%'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Spanish&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Spanish I&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Spanish II&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Speech II&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Technical Writing&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'Elective' WHERE Class_Period_Name LIKE '%Technology&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%US History&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%World Geography&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%World History&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Writing 1&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Writing 2&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Writing K&'
	UPDATE Data_Services.dbo.Class_Processed SET Section_Type = 'ELA/Literacy' WHERE Class_Period_Name LIKE '%Writing SC&'

	DELETE FROM Data_Services.dbo.SF_Contact_Staff WHERE email LIKE'LA%'


INSERT INTO Data_Services.dbo.SF_Contact_Staff (RecordType
		,Salutation
		,Last_Name
		,First_Name 
		,Email
		,Mailing_Street
		,Mailing_City
		,Mailing_State
		,Mailing_Zip
		,Gender
		,Contact_Indv_Account_ID
		,OrgID
		,AccountID
		)
		
SELECT DISTINCT (SELECT [ID] FROM [sdw_stage_prod_17].[dbo].RecordType WHERE [Name] = 'staff') RecordType
	, '' Salutation
	, SUBSTRING(Teacher_Name, 0, CHARINDEX(',', Teacher_Name)) Last_Name
	, SUBSTRING(Teacher_Name, CHARINDEX(',', Teacher_Name) + 2, LEN(Teacher_Name) - CHARINDEX(',', Teacher_Name) - 1) First_Name
	, REPLACE(a.District + '_' + School_ID + '_' + SUBSTRING(Teacher_Name, CHARINDEX(',', Teacher_Name) + 2, LEN(Teacher_Name) - charindex(',', Teacher_Name) - 1) + '_' + substring(Teacher_Name, 0, charindex(',', Teacher_Name)), ' ', '_') SchoolForce__ID__c
	, '' [Mailing_Street]
	, '' [Mailing_City]
	, '' [Mailing_State]
	, '' [Mailing_Postal]
	, '' [Gender]
	, (SELECT [ID] FROM [sdw_stage_prod_17].[dbo].Account WHERE [Name] = 'Individuals') [Contact_Individual_AccountID]
	, '' OrgID
	, (SELECT [ID] FROM [sdw_stage_prod_17].[dbo].Account WHERE [Name] = 'Individuals') AccountID
	
FROM Data_Services.dbo.Class (NOLOCK) a INNER JOIN 
Data_Services.dbo.Student (NOLOCK) b ON 
		a.Student_ID = b.Student_ID LEFT OUTER JOIN 
SDW_Stage_PROD_17.dbo.Contact (NOLOCK) c ON 
		REPLACE(a.District + '_' + School_ID + '_' + SUBSTRING(Teacher_Name, CHARINDEX(',', Teacher_Name) + 2, LEN(Teacher_Name) - CHARINDEX(',', Teacher_Name) - 1) + '_' + SUBSTRING(Teacher_Name, 0, CHARINDEX(',', Teacher_Name)), ' ', '_') = c.ID__c
	
WHERE c.ID__c IS NULL AND 
		a.District = 'LA'	
END

GO
