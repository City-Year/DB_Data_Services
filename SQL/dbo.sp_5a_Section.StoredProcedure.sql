USE [Data_Services]
GO
/****** Object:  StoredProcedure [dbo].[sp_5a_Section]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_5a_Section] @District varchar(255) = 'Standard'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

If @District = 'OCPS'
	BEGIN
	insert into Data_Services.dbo.Master_Section(SF_Section_External_ID, FirstName, LastName, School_Name, Class_Section_ID, Source_School_ID, SF_Staff_External_ID, Class_Period_Name, Section_Type, Period, SF_ID)
	select distinct 
	--'OCPS_' + c.School_ID + '_' + 
	'OCPS_' + c.School_ID + '_' + a.Class_Section_ID + '_' + replace(a.Teacher_Last_Name, ' ', '_') + '_' + a.Teacher_First_Name + '_' + d.Source_School_ID as SF_Section_External_ID, 
	b.First_Name, b.Last_Name, c.School_Name, a.Class_Section_ID, d.Source_School_ID, b.SchoolForce__External_Id__c SF_Staff_External_ID, a.Class_Period_Name, a.Section_Type, a.Period, f.ID
	from Data_Services.dbo.Class_Processed (nolock) a
	inner join Data_Services.dbo.Master_Staff (nolock) b on 'OCPS_' + substring(a.Class_Section_ID, 1, 4)  + '_' + a.Teacher_First_Name + '_' + replace(a.Teacher_Last_Name, ' ', '_') = b.SchoolForce__External_ID__c 
	inner join Data_Services.dbo.Student (nolock) c on a.Student_ID = c.Student_ID
	inner join Data_Services.dbo.School_Lookup (nolock) d on d.Source_School_Name = c.School_Name
	left outer join Data_Services.dbo.Master_Section (nolock) e on 'OCPS_' + c.School_ID + '_' + a.Class_Section_ID + '_' + replace(a.Teacher_Last_Name, ' ', '_') + '_' + a.Teacher_First_Name + '_' + d.Source_School_ID = e.SF_Section_External_ID
	inner join SDW_Stage_Prod.dbo.Section__c (nolock) f on 'OCPS_' + a.Class_Section_ID + '_' + replace(a.Teacher_Last_Name, ' ', '_') + '_' + a.Teacher_First_Name + '_' + d.Source_School_ID = f.External_Id__c
	where e.SF_Section_External_ID is null and c.District = @District
	END

If @District = 'KCPS'
	BEGIN
		insert into Data_Services.dbo.Master_Section(SF_Section_External_ID, FirstName, LastName, School_Name, Class_Section_ID, Source_School_ID, SF_Staff_External_ID, Class_Period_Name, Section_Type, Period, SF_ID)
		select distinct 
		--'OCPS_' + c.School_ID + '_' + 
		a.District + '_' + a.Class_Section_ID + '_' + a.Period + '_' + replace(a.Teacher_Last_Name, ' ', '_') + '_' + a.Teacher_First_Name + '_' + d.Source_School_ID as SF_Section_External_ID, 
		b.First_Name, b.Last_Name, c.School_Name, a.Class_Section_ID, d.Source_School_ID, b.SchoolForce__External_Id__c SF_Staff_External_ID, a.Class_Period_Name, a.Section_Type, a.Period, f.ID
		from Data_Services.dbo.Class_Processed (nolock) a
		inner join Data_Services.dbo.Student (nolock) c on a.Student_ID = c.Student_ID
		inner join Data_Services.dbo.School_Lookup_16_17 (nolock) d on d.Source_School_Name = c.School_Name
		inner join Data_Services.dbo.Master_Staff (nolock) b on 
		replace(a.District + '_' + School_ID + '_' + LEFT(a.Teacher_Name, charindex(' ', a.Teacher_Name)- 1) + '_' + substring(a.Teacher_Name, charindex(' ', a.Teacher_Name) + 1, len(a.Teacher_Name) - charindex('_', a.Teacher_Name)), ' ', '_') = 
		b.SchoolForce__External_ID__c 
		left outer join Data_Services.dbo.Master_Section (nolock) e on a.District + '_' + a.Class_Section_ID + '_' + a.Period + '_' + replace(a.Teacher_Last_Name, ' ', '_') + '_' + a.Teacher_First_Name + '_' + d.Source_School_ID = e.SF_Section_External_ID
		inner join SDW_Stage_Prod_17.dbo.Section__c (nolock) f on 
		a.District + '_' + a.Class_Section_ID + '_' + a.Period + '_' + replace(a.Teacher_Last_Name, ' ', '_') + '_' + a.Teacher_First_Name + '_' + d.Source_School_ID = 
		f.External_Id__c
		where a.District = 'KCPS' and e.SF_Section_External_ID is null
	END

If @District = '1STLN'
	BEGIN
		
		INSERT INTO Data_Services.dbo.Master_Section(SF_Section_External_ID
			, FirstName
			, LastName
			, School_Name
			, Class_Section_ID
			, Source_School_ID
			, SF_Staff_External_ID
			, Class_Period_Name
			, Section_Type
			, Period
			, SF_ID)
		
		SELECT DISTINCT a.District + '_' + c.School_ID + '_' + a.Class_Section_ID + '_' + REPLACE(a.Teacher_Last_Name, ' ', '_') + '_' + a.Teacher_First_Name + '_' + d.Source_School_ID as SF_Section_External_ID
			, b.First_Name
			, b.Last_Name
			, c.School_Name
			, a.Class_Section_ID
			, d.Source_School_ID
			, b.SchoolForce__External_Id__c SF_Staff_External_ID
			, a.Class_Period_Name
			, a.Section_Type
			, a.Period
			, f.ID
			
		FROM Data_Services.dbo.Class_Processed (NOLOCK) a INNER JOIN 
		Data_Services.dbo.Student (NOLOCK) c ON 
			a.Student_ID = c.Student_ID INNER JOIN 
		Data_Services.dbo.School_Lookup_16_17 (NOLOCK) d ON
			d.Source_School_Name = c.School_Name  INNER JOIN 
		Data_Services.dbo.Master_Staff (nolock) b ON 
		a.District + '_' + d.source_school_id  + '_' + a.Teacher_First_Name + '_' + REPLACE(a.Teacher_Last_Name, ' ', '_') = b.SchoolForce__External_ID__c LEFT OUTER JOIN 
		Data_Services.dbo.Master_Section (nolock) e ON 
			a.District + '_' + c.School_ID + '_' + a.Class_Section_ID + '_' + a.Period + '_' + REPLACE(a.Teacher_Last_Name, ' ', '_') + '_' + a.Teacher_First_Name + '_' + d.Source_School_ID = e.SF_Section_External_ID INNER JOIN 
		SDW_Stage_Prod_17.dbo.Section__c (NOLOCK) f ON 
			a.District + '_' + a.Class_Section_ID + '_'  + a.Period + '_' + REPLACE(a.Teacher_Last_Name, ' ', '_') + '_' + a.Teacher_First_Name + '_' + d.Source_School_ID = f.External_Id__c
		 WHERE a.District = @District AND 
			e.SF_Section_External_ID IS NULL			

END

If @District = 'LRA'
	BEGIN
		
		INSERT INTO Data_Services.dbo.Master_Section(SF_Section_External_ID
			, FirstName
			, LastName
			, School_Name
			, Class_Section_ID
			, Source_School_ID
			, SF_Staff_External_ID
			, Class_Period_Name
			, Section_Type
			, Period
			, SF_ID)
		
		SELECT DISTINCT a.District + '_' + c.School_ID + '_' + a.Class_Section_ID + '_' + REPLACE(a.Teacher_Last_Name, ' ', '_') + '_' + a.Teacher_First_Name + '_' + d.Source_School_ID as SF_Section_External_ID
			, b.First_Name
			, b.Last_Name
			, c.School_Name
			, a.Class_Section_ID
			, d.Source_School_ID
			, b.SchoolForce__External_Id__c SF_Staff_External_ID
			, a.Class_Period_Name
			, a.Section_Type
			, a.Period
			, f.ID
			
		FROM Data_Services.dbo.Class_Processed (NOLOCK) a INNER JOIN 
		Data_Services.dbo.Student (NOLOCK) c ON 
			a.Student_ID = c.Student_ID INNER JOIN 
		Data_Services.dbo.School_Lookup_16_17 (NOLOCK) d ON
			d.Source_School_Name = c.School_Name  INNER JOIN 
		Data_Services.dbo.Master_Staff (nolock) b ON 
		a.District + '_' + d.source_school_id  + '_' + a.Teacher_First_Name + '_' + REPLACE(a.Teacher_Last_Name, ' ', '_') = b.SchoolForce__External_ID__c LEFT OUTER JOIN 
		Data_Services.dbo.Master_Section (nolock) e ON 
			a.District + '_' + c.School_ID + '_' + a.Class_Section_ID + '_' + a.Period + '_' + REPLACE(a.Teacher_Last_Name, ' ', '_') + '_' + a.Teacher_First_Name + '_' + d.Source_School_ID = e.SF_Section_External_ID INNER JOIN 
		SDW_Stage_Prod_17.dbo.Section__c (NOLOCK) f ON 
			a.District + '_' + a.Class_Section_ID + '_'  + a.Period + '_' + REPLACE(a.Teacher_Last_Name, ' ', '_') + '_' + a.Teacher_First_Name + '_' + d.Source_School_ID = f.External_Id__c
		 WHERE a.District = @District AND 
			e.SF_Section_External_ID IS NULL			

END

If @District = 'LA'
	BEGIN
	
	INSERT INTO Data_Services.dbo.Master_Section(SF_Section_External_ID
			, FirstName
			, LastName
			, School_Name
			, Class_Section_ID
			, Source_School_ID
			, SF_Staff_External_ID
			, Class_Period_Name
			, Section_Type
			, Period
			, SF_ID)
	
	SELECT DISTINCT a.District + '_' + c.School_ID + '_' + a.Class_Section_ID + '_' + REPLACE(a.Teacher_Last_Name, ' ', '_') + '_' + a.Teacher_First_Name + '_' + d.Source_School_ID as SF_Section_External_ID
	, b.First_Name
	, b.Last_Name
	, c.School_Name
	, a.Class_Section_ID
	, d.Source_School_ID
	, b.SchoolForce__External_Id__c SF_Staff_External_ID
	, a.Class_Period_Name
	, a.Section_Type
	, a.Period
	, f.ID
FROM Data_Services.dbo.Class_Processed (NOLOCK) a INNER JOIN 
Data_Services.dbo.Student (NOLOCK) c ON 
a.Student_ID = c.Student_ID INNER JOIN
Data_Services.dbo.School_Lookup_16_17 (NOLOCK) d ON
	c.School_ID = d.Source_School_ID LEFT JOIN
Data_Services.dbo.Master_Staff b (nolock)  ON
	a.District + '_' + d.source_school_id  + '_' + a.Teacher_First_Name + '_' + REPLACE(a.Teacher_Last_Name, ' ', '_') = b.SchoolForce__External_ID__c LEFT OUTER JOIN 
Data_Services.dbo.Master_Section (nolock) e ON 
	a.District + '_' + c.School_ID + '_' + a.Class_Section_ID + '_' + REPLACE(a.Teacher_Last_Name, ' ', '_') + '_' + a.Teacher_First_Name + '_' + d.Source_School_ID = e.SF_Section_External_ID INNER JOIN 
SDW_Stage_Prod_17.dbo.Section__c (NOLOCK) f ON
	a.District + '_' + a.Class_Section_ID + '_'+ a.Period +  '_' +  + REPLACE(a.Teacher_Last_Name, ' ', '_') + '_' + a.Teacher_First_Name + '_' + d.Source_School_ID = f.External_Id__c
WHERE a.District = @District AND 
e.SF_Section_External_ID IS NULL
END
	IF @District = 'SJ' 
	BEGIN
				insert into Data_Services.dbo.Master_Section(SF_Section_External_ID, FirstName, LastName, School_Name, Class_Section_ID, Source_School_ID, SF_Staff_External_ID, Class_Period_Name, Section_Type, Period, SF_ID)
		select distinct 
		a.District + '_' + a.Class_Section_ID + '_' + a.Period + '_' + replace(a.Teacher_Last_Name, ' ', '_') + '_' + a.Teacher_First_Name + '_' + d.Source_School_ID as SF_Section_External_ID, 
		b.First_Name, b.Last_Name, c.School_Name, a.Class_Section_ID, d.Source_School_ID, b.SchoolForce__External_Id__c SF_Staff_External_ID, a.Class_Period_Name, a.Section_Type, a.Period, f.ID
		from Data_Services.dbo.Class_Processed (nolock) a
		inner join Data_Services.dbo.Student (nolock) c on a.Student_ID = c.Student_ID
		inner join Data_Services.dbo.School_Lookup_16_17 (nolock) d on d.Source_School_Name = c.School_Name
		inner join Data_Services.dbo.Master_Staff (nolock) b on replace(a.District + '_' + School_ID + '_' + substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) + '_' + substring(Teacher_Name, 0, charindex(',', Teacher_Name)), ' ', '_') = b.SchoolForce__External_ID__c 
		inner join sdw_stage_prod_17.dbo.Section__c (nolock) f on a.District + '_' + a.Class_Section_ID + '_' + a.Period + '_' + replace(a.Teacher_Last_Name, ' ', '_') + '_' + a.Teacher_First_Name + '_' + d.Source_School_ID = f.External_Id__c
		left outer join Data_Services.dbo.Master_Section (nolock) e on a.District + '_' + a.Class_Section_ID + '_' + a.Period + '_' + replace(a.Teacher_Last_Name, ' ', '_') + '_' + a.Teacher_First_Name + '_' + d.Source_School_ID = e.SF_Section_External_ID
		where a.District = 'SJ' and e.SF_Section_External_ID is null
	END

	IF @District = 'MKE' 
	BEGIN
				insert into Data_services.dbo.Master_Section(SF_Section_External_ID, FirstName, LastName, School_Name, Class_Section_ID, Source_School_ID, SF_Staff_External_ID, Class_Period_Name, Section_Type, Period, SF_ID)
		select distinct 
		a.District + '_' + a.Class_Section_ID + '_' + a.Period + ' - ' + a.Class_Period_Name + '_' + replace(a.Teacher_Last_Name, ' ', '_') + '_' + a.Teacher_First_Name + '_' + d.Source_School_ID  as SF_Section_External_ID, 
		b.First_Name, b.Last_Name, c.School_Name, a.Class_Section_ID, d.Source_School_ID, b.SchoolForce__External_Id__c SF_Staff_External_ID, a.Class_Period_Name, a.Section_Type, a.Period, f.ID
		from Data_services.dbo.Class_Processed (nolock) a
		inner join Data_services.dbo.Student (nolock) c on a.Student_ID = c.Student_ID
		inner join Data_services.dbo.School_Lookup_16_17 (nolock) d on d.Source_School_Name = c.School_Name
		inner join Data_services.dbo.Master_Staff (nolock) b on replace(a.District + '_' + School_ID + '_' +LTRIM(RTRIM(SUBSTRING(Teacher_Name, CHARINDEX(' ', Teacher_Name)+1, 8000)))  + '_' + LTRIM(RTRIM(SUBSTRING(Teacher_Name, 0, CHARINDEX(' ', Teacher_Name)))), ' ', '_') = b.SchoolForce__External_ID__c 
		inner join SDW_Stage_Prod_17.dbo.Section__c (nolock) f on a.District + '_' + a.Class_Section_ID + '_' + a.Period + ' - ' + a.Class_Period_Name + '_' + replace(a.Teacher_Last_Name, ' ', '_') + '_' + a.Teacher_First_Name + '_' + d.Source_School_ID = f.External_Id__c
		left outer join Data_services.dbo.Master_Section (nolock) e on a.District + '_' + a.Class_Section_ID + '_' + a.Period + ' - ' + a.Class_Period_Name +'_' + replace(a.Teacher_Last_Name, ' ', '_') + '_' + a.Teacher_First_Name + '_' + d.Source_School_ID = e.SF_Section_External_ID
		where a.District = 'MKE' and e.SF_Section_External_ID is null
	END

	IF @District = 'CLM' 
	BEGIN
				insert into Data_services.dbo.Master_Section(SF_Section_External_ID, FirstName, LastName, School_Name, Class_Section_ID, Source_School_ID, SF_Staff_External_ID, Class_Period_Name, Section_Type, Period, SF_ID)
		select distinct 
		a.District + '_' + a.Class_Section_ID + '_' + a.Period + '_' + replace(a.Teacher_Last_Name, ' ', '_') + '_' + a.Teacher_First_Name + '_' + d.Source_School_ID as SF_Section_External_ID, 
		b.First_Name, b.Last_Name, c.School_Name, a.Class_Section_ID, d.Source_School_ID, b.SchoolForce__External_Id__c SF_Staff_External_ID, a.Class_Period_Name, a.Section_Type, a.Period, f.ID
		from Data_services.dbo.Class_Processed (nolock) a
		inner join Data_services.dbo.Student (nolock) c on a.Student_ID = c.Student_ID AND c.DISTRICT = 'CLM'
		inner join Data_services.dbo.School_Lookup_16_17 (nolock) d on d.Source_School_Name = c.School_Name
		inner join Data_services.dbo.Master_Staff (nolock) b on replace(a.District + '_' + School_ID + '_' + substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) + '_' + substring(Teacher_Name, 0, charindex(',', Teacher_Name)), ' ', '_') = b.SchoolForce__External_ID__c 
		inner join SDW_Stage_Prod_17.dbo.Section__c (nolock) f on a.District + '_' + a.Class_Section_ID + '_' + a.Period + '_' + replace(a.Teacher_Last_Name, ' ', '_') + '_' + a.Teacher_First_Name + '_' + d.Source_School_ID = f.External_Id__c
		left outer join Data_services.dbo.Master_Section (nolock) e on a.District + '_' + a.Class_Section_ID + '_' + a.Period + '_' + replace(a.Teacher_Last_Name, ' ', '_') + '_' + a.Teacher_First_Name + '_' + d.Source_School_ID = e.SF_Section_External_ID
		where a.District = 'CLM' and e.SF_Section_External_ID is null
	END



END


GO
