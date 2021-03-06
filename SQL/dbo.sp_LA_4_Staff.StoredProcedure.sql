USE [Data_Services]
GO
/****** Object:  StoredProcedure [dbo].[sp_LA_4_Staff]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_LA_4_Staff]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM Data_Services.dbo.SF_Staff  WHERE [SchoolForce__External_Id__c] LIKE 'LA_%'

	INSERT INTO Data_Services.dbo.SF_Staff([SchoolForce__First_Name_Staff__c]
		, [SchoolForce__Staff_Last_Name__c]
		, [SchoolForce__Organization__c]
		, SchoolForce__Active__c
		, [SchoolForce__Individual__c]
		, [SchoolForce__External_Id__c])
	
	SELECT DISTINCT SUBSTRING(Teacher_Name, CHARINDEX(',', Teacher_Name) + 2, len(Teacher_Name) - CHARINDEX(',', Teacher_Name) - 1) AS SchoolForce__First_Name_Staff__c
	,SUBSTRING(Teacher_Name, 0, CHARINDEX(',', Teacher_Name))  AS SchoolForce__Staff_Last_Name__c
	, c.Account_ID AS SchoolForce__Organization__c
	, 0 AS SchoolForce__Active__c
	,d.ID AS SchoolForce__Individual__c
	,REPLACE(a.District + '_' + School_ID + '_' + SUBSTRING(Teacher_Name, CHARINDEX(',', Teacher_Name) + 2, len(Teacher_Name) - CHARINDEX(',', Teacher_Name) - 1) + '_' + SUBSTRING(Teacher_Name, 0, CHARINDEX(',', Teacher_Name)), ' ', '_') AS SchoolForce__ID__c
	
	FROM Data_Services.dbo.Class (NOLOCK) a INNER JOIN 
	Data_Services.dbo.Student (NOLOCK) b ON 
		a.Student_ID = b.Student_ID INNER JOIN 
	Data_Services.dbo.School_Lookup_16_17 (NOLOCK) c ON 
		b.School_Name = c.Source_School_Name INNER JOIN 
	SDW_Stage_Prod_17.dbo.Contact (NOLOCK) d ON 
		REPLACE(a.District + '_' + School_ID + '_' + SUBSTRING(Teacher_Name, CHARINDEX(',', Teacher_Name) + 2, LEN(Teacher_Name) - CHARINDEX(',', Teacher_Name) - 1) + '_' + SUBSTRING(Teacher_Name, 0, CHARINDEX(',', Teacher_Name)), ' ', '_') = d.ID__c LEFT OUTER JOIN 
	Data_Services.dbo.Master_Staff (nolock) e ON 
		REPLACE(a.District + '_' + School_ID + '_' + SUBSTRING(Teacher_Name, CHARINDEX(',', Teacher_Name) + 2, LEN(Teacher_Name) - CHARINDEX(',', Teacher_Name) - 1) + '_' + SUBSTRING(Teacher_Name, 0, CHARINDEX(',', Teacher_Name)), ' ', '_') = e.[SchoolForce__External_Id__c]
	WHERE e.[SchoolForce__External_Id__c] IS NULL AND
	a.District = 'LA'

END


GO
