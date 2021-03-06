USE [Data_Services]
GO
/****** Object:  StoredProcedure [dbo].[sp_4a_Staff]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_4a_Staff]  @District varchar(255) = 'Standard'

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

if @District = 'Standard'
	BEGIN
	insert into Data_Services.dbo.Master_Staff(TeacherName, First_Name, Last_Name, SchoolForce__Organization__c, SchoolForce__Individual__c, SF_ID, [SchoolForce__External_Id__c])
	select distinct 
	Teacher_Name TeacherName,
	substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) First_Name,
	substring(Teacher_Name, 0, charindex(',', Teacher_Name)) Last_Name, 
	c.Account_ID SchoolForce__Organization__c,
	d.ID SchoolForce__Individual__c,
	f.ID SF_ID,
	replace(a.District + '_' + School_ID + '_' + substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) + '_' + substring(Teacher_Name, 0, charindex(',', Teacher_Name)), ' ', '_') [SchoolForce__External_Id__c]
	from Data_Services.dbo.Class (nolock) a
	inner join Data_Services.dbo.Student (nolock) b on a.Student_ID = b.Student_ID
	inner join Data_Services.dbo.School_Lookup (nolock) c on b.School_Name = c.Source_School_Name
	inner join SDW_Stage_Prod.dbo.Contact (nolock) d on replace(a.District + '_' + School_ID + '_' + substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) + '_' + substring(Teacher_Name, 0, charindex(',', Teacher_Name)), ' ', '_') = d.ID__c
	inner join SDW_Stage_Prod.dbo.Staff__c (nolock) f on replace(a.District + '_' + School_ID + '_' + substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) + '_' + substring(Teacher_Name, 0, charindex(',', Teacher_Name)), ' ', '_') = f.[External_Id__c]
	left outer join Data_Services.dbo.Master_Staff (nolock) e on replace(a.District + '_' + School_ID + '_' + substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) + '_' + substring(Teacher_Name, 0, charindex(',', Teacher_Name)), ' ', '_') = e.[SchoolForce__External_Id__c]
	where e.[SchoolForce__External_Id__c] is null
	END

If @District = 'KCPS'
	BEGIN
	insert into Data_Services.dbo.Master_Staff(TeacherName
	, First_Name
	, Last_Name
	, SchoolForce__Organization__c
	, SchoolForce__Individual__c
	, SF_ID
	, [SchoolForce__External_Id__c])

	select distinct 
	Teacher_Name TeacherName,
	LEFT(a.Teacher_Name, charindex(' ', a.Teacher_Name)- 1) First_Name,
	substring(a.Teacher_Name, charindex(' ', a.Teacher_Name) + 1, len(a.Teacher_Name) - charindex('_', a.Teacher_Name)) Last_Name, 
	c.Account_ID SchoolForce__Organization__c,
	d.ID SchoolForce__Individual__c,
	f.ID SF_ID,
	replace(a.District + '_' + School_ID + '_' + LEFT(a.Teacher_Name, charindex(' ', a.Teacher_Name)- 1) + '_' + substring(a.Teacher_Name, charindex(' ', a.Teacher_Name) + 1, len(a.Teacher_Name) - charindex('_', a.Teacher_Name)), ' ', '_') [SchoolForce__External_Id__c]
	
	from Data_Services.dbo.Class (nolock) a
	inner join Data_Services.dbo.Student (nolock) b on a.Student_ID = b.Student_ID
	inner join Data_Services.dbo.School_Lookup_16_17 (nolock) c on b.School_Name = c.Source_School_Name
	inner join sdw_stage_prod_17.dbo.Contact (nolock) d on replace(a.District + '_' + School_ID + '_' + LEFT(a.Teacher_Name, charindex(' ', a.Teacher_Name)- 1) + '_' + substring(a.Teacher_Name, charindex(' ', a.Teacher_Name) + 1, len(a.Teacher_Name) - charindex('_', a.Teacher_Name)), ' ', '_') = d.ID__c
	inner join sdw_stage_prod_17.dbo.Staff__c (nolock) f on replace(a.District + '_' + School_ID + '_' + LEFT(a.Teacher_Name, charindex(' ', a.Teacher_Name)- 1) + '_' + substring(a.Teacher_Name, charindex(' ', a.Teacher_Name) + 1, len(a.Teacher_Name) - charindex('_', a.Teacher_Name)), ' ', '_') = f.[External_Id__c]
	left outer join Data_Services.dbo.Master_Staff (nolock) e on replace(a.District + '_' + School_ID + '_' + LEFT(a.Teacher_Name, charindex(' ', a.Teacher_Name)- 1) + '_' + substring(a.Teacher_Name, charindex(' ', a.Teacher_Name) + 1, len(a.Teacher_Name) - charindex('_', a.Teacher_Name)), ' ', '_') = e.[SchoolForce__External_Id__c]
	where e.[SchoolForce__External_Id__c] is null and a.District = 'KCPS'
	END
If @District = '1STLN'
BEGIN
		INSERT INTO Data_Services.dbo.Master_Staff(TeacherName
		, First_Name
		, Last_Name
		, SchoolForce__Organization__c
		, SchoolForce__Individual__c
		, SF_ID
		, [SchoolForce__External_Id__c]
		)
	SELECT DISTINCT Teacher_Name TeacherName
	, SUBSTRING(Teacher_Name, CHARINDEX(',', Teacher_Name) + 2, LEN(Teacher_Name) - CHARINDEX(',', Teacher_Name) - 1) First_Name
	, SUBSTRING(Teacher_Name, 0, CHARINDEX(',', Teacher_Name)) Last_Name
	, c.Account_ID SchoolForce__Organization__c
	, d.ID SchoolForce__Individual__c
	, f.ID SF_ID
	, REPLACE(a.District + '_' + b.School_ID + '_' + SUBSTRING(Teacher_Name, CHARINDEX(',', Teacher_Name) + 2, LEN(Teacher_Name) - CHARINDEX(',', Teacher_Name) - 1) + '_' + SUBSTRING(Teacher_Name, 0, CHARINDEX(',', Teacher_Name)), ' ', '_') [SchoolForce__External_Id__c]
	FROM Data_Services.dbo.Class (NOLOCK) a INNER JOIN 
	Data_Services.dbo.Student (NOLOCK) b ON 
		a.Student_ID = b.Student_ID INNER JOIN 
	Data_Services.dbo.School_Lookup_16_17 (NOLOCK) c ON 
		b.School_Name = c.Source_School_Name INNER JOIN
	SDW_Stage_PROD_17.dbo.Contact (NOLOCK) d ON 
		REPLACE(a.District + '_' + School_ID + '_' +   SUBSTRING(Teacher_Name, 0, CHARINDEX(',', Teacher_Name))+ '_' +SUBSTRING(Teacher_Name, CHARINDEX(',', Teacher_Name) + 2, LEN(Teacher_Name) - CHARINDEX(',', Teacher_Name) - 1), ' ', '_') = d.ID__c inner JOIN
	SDW_Stage_PROD_17.dbo.Staff__c (NOLOCK) f ON 
		REPLACE(a.District + '_' + School_ID + '_' + SUBSTRING(Teacher_Name, CHARINDEX(',', Teacher_Name) + 2, LEN(Teacher_Name) - CHARINDEX(',', Teacher_Name) - 1) + '_' + SUBSTRING(Teacher_Name, 0, CHARINDEX(',', Teacher_Name)), ' ', '_') = f.[External_Id__c] LEFT OUTER JOIN
	Data_Services.dbo.Master_Staff (NOLOCK) e ON REPLACE(a.District + '_' + School_ID + '_' + SUBSTRING(Teacher_Name, CHARINDEX(',', Teacher_Name) + 2, LEN(Teacher_Name) - CHARINDEX(',', Teacher_Name) - 1) + '_' + SUBSTRING(Teacher_Name, 0, CHARINDEX(',', Teacher_Name)), ' ', '_') = e.[SchoolForce__External_Id__c]
	
	WHERE --a.District = '1STLN' AND
	e.[SchoolForce__External_Id__c] IS NULL 
END
If @District = 'LRA'
BEGIN
		INSERT INTO Data_Services.dbo.Master_Staff(TeacherName
		, First_Name
		, Last_Name
		, SchoolForce__Organization__c
		, SchoolForce__Individual__c
		, SF_ID
		, [SchoolForce__External_Id__c]
		)
	SELECT DISTINCT a.Teacher_Name TeacherName
	, SUBSTRING(a.Teacher_Name, 0, CHARINDEX(' ', a.Teacher_Name)) First_Name
	, SUBSTRING(a.Teacher_Name, CHARINDEX(' ', a.Teacher_Name) + 1, LEN(a.Teacher_Name) - CHARINDEX(' ', a.Teacher_Name)) Last_Name
	, c.Account_ID SchoolForce__Organization__c
	, d.ID SchoolForce__Individual__c
	, f.ID SF_ID
	, REPLACE(a.District + '_' + School_ID + '_' + /*First_Name*/ SUBSTRING(a.Teacher_Name, 0, CHARINDEX(' ', a.Teacher_Name)) + '_' + /*Last_Name*/ SUBSTRING(a.Teacher_Name, CHARINDEX(' ', a.Teacher_Name) + 1, LEN(a.Teacher_Name) - CHARINDEX(' ', a.Teacher_Name)), ' ', '_') [SchoolForce__External_Id__c]
	FROM Data_Services.dbo.Class (NOLOCK) a INNER JOIN 
	Data_Services.dbo.Student (NOLOCK) b ON 
		a.Student_ID = b.Student_ID INNER JOIN 
	Data_Services.dbo.School_Lookup_16_17 (NOLOCK) c ON 
		b.School_Name = c.Source_School_Name INNER JOIN 
	SDW_Stage_PROD_17.dbo.Contact (NOLOCK) d ON 
		REPLACE(a.District + '_' + School_ID + '_' +/*Last_Name*/SUBSTRING(a.Teacher_Name, CHARINDEX(' ', a.Teacher_Name) + 1, LEN(a.Teacher_Name) - CHARINDEX(' ', a.Teacher_Name))  + '_' + /*First_Name*/ SUBSTRING(a.Teacher_Name, 0, CHARINDEX(' ', a.Teacher_Name)) , ' ', '_') = d.ID__c INNER JOIN
	SDW_Stage_PROD_17.dbo.Staff__c (NOLOCK) f ON 
		REPLACE(a.District + '_' + School_ID + '_' + /*First_Name*/ SUBSTRING(a.Teacher_Name, 0, CHARINDEX(' ', a.Teacher_Name)) + '_' + /*Last_Name*/ SUBSTRING(a.Teacher_Name, CHARINDEX(' ', a.Teacher_Name) + 1, LEN(a.Teacher_Name) - CHARINDEX(' ', a.Teacher_Name)), ' ', '_') = f.[External_Id__c] LEFT OUTER JOIN 
	Data_Services.dbo.Master_Staff (NOLOCK) e ON 
		REPLACE(a.District + '_' + School_ID + '_' + /*First_Name*/ SUBSTRING(a.Teacher_Name, 0, CHARINDEX(' ', a.Teacher_Name)) + '_' + /*Last_Name*/ SUBSTRING(a.Teacher_Name, CHARINDEX(' ', a.Teacher_Name) + 1, LEN(a.Teacher_Name) - CHARINDEX(' ', a.Teacher_Name)), ' ', '_') = e.[SchoolForce__External_Id__c]
	WHERE e.[SchoolForce__External_Id__c] IS NULL AND 
	a.District = 'LRA'
END
IF @District = 'SJ'
BEGIN

	
	insert into Data_Services.dbo.Master_Staff(TeacherName, First_Name, Last_Name, SchoolForce__Organization__c, SchoolForce__Individual__c, SF_ID, [SchoolForce__External_Id__c])
	select distinct 
	Teacher_Name TeacherName,
	substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) First_Name,
	substring(Teacher_Name, 0, charindex(',', Teacher_Name)) Last_Name, 
	c.Account_ID SchoolForce__Organization__c,
	d.ID SchoolForce__Individual__c,
	f.ID SF_ID,
	replace(a.District + '_' + School_ID + '_' + substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) + '_' + substring(Teacher_Name, 0, charindex(',', Teacher_Name)), ' ', '_') [SchoolForce__External_Id__c]
	from Data_Services.dbo.Class (nolock) a
	inner join Data_Services.dbo.Student (nolock) b on a.Student_ID = b.Student_ID
	inner join Data_Services.dbo.School_Lookup_16_17 (nolock) c on b.School_Name = c.Source_School_Name and b.school_id = c.source_school_id
	inner join sdw_stage_prod_17.dbo.Contact (nolock) d on replace(a.District + '_' + School_ID + '_' + substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) + '_' + substring(Teacher_Name, 0, charindex(',', Teacher_Name)), ' ', '_') = d.ID__c
	inner join sdw_stage_prod_17.dbo.Staff__c (nolock) f on replace(a.District + '_' + School_ID + '_' + substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) + '_' + substring(Teacher_Name, 0, charindex(',', Teacher_Name)), ' ', '_') = f.[External_Id__c]
	left outer join Data_Services.dbo.Master_Staff (nolock) e on replace(a.District + '_' + School_ID + '_' + substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) + '_' + substring(Teacher_Name, 0, charindex(',', Teacher_Name)), ' ', '_') = e.[SchoolForce__External_Id__c]
	where e.[SchoolForce__External_Id__c] is null and a.District = 'sj'


END
IF @District = 'MKE'
BEGIN

	
	insert into Data_Services.dbo.Master_Staff(TeacherName, First_Name, Last_Name, SchoolForce__Organization__c, SchoolForce__Individual__c, SF_ID, [SchoolForce__External_Id__c])
	select distinct 
	LTRIM(RTRIM(SUBSTRING(Teacher_Name, 0, CHARINDEX(' ', Teacher_Name)))) + ' ' + LTRIM(RTRIM(SUBSTRING(Teacher_Name, CHARINDEX(' ', Teacher_Name)+1, 8000))) Teacher_name,
    LTRIM(RTRIM(SUBSTRING(Teacher_Name, 0, CHARINDEX(' ', Teacher_Name)))) First_Name,
	LTRIM(RTRIM(SUBSTRING(Teacher_Name, CHARINDEX(' ', Teacher_Name)+1, 8000))) Last_Name, 
	c.Account_ID SchoolForce__Organization__c,
	d.ID SchoolForce__Individual__c,
	f.ID SF_ID,
	replace(a.District + '_' + School_ID + '_' +LTRIM(RTRIM(SUBSTRING(Teacher_Name, CHARINDEX(' ', Teacher_Name)+1, 8000)))  + '_' + LTRIM(RTRIM(SUBSTRING(Teacher_Name, 0, CHARINDEX(' ', Teacher_Name)))), ' ', '_') [SchoolForce__External_Id__c]
	from Data_Services.dbo.Class (nolock) a
	inner join Data_Services.dbo.Student (nolock) b on a.Student_ID = b.Student_ID
	inner join Data_Services.dbo.School_Lookup_16_17 (nolock) c on b.School_Name = c.Source_School_Name
	inner join sdw_stage_prod_17.dbo.Contact (nolock) d on replace(a.District + '_' + School_ID + '_' +LTRIM(RTRIM(SUBSTRING(Teacher_Name, CHARINDEX(' ', Teacher_Name)+1, 8000)))  + '_' + LTRIM(RTRIM(SUBSTRING(Teacher_Name, 0, CHARINDEX(' ', Teacher_Name)))), ' ', '_') = d.ID__c
	inner join sdw_stage_prod_17.dbo.Staff__c (nolock) f on replace(a.District + '_' + School_ID + '_' +LTRIM(RTRIM(SUBSTRING(Teacher_Name, CHARINDEX(' ', Teacher_Name)+1, 8000)))  + '_' + LTRIM(RTRIM(SUBSTRING(Teacher_Name, 0, CHARINDEX(' ', Teacher_Name)))), ' ', '_') = f.[External_Id__c]
	left outer join Data_Services.dbo.Master_Staff (nolock) e on replace(a.District + '_' + School_ID + '_' +LTRIM(RTRIM(SUBSTRING(Teacher_Name, CHARINDEX(' ', Teacher_Name)+1, 8000)))  + '_' + LTRIM(RTRIM(SUBSTRING(Teacher_Name, 0, CHARINDEX(' ', Teacher_Name)))), ' ', '_') = e.[SchoolForce__External_Id__c]
	where e.[SchoolForce__External_Id__c] is null and a.District = 'MKE'

	update Data_Services.dbo.Master_Staff set first_name = last_name where first_name = ''

END
If @District = 'LA'
BEGIN
INSERT INTO Data_Services.dbo.Master_Staff(TeacherName
		, First_Name
		, Last_Name
		, SchoolForce__Organization__c
		, SchoolForce__Individual__c
		, SF_ID
		, [SchoolForce__External_Id__c]
		)
	SELECT DISTINCT Teacher_Name
		TeacherName
		, SUBSTRING(Teacher_Name, CHARINDEX(',', Teacher_Name) + 2, LEN(Teacher_Name) - CHARINDEX(',', Teacher_Name) - 1) First_Name
		, SUBSTRING(Teacher_Name, 0, CHARINDEX(',', Teacher_Name)) Last_Name
		, c.Account_ID SchoolForce__Organization__c
		, d.ID SchoolForce__Individual__c
		, f.ID SF_ID
		, REPLACE(a.District + '_' + School_ID + '_' + SUBSTRING(Teacher_Name, CHARINDEX(',', Teacher_Name) + 2, LEN(Teacher_Name) - CHARINDEX(',', Teacher_Name) - 1) + '_' + SUBSTRING(Teacher_Name, 0, CHARINDEX(',', Teacher_Name)), ' ', '_') [SchoolForce__External_Id__c]
	FROM Data_Services.dbo.Class (NOLOCK) a INNER JOIN 
	Data_Services.dbo.Student (NOLOCK) b ON 
		a.Student_ID = b.Student_ID INNER JOIN 
	Data_Services.dbo.School_Lookup_16_17 (NOLOCK) c on b.School_Name = c.Source_School_Name INNER JOIN 
	SDW_Stage_Prod_17.dbo.Contact (NOLOCK) d ON 
		REPLACE(a.District + '_' + School_ID + '_' + SUBSTRING(Teacher_Name, CHARINDEX(',', Teacher_Name) + 2, LEN(Teacher_Name) - CHARINDEX(',', Teacher_Name) - 1) + '_' + SUBSTRING(Teacher_Name, 0, CHARINDEX(',', Teacher_Name)), ' ', '_') = d.ID__c INNER JOIN 
	SDW_Stage_Prod_17.dbo.Staff__c (NOLOCK) f ON 
		REPLACE(a.District + '_' + School_ID + '_' + SUBSTRING(Teacher_Name, CHARINDEX(',', Teacher_Name) + 2, LEN(Teacher_Name) - CHARINDEX(',', Teacher_Name) - 1) + '_' + SUBSTRING(Teacher_Name, 0, CHARINDEX(',', Teacher_Name)), ' ', '_') = f.[External_Id__c] LEFT OUTER JOIN 
	Data_Services.dbo.Master_Staff (NOLOCK) e ON 
		REPLACE(a.District + '_' + School_ID + '_' + SUBSTRING(Teacher_Name, CHARINDEX(',', Teacher_Name) + 2, LEN(Teacher_Name) - CHARINDEX(',', Teacher_Name) - 1) + '_' + SUBSTRING(Teacher_Name, 0, CHARINDEX(',', Teacher_Name)), ' ', '_') = e.[SchoolForce__External_Id__c]
	WHERE e.[SchoolForce__External_Id__c] IS NULL AND a.District = 'LA'
	END
IF @District = 'CLM'
BEGIN

	
	insert into Data_Services.dbo.Master_Staff(TeacherName, First_Name, Last_Name, SchoolForce__Organization__c, SchoolForce__Individual__c, SF_ID, [SchoolForce__External_Id__c])
	select distinct 
	Teacher_Name TeacherName,
	substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) First_Name,
	substring(Teacher_Name, 0, charindex(',', Teacher_Name)) Last_Name, 
	c.Account_ID SchoolForce__Organization__c,
	d.ID SchoolForce__Individual__c,
	f.ID SF_ID,
	replace(a.District + '_' + School_ID + '_' + substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) + '_' + substring(Teacher_Name, 0, charindex(',', Teacher_Name)), ' ', '_') [SchoolForce__External_Id__c]
	from Data_Services.dbo.Class (nolock) a
	inner join Data_Services.dbo.Student (nolock) b on a.Student_ID = b.Student_ID
	inner join Data_Services.dbo.School_Lookup_16_17 (nolock) c on b.School_Name = c.Source_School_Name and b.school_id = c.source_school_id
	inner join sdw_stage_prod_17.dbo.Contact (nolock) d on replace(a.District + '_' + School_ID + '_' + substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) + '_' + substring(Teacher_Name, 0, charindex(',', Teacher_Name)), ' ', '_') = d.ID__c
	inner join sdw_stage_prod_17.dbo.Staff__c (nolock) f on replace(a.District + '_' + School_ID + '_' + substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) + '_' + substring(Teacher_Name, 0, charindex(',', Teacher_Name)), ' ', '_') = f.[External_Id__c]
	left outer join Data_Services.dbo.Master_Staff (nolock) e on replace(a.District + '_' + School_ID + '_' + substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) + '_' + substring(Teacher_Name, 0, charindex(',', Teacher_Name)), ' ', '_') = e.[SchoolForce__External_Id__c]
	where e.[SchoolForce__External_Id__c] is null and a.District = 'CLM'


END
END


GO
