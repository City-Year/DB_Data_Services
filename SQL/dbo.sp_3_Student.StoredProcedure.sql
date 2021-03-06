USE [Data_Services]
GO
/****** Object:  StoredProcedure [dbo].[sp_3_Student]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_3_Student] @District varchar(255) = 'Standard'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- truncate table Data_Services.dbo.Master_Student

if @District = 'OCPS' OR @District = 'KCPS'
	BEGIN

	
	truncate table Data_Services.dbo.SF_Student

	INSERT INTO Data_Services.dbo.SF_Student(SchoolForce__Student_Last_Name__c
		, SchoolForce__Student_First_Name__c
		, SchoolForce__Grade__c
		, SchoolForce__School__c
		, SchoolForce__Year__c
		, SchoolForce__Active__c
		, SchoolForce__Individual__c
		, [SchoolForce__External_Id__c]
		, [SchoolForce__Setup__c]
		, [Student_ID]
	)

	SELECT a.Last_Name SchoolForce__Student_Last_Name__c
		, a.First_Name SchoolForce__Student_First_Name__c
		, CAST(a.Grade AS INTEGER) SchoolForce__Grade__c
		, b.Account_ID SchoolForce__School__c
		, a.School_Year SchoolForce__Year__c
		, 1 SchoolForce__Active__c
		, c.Id SchoolForce__Individual__c
		, a.District + '_' + CAST(CAST(a.School_ID AS INTEGER) AS VARCHAR(10)) + '_' + a.Student_ID [SchoolForce__External_Id__c]
		, b.Setup_14_15 [SchoolForce__Setup__c]
		, a.Student_ID

	FROM Data_Services.dbo.Student (NOLOCK) a INNER JOIN 
	Data_Services.dbo.School_Lookup (NOLOCK) b ON 
		a.School_Name = b.Source_School_Name INNER JOIN 
	SDW_Stage_PROD.dbo.Contact (NOLOCK) c ON 
		a.District + '_' + CAST(CAST(a.School_ID AS INTEGER) AS VARCHAR(10)) + '_' + a.Student_ID = c.ID__c LEFT OUTER JOIN 
	Data_Services.dbo.Master_Student (NOLOCK) d on a.District + '_' + CAST(CAST(a.School_ID AS INTEGER) AS VARCHAR(10)) + '_' + a.Student_ID = d.[SchoolForce__External_Id__c]
	
	WHERE d.[SchoolForce__External_Id__c] IS NULL 
		AND a.District = @District

	END

IF @District = '1STLN'
	
	BEGIN	

	
	truncate table Data_Services.dbo.SF_Student

	INSERT INTO Data_Services.dbo.SF_Student(SchoolForce__Student_Last_Name__c
		, SchoolForce__Student_First_Name__c
		, SchoolForce__Grade__c
		, SchoolForce__School__c
		, SchoolForce__Year__c
		, SchoolForce__Active__c
		, SchoolForce__Individual__c
		, [SchoolForce__External_Id__c]
		, [SchoolForce__Setup__c]
		, [Student_ID]
		, [LocalStudentID]
		)
	SELECT  Distinct a.Last_Name SchoolForce__Student_Last_Name__c
		, a.First_Name SchoolForce__Student_First_Name__c
		, CAST(a.Grade AS Char) SchoolForce__Grade__c
		, b.Account_ID SchoolForce__School__c
		, a.School_Year SchoolForce__Year__c
		, 1 SchoolForce__Active__c
		, c.Id SchoolForce__Individual__c
		, a.District + '_' + CAST(CAST(a.School_ID AS INTEGER) AS VARCHAR(10)) + '_' + a.Student_ID [SchoolForce__External_Id__c]
		, b.Setup_14_15 [SchoolForce__Setup__c]
		, a.Student_ID
		, a.Student_ID AS [LocalStudentID]

	FROM Data_Services.dbo.Student (NOLOCK) a INNER JOIN 
	Data_Services.dbo.School_Lookup_16_17 (NOLOCK) b ON 
		a.School_Name = b.Source_School_Name INNER JOIN 
	SDW_Stage_PROD_17.dbo.Contact (NOLOCK) c ON 
		a.District + '_' + CAST(CAST(a.School_ID AS INTEGER) AS VARCHAR(10)) + '_' + a.Student_ID = c.ID__c LEFT OUTER JOIN 
	Data_Services.dbo.Master_Student (NOLOCK) d on a.District + '_' + CAST(CAST(a.School_ID AS INTEGER) AS VARCHAR(10)) + '_' + a.Student_ID = d.[SchoolForce__External_Id__c]
		
	WHERE d.[SchoolForce__External_Id__c] IS NULL 
		AND a.District = @District
	END
IF @District = 'LRA'
	BEGIN	
	
	truncate table Data_Services.dbo.SF_Student

	INSERT INTO Data_Services.dbo.SF_Student(SchoolForce__Student_Last_Name__c
		, SchoolForce__Student_First_Name__c
		, SchoolForce__Grade__c
		, SchoolForce__School__c
		, SchoolForce__Year__c
		, SchoolForce__Active__c
		, SchoolForce__Individual__c
		, [SchoolForce__External_Id__c]
		, [SchoolForce__Setup__c]
		, [Student_ID]
		, [LocalStudentID]
		)
SELECT  Distinct a.Last_Name SchoolForce__Student_Last_Name__c
		, a.First_Name SchoolForce__Student_First_Name__c
		, CAST(a.Grade AS Char) SchoolForce__Grade__c
		, b.Account_ID SchoolForce__School__c
		, a.School_Year SchoolForce__Year__c
		, 1 SchoolForce__Active__c
		, c.Id SchoolForce__Individual__c
		, a.District + '_' + CAST(CAST(a.School_ID AS INTEGER) AS VARCHAR(10)) + '_' + a.Student_ID [SchoolForce__External_Id__c]
		, b.Setup_14_15 [SchoolForce__Setup__c]
		, a.Student_ID
		, a.Student_ID AS [LocalStudentID]

	FROM Data_Services.dbo.Student (NOLOCK) a 
	INNER JOIN 
	Data_Services.dbo.School_Lookup_16_17 (NOLOCK) b ON 
		a.School_Name = b.Source_School_Name INNER JOIN 
	SDW_Stage_PROD_17.dbo.Contact (NOLOCK) c ON 
		a.District + '_' + CAST(CAST(a.School_ID AS INTEGER) AS VARCHAR(10)) + '_' + a.Student_ID = c.ID__c LEFT OUTER JOIN 
	Data_Services.dbo.Master_Student (NOLOCK) d on a.District + '_' + CAST(CAST(a.School_ID AS INTEGER) AS VARCHAR(10)) + '_' + a.Student_ID = d.[SchoolForce__External_Id__c]
		
	WHERE 
	d.[SchoolForce__External_Id__c] IS NULL AND 
		a.District = @District
	END
		
IF @District = 'SJ'
BEGIN
	delete from Data_Services.dbo.SF_Student where LEFT (schoolforce__external_id__C, 3) = 'SJ_'

	-- truncate table Data_Services.dbo.Master_Student

	insert into Data_Services.dbo.SF_Student(SchoolForce__Student_Last_Name__c, SchoolForce__Student_First_Name__c, SchoolForce__Grade__c, SchoolForce__School__c, SchoolForce__Year__c, SchoolForce__Active__c, SchoolForce__Individual__c, [SchoolForce__External_Id__c], [SchoolForce__Setup__c], Student_ID, [LocalStudentID]
	, Date_Of_Birth
	, Sex
	, Ethnicity)
	select distinct 
	a.Last_Name SchoolForce__Student_Last_Name__c
	,a.First_Name SchoolForce__Student_First_Name__c
	,REPLACE(SUBSTRING(a.Grade, PATINDEX('%[^0]%', replace(a.Grade,'00','K')+'.'), LEN(a.Grade)),'00','K') SchoolForce__Grade__c
	,b.Account_ID SchoolForce__School__c
	,a.School_Year SchoolForce__Year__c
	,1 SchoolForce__Active__c
	,c.Id SchoolForce__Individual__c
	,a.District + '_' + cast(cast(a.School_ID as integer) as varchar(10)) + '_' + a.Student_ID [SchoolForce__External_Id__c]
	,b.Setup_14_15 [SchoolForce__Setup__c]
	, a.Student_ID student_id
	,a.Student_ID AS LocalStudentID
	,a.Date_Of_Birth
	,CASE a.Sex WHEN 'M' THEN 'M'
			  ELSE 'F'
	 END sex
	,a.Ethnicity 
		FROM Data_Services.dbo.Student (nolock) a 
	inner join Data_Services.dbo.School_Lookup_16_17  (nolock) b on a.School_Name = b.Source_School_Name AND A.SCHOOL_ID = B.SOURCE_SCHOOL_ID and a.district = 'sj'
	inner join sdw_stage_prod_17.dbo.Contact (nolock) c on a.District + '_' + cast(cast(a.School_ID as integer) as varchar(10)) + '_' + a.Student_ID = c.ID__c
	left outer join Data_Services.dbo.Master_Student (nolock) d on a.District + '_' + cast(cast(a.School_ID as integer) as varchar(10)) + '_' + a.Student_ID = d.[SchoolForce__External_Id__c]
	where 
	d.[SchoolForce__External_Id__c] is null and 
	a.district = 'SJ'

	update Data_Services.dbo.SF_Student set Student_ID = [SchoolForce__External_Id__c] where schoolforce__external_id__C like 'sj%'
	
	--UPDATE Data_Services.dbo.SF_Student SET Date_Of_Birth = null where Date_Of_Birth = '1900-01-01 00:00:00.000'

	--update Data_Services.dbo.SF_Student set SchoolForce__Year__c =  'a1Y1a00000066hPEAQ'

END
IF @District = 'MKE'
BEGIN
	delete from Data_Services.dbo.SF_Student where LEFT (Student_ID, 4) = 'MKE_'

	-- truncate table Data_Services.dbo.Master_Student

	insert into Data_Services.dbo.SF_Student(SchoolForce__Student_Last_Name__c, SchoolForce__Student_First_Name__c, SchoolForce__Grade__c, SchoolForce__School__c, SchoolForce__Year__c, SchoolForce__Active__c, SchoolForce__Individual__c, [SchoolForce__External_Id__c], [SchoolForce__Setup__c], LocalStudentID, Date_Of_Birth
	,Sex
	,Ethnicity)
	select
	a.Last_Name SchoolForce__Student_Last_Name__c
	,a.First_Name SchoolForce__Student_First_Name__c
	,REPLACE(SUBSTRING(a.Grade, PATINDEX('%[^0]%', replace(a.Grade,'00','K')+'.'), LEN(a.Grade)),'00','K') SchoolForce__Grade__c
	,b.Account_ID SchoolForce__School__c
	,a.School_Year SchoolForce__Year__c
	,1 SchoolForce__Active__c
	,c.Id SchoolForce__Individual__c
	,a.District + '_' + cast(cast(a.School_ID as integer) as varchar(10)) + '_' + a.Student_ID [SchoolForce__External_Id__c]
	,b.Setup_14_15 [SchoolForce__Setup__c]
	, a.Student_ID LocalStudentID 
	,a.Date_Of_Birth
	,CASE a.Sex WHEN 'M' THEN 'M'
			  ELSE 'F'
	 END sex
	,a.Ethnicity
	FROM Data_Services.dbo.Student (nolock) a 
	inner join Data_Services.dbo.School_Lookup_16_17 (nolock) b on a.School_Name = b.Source_School_Name
	inner join sdw_stage_prod_17.dbo.Contact (nolock) c on a.District + '_' + cast(cast(a.School_ID as integer) as varchar(10)) + '_' + a.Student_ID = c.ID__c
	left outer join Data_Services.dbo.Master_Student (nolock) d on a.District + '_' + cast(cast(a.School_ID as integer) as varchar(10)) + '_' + a.Student_ID = d.[SchoolForce__External_Id__c]
	where 
	d.[SchoolForce__External_Id__c] is null and 
	a.district = 'mke'

	update Data_Services.dbo.SF_Student set Student_ID = [SchoolForce__External_Id__c]
	
	UPDATE Data_Services.dbo.SF_Student SET Date_Of_Birth = null where Date_Of_Birth = '1900-01-01 00:00:00.000'

	--update Data_Services.dbo.SF_Student set SchoolForce__Year__c =  'a1Y1a00000066hPEAQ'

END
IF @District = 'CLM'
BEGIN
	delete from Data_Services.dbo.SF_Student where LEFT (schoolforce__external_id__C, 4) = 'CLM_'

	-- truncate table Data_Services.dbo.Master_Student

	insert into Data_Services.dbo.SF_Student(SchoolForce__Student_Last_Name__c, SchoolForce__Student_First_Name__c, SchoolForce__Grade__c, SchoolForce__School__c, SchoolForce__Year__c, SchoolForce__Active__c, SchoolForce__Individual__c, [SchoolForce__External_Id__c], [SchoolForce__Setup__c], Student_ID, [LocalStudentID]
	, Date_Of_Birth
	, Sex
	, Ethnicity)
	select distinct 
	a.Last_Name SchoolForce__Student_Last_Name__c
	,a.First_Name SchoolForce__Student_First_Name__c
	,REPLACE(SUBSTRING(a.Grade, PATINDEX('%[^0]%', replace(a.Grade,'00','K')+'.'), LEN(a.Grade)),'00','K') SchoolForce__Grade__c
	,b.Account_ID SchoolForce__School__c
	,a.School_Year SchoolForce__Year__c
	,1 SchoolForce__Active__c
	,c.Id SchoolForce__Individual__c
	,a.District + '_' + cast(cast(a.School_ID as integer) as varchar(10)) + '_' + a.Student_ID [SchoolForce__External_Id__c]
	,b.Setup_14_15 [SchoolForce__Setup__c]
	, a.Student_ID student_id
	,a.Student_ID AS LocalStudentID
	,a.Date_Of_Birth
	,CASE a.Sex WHEN 'M' THEN 'M'
			  ELSE 'F'
	 END sex
	,a.Ethnicity 
		FROM Data_Services.dbo.Student (nolock) a 
	inner join Data_Services.dbo.School_Lookup_16_17  (nolock) b on a.School_Name = b.Source_School_Name AND A.SCHOOL_ID = B.SOURCE_SCHOOL_ID and a.district = 'CLM'
	inner join sdw_stage_prod_17.dbo.Contact (nolock) c on a.District + '_' + cast(cast(a.School_ID as integer) as varchar(10)) + '_' + a.Student_ID = c.ID__c
	left outer join Data_Services.dbo.Master_Student (nolock) d on a.District + '_' + cast(cast(a.School_ID as integer) as varchar(10)) + '_' + a.Student_ID = d.[SchoolForce__External_Id__c]
	where 
	d.[SchoolForce__External_Id__c] is null and 
	a.district = 'CLM'

	update Data_Services.dbo.SF_Student set Student_ID = [SchoolForce__External_Id__c] where schoolforce__external_id__C like 'CLM%'
	
	UPDATE Data_Services.dbo.SF_Student SET Date_Of_Birth = null where Date_Of_Birth = '1900-01-01 00:00:00.000'

	--update Data_Services.dbo.SF_Student set SchoolForce__Year__c =  'a1Y1a00000066hPEAQ'

END
END



GO
