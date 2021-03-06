USE [Data_Services]
GO
/****** Object:  StoredProcedure [dbo].[sp_4_Staff]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_4_Staff] @District varchar(255) = 'Standard'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--TRUNCATE TABLE Data_Services.dbo.SF_Staff
	--truncate table Data_Services.dbo.Master_Staff

if @District = 'OCPS'
	BEGIN

	
	Delete FROM Data_Services.dbo.SF_Staff where LEFT (SchoolForce__External_Id__c, 5) = 'OCPS_'

	INSERT INTO Data_Services.dbo.SF_Staff([SchoolForce__First_Name_Staff__c]
	, [SchoolForce__Staff_Last_Name__c]
	, [SchoolForce__Organization__c]
	, SchoolForce__Active__c
	,[SchoolForce__Individual__c]
	, [SchoolForce__External_Id__c])
	SELECT DISTINCT substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) AS SchoolForce__First_Name_Staff__c
	, substring(Teacher_Name, 0, charindex(',', Teacher_Name)) AS SchoolForce__Staff_Last_Name__c
	, c.Account_ID AS SchoolForce__Organization__c
	, 0 AS SchoolForce__Active__c
	, d.ID AS SchoolForce__Individual__c
	, replace(a.District + '_' + School_ID + '_' + substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) + '_' + substring(Teacher_Name, 0, charindex(',', Teacher_Name)), ' ', '_') AS SchoolForce__ID__c
	FROM Data_Services.dbo.Class (nolock) a INNER JOIN 
	Data_Services.dbo.Student (nolock) b ON 
		a.Student_ID = b.Student_ID INNER JOIN 
	Data_Services.dbo.School_Lookup (nolock) c ON 
		b.School_Name = c.Source_School_Name INNER JOIN 
	SDW_Stage_Prod.dbo.Contact (nolock) d ON 
		replace(a.District + '_' + School_ID + '_' + substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) + '_' + substring(Teacher_Name, 0, charindex(',', Teacher_Name)), ' ', '_') = d.ID__c LEFT OUTER JOIN 
	Data_Services.dbo.Master_Staff (nolock) e on replace(a.District + '_' + School_ID + '_' + substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) + '_' + substring(Teacher_Name, 0, charindex(',', Teacher_Name)), ' ', '_') = e.[SchoolForce__External_Id__c]
	WHERE e.[SchoolForce__External_Id__c] is null and a.District = 'OCPS'
	END

IF @District = 'KCPS'
BEGIN
	Delete FROM Data_Services.dbo.SF_Staff where LEFT (SchoolForce__External_Id__c, 5) = 'KCPS_'
	--clear district staff from sf_staff

	INSERT INTO Data_Services.dbo.SF_Staff([SchoolForce__First_Name_Staff__c]
	, [SchoolForce__Staff_Last_Name__c]
	, [SchoolForce__Organization__c]
	, SchoolForce__Active__c
	, [SchoolForce__Individual__c]
	, [SchoolForce__External_Id__c])

	SELECT DISTINCT LEFT(a.Teacher_Name, charindex(' ', a.Teacher_Name)- 1) AS SchoolForce__First_Name_Staff__c
	, substring(a.Teacher_Name, charindex(' ', a.Teacher_Name) + 1, len(a.Teacher_Name) - charindex('_', a.Teacher_Name)) AS SchoolForce__Staff_Last_Name__c
	,c.Account_ID AS SchoolForce__Organization__c
	,0 AS SchoolForce__Active__c
	,d.ID SchoolForce__Individual__c
	,replace(a.District + '_' + School_ID + '_' + LEFT(a.Teacher_Name, charindex(' ', a.Teacher_Name)- 1) + '_' + substring(a.Teacher_Name, charindex(' ', a.Teacher_Name) + 1, len(a.Teacher_Name) - charindex('_', a.Teacher_Name)), ' ', '_') AS SchoolForce__ID__c
	
	FROM Data_Services.dbo.Class (nolock) a 
	INNER JOIN Data_Services.dbo.Student (nolock) b ON a.Student_ID = b.Student_ID 
	INNER JOIN Data_Services.dbo.School_Lookup_16_17 (nolock) c ON b.School_Name = Source_School_Name 
	INNER JOIN sdw_stage_prod_17.dbo.Contact (nolock) d ON 
		replace(a.District + '_' + School_ID + '_' + LEFT(a.Teacher_Name, charindex(' ', a.Teacher_Name)- 1) + '_' + substring(a.Teacher_Name, charindex(' ', a.Teacher_Name) + 1, len(a.Teacher_Name) - charindex('_', a.Teacher_Name)), ' ', '_') = d.ID__c 
	LEFT OUTER JOIN Data_Services.dbo.Master_Staff (nolock) e ON 
		replace(a.District + '_' + School_ID + '_' + LEFT(a.Teacher_Name, charindex(' ', a.Teacher_Name)- 1) + '_' + substring(a.Teacher_Name, charindex(' ', a.Teacher_Name) + 1, len(a.Teacher_Name) - charindex('_', a.Teacher_Name)), ' ', '_') = e.[SchoolForce__External_Id__c]
	WHERE e.[SchoolForce__External_Id__c] is null and a.District = 'KCPS' 
END 

IF @District = '1STLN'
BEGIN
Delete FROM Data_Services.dbo.SF_Staff where LEFT(SchoolForce__External_Id__c, 5) = @District

	INSERT INTO Data_Services.dbo.SF_Staff([SchoolForce__First_Name_Staff__c]
		, [SchoolForce__Staff_Last_Name__c]
		, [SchoolForce__Organization__c]
		, SchoolForce__Active__c
		,[SchoolForce__Individual__c]
		, [SchoolForce__External_Id__c]
	)
	
SELECT DISTINCT SUBSTRING(Teacher_Name, CHARINDEX(',', Teacher_Name) + 2, len(Teacher_Name) - CHARINDEX(',', Teacher_Name) - 1) AS SchoolForce__First_Name_Staff__c
		, SUBSTRING(Teacher_Name, 0, CHARINDEX(',', Teacher_Name)) AS SchoolForce__Staff_Last_Name__c
		, c.Account_ID AS SchoolForce__Organization__c
		, 0 AS SchoolForce__Active__c
		, d.ID AS SchoolForce__Individual__c
		, REPLACE(a.District + '_' + School_ID + '_' + substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) + '_' + substring(Teacher_Name, 0, charindex(',', Teacher_Name)), ' ', '_') AS SchoolForce__ID__c
		--, Replace(a.District + '_' + School_ID + '_' + SUBSTRING(a.Teacher_Name, 0, CHARINDEX(',', a.Teacher_Name)) + '_' + SUBSTRING(a.Teacher_Name, CHARINDEX(' ', a.Teacher_Name) + 1, LEN(a.Teacher_Name) - CHARINDEX('_', a.Teacher_Name)),' ','_') 
		 
	FROM Data_Services.dbo.Class (nolock) a INNER JOIN 
	Data_Services.dbo.Student (nolock) b ON 
		a.Student_ID = b.Student_ID INNER JOIN 
	Data_Services.dbo.School_Lookup_16_17 (nolock) c ON 
		b.School_Name = c.Source_School_Name INNER JOIN 
[SDW_Stage_Prod_17].[dbo].[Contact] d ON
Replace(a.District + '_' + School_ID + '_' + SUBSTRING(a.Teacher_Name, 0, CHARINDEX(',', a.Teacher_Name)) + '_' + SUBSTRING(a.Teacher_Name, CHARINDEX(' ', a.Teacher_Name) + 1, LEN(a.Teacher_Name) - CHARINDEX('_', a.Teacher_Name)),' ','_') = d.ID__c LEFT JOIN
--	(SELECT id,[ID__c],RecordTypeId
--FROM [SDW_Stage_Prod_17].[dbo].[Contact]
--WHERE ID__c like '1STLN_%' AND RecordTypeId ='012360000007jgMAAQ') d ON 
--		Replace(a.District + '_' + School_ID + '_' + SUBSTRING(a.Teacher_Name, 0, CHARINDEX(',', a.Teacher_Name)) + '_' + SUBSTRING(a.Teacher_Name, CHARINDEX(' ', a.Teacher_Name) + 1, LEN(a.Teacher_Name) - CHARINDEX('_', a.Teacher_Name)),' ','_') = d.ID__c LEFT JOIN
Data_Services.dbo.Master_Staff (nolock) e on
	 REPLACE(a.District + '_' + School_ID + '_' + substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) + '_' + substring(Teacher_Name, 0, charindex(',', Teacher_Name)), ' ', '_') = e.[SchoolForce__External_Id__c]
	WHERE e.[SchoolForce__External_Id__c] IS NULL AND
	a.District = '1STLN'

END
IF @District = 'LRA'
BEGIN
DELETE FROM Data_Services.dbo.SF_Staff WHERE LEFT(SchoolForce__External_Id__c, 3) = @District

INSERT INTO Data_Services.dbo.SF_Staff([SchoolForce__First_Name_Staff__c]
	, [SchoolForce__Staff_Last_Name__c]
	, [SchoolForce__Organization__c]
	, SchoolForce__Active__c
	, [SchoolForce__Individual__c]
	, [SchoolForce__External_Id__c]
	)
	
SELECT DISTINCT SUBSTRING(a.Teacher_Name, 0, CHARINDEX(' ', a.Teacher_Name)) AS SchoolForce__First_Name_Staff__c
		, SUBSTRING(a.Teacher_Name, CHARINDEX(' ', a.Teacher_Name) + 1, LEN(a.Teacher_Name) - CHARINDEX(' ', a.Teacher_Name)) AS SchoolForce__Staff_Last_Name__c
		, c.Account_ID AS SchoolForce__Organization__c
		, 0 AS SchoolForce__Active__c
		, d.ID AS SchoolForce__Individual__c
		, REPLACE(a.District + '_' + School_ID + '_' + /*FIRST_NAME*/ SUBSTRING(a.Teacher_Name, 0, CHARINDEX(' ', a.Teacher_Name)) + '_' + /*LAST_NAME*/ SUBSTRING(a.Teacher_Name, CHARINDEX(' ', a.Teacher_Name) + 1, LEN(a.Teacher_Name) - CHARINDEX(' ', a.Teacher_Name)), ' ', '_') AS SchoolForce__ID__c
		 
	FROM Data_Services.dbo.Class (NOLOCK) a INNER JOIN 
	Data_Services.dbo.Student (NOLOCK) b ON 
		a.Student_ID = b.Student_ID INNER JOIN 
	Data_Services.dbo.School_Lookup_16_17 (NOLOCK) c ON 
		b.School_Name = c.Source_School_Name INNER JOIN 
	SDW_Stage_Prod_17.dbo.Contact d ON
		REPLACE(a.District + '_' + School_ID + '_' + /*LAST_NAME*/ SUBSTRING(a.Teacher_Name, CHARINDEX(' ', a.Teacher_Name) + 1, LEN(a.Teacher_Name) - CHARINDEX(' ', a.Teacher_Name)) + '_' + /*FIRST_NAME*/ SUBSTRING(a.Teacher_Name, 0, CHARINDEX(' ', a.Teacher_Name)),' ','_') = d.ID__c LEFT JOIN
	Data_Services.dbo.Master_Staff (NOLOCK) e ON
		REPLACE(a.District + '_' + School_ID + '_' + /*FIRST_NAME*/  + '_' + /*LAST_NAME*/ SUBSTRING(Teacher_Name, 0, CHARINDEX(',', Teacher_Name)), ' ', '_') = e.[SchoolForce__External_Id__c]
	WHERE e.[SchoolForce__External_Id__c] IS NULL AND
	a.District = 'LRA'
END

IF @District = 'SJ'
BEGIN
	
	Delete FROM Data_Services.dbo.SF_Staff where LEFT (SchoolForce__External_Id__c, 3) = 'SJ_'
	--truncate table Data_Services.dbo.Master_Staff

	insert into Data_Services.dbo.SF_Staff([SchoolForce__First_Name_Staff__c], [SchoolForce__Staff_Last_Name__c], [SchoolForce__Organization__c], SchoolForce__Active__c,
	[SchoolForce__Individual__c], [SchoolForce__External_Id__c])
	select distinct 
	substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) SchoolForce__First_Name_Staff__c,
	substring(Teacher_Name, 0, charindex(',', Teacher_Name)) SchoolForce__Staff_Last_Name__c, 
	c.Account_ID SchoolForce__Organization__c,
	1 SchoolForce__Active__c,
	d.ID SchoolForce__Individual__c,
	replace(a.District + '_' + School_ID + '_' + substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) + '_' + substring(Teacher_Name, 0, charindex(',', Teacher_Name)), ' ', '_') SchoolForce__ID__c
	from Data_Services.dbo.Class (nolock) a
	inner join Data_Services.dbo.Student (nolock) b on a.Student_ID = b.Student_ID 
	inner join Data_Services.dbo.School_Lookup_16_17 (nolock) c on b.School_Name = c.Source_School_Name and b.school_id = c.source_school_id
	inner join sdw_stage_prod_17.dbo.Contact (nolock) d on replace(a.District + '_' + School_ID + '_' + substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) + '_' + substring(Teacher_Name, 0, charindex(',', Teacher_Name)), ' ', '_') = d.ID__c
	left outer join Data_Services.dbo.Master_Staff (nolock) e on replace(a.District + '_' + School_ID + '_' + substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) + '_' + substring(Teacher_Name, 0, charindex(',', Teacher_Name)), ' ', '_') = e.[SchoolForce__External_Id__c]
	where e.[SchoolForce__External_Id__c] is null and a.District = 'SJ'
END
IF @District = 'MKE'
BEGIN
	
	Delete FROM Data_Services.dbo.SF_Staff where LEFT (SchoolForce__External_Id__c, 4) = 'MKE_'
	--truncate table Data_Services.dbo.Master_Staff

	insert into Data_Services.dbo.SF_Staff([SchoolForce__First_Name_Staff__c], [SchoolForce__Staff_Last_Name__c], [SchoolForce__Organization__c], SchoolForce__Active__c,
	[SchoolForce__Individual__c], [SchoolForce__External_Id__c])
	select distinct 
	LTRIM(RTRIM(SUBSTRING(Teacher_Name, 0, CHARINDEX(' ', Teacher_Name)))) SchoolForce__First_Name_Staff__c,
	LTRIM(RTRIM(SUBSTRING(Teacher_Name, CHARINDEX(' ', Teacher_Name)+1, 8000))) SchoolForce__Staff_Last_Name__c, 
	c.Account_ID SchoolForce__Organization__c,
	1 SchoolForce__Active__c,
	d.ID SchoolForce__Individual__c,
	replace(a.District + '_' + School_ID + '_' +LTRIM(RTRIM(SUBSTRING(Teacher_Name, CHARINDEX(' ', Teacher_Name)+1, 8000)))  + '_' + LTRIM(RTRIM(SUBSTRING(Teacher_Name, 0, CHARINDEX(' ', Teacher_Name)))), ' ', '_') SchoolForce__ID__c
	from Data_Services.dbo.Class (nolock) a
	inner join Data_Services.dbo.Student (nolock) b on a.Student_ID = b.Student_ID
	inner join Data_Services.dbo.School_Lookup_16_17 (nolock) c on b.School_Name = c.Source_School_Name and b.school_id = c.source_school_id
	inner join sdw_stage_prod_17.dbo.Contact (nolock) d on replace(a.District + '_' + School_ID + '_' +LTRIM(RTRIM(SUBSTRING(Teacher_Name, CHARINDEX(' ', Teacher_Name)+1, 8000)))  + '_' + LTRIM(RTRIM(SUBSTRING(Teacher_Name, 0, CHARINDEX(' ', Teacher_Name)))), ' ', '_') = d.ID__c
	left outer join Data_Services.dbo.Master_Staff (nolock) e on replace(a.District + '_' + School_ID + '_' +LTRIM(RTRIM(SUBSTRING(Teacher_Name, CHARINDEX(' ', Teacher_Name)+1, 8000)))  + '_' + LTRIM(RTRIM(SUBSTRING(Teacher_Name, 0, CHARINDEX(' ', Teacher_Name)))), ' ', '_') = e.[SchoolForce__External_Id__c]
	where e.[SchoolForce__External_Id__c] is null and a.District = 'MKE'

	update Data_Services.dbo.SF_Staff set SchoolForce__First_Name_Staff__c = SchoolForce__Staff_Last_Name__c where SchoolForce__First_Name_Staff__c = '' and [SchoolForce__External_Id__c] like 'mke%'
END
IF @District = 'CLM'
BEGIN
	
	Delete FROM Data_Services.dbo.SF_Staff where LEFT (SchoolForce__External_Id__c, 4) = 'CLM_'
	--truncate table Data_Services.dbo.Master_Staff

	insert into Data_Services.dbo.SF_Staff([SchoolForce__First_Name_Staff__c], [SchoolForce__Staff_Last_Name__c], [SchoolForce__Organization__c], SchoolForce__Active__c,
	[SchoolForce__Individual__c], [SchoolForce__External_Id__c])
	select distinct 
	substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) SchoolForce__First_Name_Staff__c,
	substring(Teacher_Name, 0, charindex(',', Teacher_Name)) SchoolForce__Staff_Last_Name__c, 
	c.Account_ID SchoolForce__Organization__c,
	1 SchoolForce__Active__c,
	d.ID SchoolForce__Individual__c,
	replace(a.District + '_' + School_ID + '_' + substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) + '_' + substring(Teacher_Name, 0, charindex(',', Teacher_Name)), ' ', '_') SchoolForce__ID__c
	from Data_Services.dbo.Class (nolock) a
	inner join Data_Services.dbo.Student (nolock) b on a.Student_ID = b.Student_ID 
	inner join Data_Services.dbo.School_Lookup_16_17 (nolock) c on b.School_Name = c.Source_School_Name and b.school_id = c.source_school_id
	inner join sdw_stage_prod_17.dbo.Contact (nolock) d on replace(a.District + '_' + School_ID + '_' + substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) + '_' + substring(Teacher_Name, 0, charindex(',', Teacher_Name)), ' ', '_') = d.ID__c
	left outer join Data_Services.dbo.Master_Staff (nolock) e on replace(a.District + '_' + School_ID + '_' + substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) + '_' + substring(Teacher_Name, 0, charindex(',', Teacher_Name)), ' ', '_') = e.[SchoolForce__External_Id__c]
	where e.[SchoolForce__External_Id__c] is null and a.District = 'CLM'
END
END




GO
