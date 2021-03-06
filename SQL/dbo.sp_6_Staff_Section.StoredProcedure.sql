USE [Data_Services]
GO
/****** Object:  StoredProcedure [dbo].[sp_6_Staff_Section]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_6_Staff_Section] @District varchar(255) = 'Standard'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	--delete from Data_Services.dbo.SF_Staff_Section

	-- truncate table Data_Services.dbo.Master_Staff_Section

	if @District = 'Standard'
	BEGIN
	
	--delete from Data_Services.dbo.SF_Staff_Section

	insert into Data_Services.dbo.SF_Staff_Section(SF_Staff_ID, SF_Section_ID, Active)
	select distinct b.SF_ID SF_Staff_ID, c.SF_ID SF_Section_ID, '1' Active
	from Data_Services.dbo.Class_Processed (nolock) a 
	inner join Data_Services.dbo.Master_Staff (nolock) b on a.Teacher_Name = b.TeacherName
	inner join (select distinct SF_ID, FirstName, LastName, Class_Section_ID, SF_Section_External_ID from Data_Services.dbo.Master_Section (nolock)) c on a.Class_Section_ID = c.Class_Section_ID and a.Teacher_First_Name = c.FirstName and a.Teacher_Last_Name = c.LastName
	left outer join Data_Services.dbo.Master_Staff_Section (Nolock) d on b.SF_ID = d.SchoolForce__Staff__c and c.SF_ID = d.SchoolForce__Section__c
	where d.SchoolForce__Staff__c is null and SchoolForce__Section__c is null AND a.District = @District
	END
IF @District = 'SJ'
BEGIN

	DELETE FROM SF_Staff_Section WHERE SF_Staff_ID IN (SELECT SF_ID FROM Master_Staff WHERE LEFT(SchoolForce__External_Id__c,LEN(@District)) = @District)


	INSERT INTO Data_Services.dbo.SF_Staff_Section(SF_Staff_ID
	, SF_Section_ID
	, Active)
	SELECT DISTINCT b.SF_ID SF_Staff_ID
	, c.SF_ID SF_Section_ID
	, '1' Active
	FROM Data_Services.dbo.Class_Processed (NOLOCK) a INNER JOIN 
	Data_Services.dbo.Master_Staff (NOLOCK) b on a.Teacher_Name = b.TeacherName and a.district = 'sj' INNER JOIN 
	(SELECT DISTINCT SF_ID
	, FirstName
	, LastName
	, Class_Section_ID
	, SF_Section_External_ID 
	FROM Data_Services.dbo.Master_Section (NOLOCK)) c ON 
		a.Class_Section_ID = c.Class_Section_ID AND 
		a.Teacher_First_Name = c.FirstName AND 
		a.Teacher_Last_Name = c.LastName LEFT OUTER JOIN 
	Data_Services.dbo.Master_Staff_Section (NOLOCK) d ON 
		b.SF_ID = d.SchoolForce__Staff__c AND 
		c.SF_ID = d.SchoolForce__Section__c
	WHERE d.SchoolForce__Staff__c IS NULL AND SchoolForce__Section__c IS NULL AND a.District = @District

END
IF @District = 'MKE'
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

	DELETE FROM Data_services.dbo.SF_Staff_Section  WHERE SF_Staff_ID IN (SELECT SF_ID FROM Master_Staff WHERE LEFT(SchoolForce__External_Id__c,LEN(@District)) = @District)
	-- truncate table Data_services.dbo.Master_Staff_Section

	INSERT INTO Data_services.dbo.SF_Staff_Section(SF_Staff_ID
	, SF_Section_ID
	, Active)
	SELECT DISTINCT b.SF_ID SF_Staff_ID
	, c.SF_ID SF_Section_ID
	, '1' Active
	FROM Data_services.dbo.Class_Processed (NOLOCK) a INNER JOIN 
	Data_services.dbo.Master_Staff (NOLOCK) b on a.Teacher_Name = b.TeacherName  and a.district = 'MKE' INNER JOIN 
	(SELECT DISTINCT SF_ID
	, FirstName
	, LastName
	, Class_Section_ID
	, SF_Section_External_ID 
	FROM Data_services.dbo.Master_Section (NOLOCK)) c ON 
		a.Class_Section_ID = c.Class_Section_ID AND 
		a.Teacher_First_Name = c.FirstName AND 
		a.Teacher_Last_Name = c.LastName LEFT OUTER JOIN 
	Data_services.dbo.Master_Staff_Section (NOLOCK) d ON 
		b.SF_ID = d.SchoolForce__Staff__c AND 
		c.SF_ID = d.SchoolForce__Section__c
	WHERE d.SchoolForce__Staff__c IS NULL AND SchoolForce__Section__c IS NULL AND a.District = 'MKE'


END
IF @District = 'CLM'
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

	DELETE FROM Data_services.dbo.SF_Staff_Section WHERE SF_Staff_ID IN (SELECT SF_ID FROM Master_Staff WHERE LEFT(SchoolForce__External_Id__c,LEN(@District)) = @District)
	-- truncate table Data_services.dbo.Master_Staff_Section

	INSERT INTO Data_services.dbo.SF_Staff_Section(SF_Staff_ID
	, SF_Section_ID
	, Active)
	SELECT DISTINCT b.SF_ID SF_Staff_ID
	, c.SF_ID SF_Section_ID
	, '1' Active
	FROM Data_services.dbo.Class_Processed (NOLOCK) a INNER JOIN 
	Data_services.dbo.Master_Staff (NOLOCK) b on a.Teacher_Name = b.TeacherName  and a.district = 'CLM' INNER JOIN 
	(SELECT DISTINCT SF_ID
	, FirstName
	, LastName
	, Class_Section_ID
	, SF_Section_External_ID 
	FROM Data_services.dbo.Master_Section (NOLOCK)) c ON 
		a.Class_Section_ID = c.Class_Section_ID AND 
		a.Teacher_First_Name = c.FirstName AND 
		a.Teacher_Last_Name = c.LastName LEFT OUTER JOIN 
	Data_services.dbo.Master_Staff_Section (NOLOCK) d ON 
		b.SF_ID = d.SchoolForce__Staff__c AND 
		c.SF_ID = d.SchoolForce__Section__c
	WHERE d.SchoolForce__Staff__c IS NULL AND SchoolForce__Section__c IS NULL AND a.District = @District

END


IF @District = '1STLN'
BEGIN

	DELETE FROM SF_Staff_Section WHERE SF_Staff_ID IN (SELECT SF_ID FROM Master_Staff WHERE LEFT(SchoolForce__External_Id__c,LEN(@District)) = @District)


	INSERT INTO Data_Services.dbo.SF_Staff_Section(SF_Staff_ID
		, SF_Section_ID
		, Active
	)
	SELECT DISTINCT b.SF_ID SF_Staff_ID
		, c.SF_ID SF_Section_ID
		, '1' Active
	FROM Data_Services.dbo.Class_Processed (NOLOCK) a INNER JOIN 
	Data_Services.dbo.Master_Staff (NOLOCK) b on a.Teacher_Name = b.TeacherName INNER JOIN 
	(SELECT DISTINCT SF_ID
		, FirstName
		, LastName
		, Class_Section_ID
		, SF_Section_External_ID 
	FROM Data_Services.dbo.Master_Section (NOLOCK)) c ON 
		a.Class_Section_ID = c.Class_Section_ID AND 
		a.Teacher_First_Name = c.FirstName AND 
		a.Teacher_Last_Name = c.LastName LEFT OUTER JOIN 
	Data_Services.dbo.Master_Staff_Section (NOLOCK) d ON 
		b.SF_ID = d.SchoolForce__Staff__c AND 
		c.SF_ID = d.SchoolForce__Section__c
	WHERE d.SchoolForce__Staff__c IS NULL AND SchoolForce__Section__c IS NULL AND a.District = @District

END
IF @District = 'LRA'
BEGIN

	DELETE FROM SF_Staff_Section WHERE SF_Staff_ID IN (SELECT SF_ID FROM Master_Staff WHERE LEFT(SchoolForce__External_Id__c,LEN(@District)) = @District)


	INSERT INTO Data_Services.dbo.SF_Staff_Section(SF_Staff_ID
		, SF_Section_ID
		, Active
	)
	SELECT DISTINCT b.SF_ID SF_Staff_ID
		, c.SF_ID SF_Section_ID
		, '1' Active
	FROM Data_Services.dbo.Class_Processed (NOLOCK) a INNER JOIN 
	Data_Services.dbo.Master_Staff (NOLOCK) b on a.Teacher_Name = b.TeacherName INNER JOIN 
	(SELECT DISTINCT SF_ID
		, FirstName
		, LastName
		, Class_Section_ID
		, SF_Section_External_ID 
	FROM Data_Services.dbo.Master_Section (NOLOCK)) c ON 
		a.Class_Section_ID = c.Class_Section_ID AND 
		a.Teacher_First_Name = c.FirstName AND 
		a.Teacher_Last_Name = c.LastName LEFT OUTER JOIN 
	Data_Services.dbo.Master_Staff_Section (NOLOCK) d ON 
		b.SF_ID = d.SchoolForce__Staff__c AND 
		c.SF_ID = d.SchoolForce__Section__c
	WHERE d.SchoolForce__Staff__c IS NULL AND SchoolForce__Section__c IS NULL AND a.District = @District

END
IF @District = 'LA'
BEGIN

	DELETE FROM SF_Staff_Section WHERE SF_Staff_ID IN (SELECT SF_ID FROM Master_Staff WHERE LEFT(SchoolForce__External_Id__c,LEN(@District)) = @District)

	INSERT INTO Data_Services.dbo.SF_Staff_Section(SF_Staff_ID
		, SF_Section_ID
		, Active
	)
	SELECT DISTINCT b.SF_ID SF_Staff_ID
		, c.SF_ID SF_Section_ID
		, '1' Active
	FROM Data_Services.dbo.Class_Processed (NOLOCK) a INNER JOIN 
	Data_Services.dbo.Master_Staff (NOLOCK) b on a.Teacher_Name = b.TeacherName INNER JOIN 
	(SELECT DISTINCT SF_ID
		, FirstName
		, LastName
		, Class_Section_ID
		, SF_Section_External_ID 
	FROM Data_Services.dbo.Master_Section (NOLOCK)) c ON 
		a.Class_Section_ID = c.Class_Section_ID AND 
		a.Teacher_First_Name = c.FirstName AND 
		a.Teacher_Last_Name = c.LastName LEFT OUTER JOIN 
	Data_Services.dbo.Master_Staff_Section (NOLOCK) d ON 
		b.SF_ID = d.SchoolForce__Staff__c AND 
		c.SF_ID = d.SchoolForce__Section__c
	WHERE d.SchoolForce__Staff__c IS NULL AND SchoolForce__Section__c IS NULL AND a.District = @District

END

	if @District = 'KCPS'
	BEGIN
	
	--delete from Data_Services.dbo.SF_Staff_Section
		DELETE FROM SF_Staff_Section WHERE SF_Staff_ID IN (SELECT SF_ID FROM Master_Staff WHERE LEFT(SchoolForce__External_Id__c,LEN(@District)) = @District)


	insert into Data_Services.dbo.SF_Staff_Section(SF_Staff_ID, SF_Section_ID, Active)
	select distinct b.SF_ID SF_Staff_ID, c.SF_ID SF_Section_ID, '1' Active
	from Data_Services.dbo.Class_Processed (nolock) a 
	inner join Data_Services.dbo.Master_Staff (nolock) b on a.Teacher_Name = b.TeacherName
	inner join (select distinct SF_ID, FirstName, LastName, Class_Section_ID, SF_Section_External_ID from Data_Services.dbo.Master_Section (nolock)) c on a.Class_Section_ID = c.Class_Section_ID and a.Teacher_First_Name = c.FirstName and a.Teacher_Last_Name = c.LastName
	left outer join Data_Services.dbo.Master_Staff_Section (Nolock) d on b.SF_ID = d.SchoolForce__Staff__c and c.SF_ID = d.SchoolForce__Section__c
	where d.SchoolForce__Staff__c is null and SchoolForce__Section__c is null AND a.District = @District
	END
END


GO
