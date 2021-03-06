USE [Data_Services]
GO
/****** Object:  StoredProcedure [dbo].[sp_11_Grades_MP]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_11_Grades_MP] @District varchar(255) = 'Standard'
AS
BEGIN

if @District = 'Standard'
	BEGIN
	select Name, Assignment_Library__c, SchoolForce__Due_Date__c, SchoolForce__Picklist_Value__c, SchoolForce__Include_in_Final_Grade__c, SchoolForce__Name_in_Gradebook__c, 
	SchoolForce__Possible_Points__c, SchoolForce__Time__c, 
	min(SchoolForce__Section__c) SchoolForce__Section__c, 
	SchoolForce__Weighting_Value__c, Student_ID, Marking_Period, Class_Section_ID, GPA_Value, SchoolForce__Course__c
	into #MP_Grades_Temp
	from 
	(select distinct 
	'Reporting Period Course Grade' Name, 
	k.ID Assignment_Library__c,
	End_Date__c [SchoolForce__Due_Date__c],
	(select [Value] from [Data_Services].[dbo].[Settings] where [Name] = 'Grade_MP.Picklist_Value') [SchoolForce__Picklist_Value__c], 
	1 [SchoolForce__Include_in_Final_Grade__c], 
	k.Marking_Period_2 [SchoolForce__Name_in_Gradebook__c],
	100 [SchoolForce__Possible_Points__c],
	j.ID [SchoolForce__Time__c], 
	d.SF_ID [SchoolForce__Section__c], 
	1 [SchoolForce__Weighting_Value__c]
	,a.Student_ID
	,a.Marking_Period
	,a.Class_Section_ID
	,a.GPA_Value
	,l.ID SchoolForce__Course__c
	-- into SF_Grade_MP
	from Data_Services.dbo.MP_Grades (nolock) a
	inner join Data_Services.dbo.Master_Student (nolock) c on a.Student_ID = c.Student_ID and substring(a.Class_Section_ID, 1, 4) = c.School_ID
	inner join Data_Services.dbo.School_Lookup (nolock) h on c.SchoolForce__Setup__C = h.Setup_14_15
	inner join SDW_Stage_Prod.dbo.Setup__c (nolock) i on h.Account_ID = i.[School__c]
	inner join SDW_Stage_Prod.dbo.Time_Element__c (nolock) j on i.[Term__c] = j.[Parent_Time_Element__c]
	inner join (select min(a.ID) ID, Student_ID, Class_Section_ID, Section_ID, b.[SchoolForce__School__c], Section_Type, c.SF_ID, c.Source_School_ID School_ID from Data_Services.dbo.Master_Student_Section (nolock) a inner join Data_Services.dbo.Master_Student (nolock) b on a.SchoolForce__Student__c = b.SF_ID inner join (select distinct SF_ID, Class_Section_ID, b.ID Section_ID, Section_Type, Source_School_ID from Data_Services.dbo.Master_Section (nolock) a inner join SDW_Stage_Prod.dbo.Course__c (nolock) b on a.Section_Type = b.Name where SF_ID is not null) c on a.SchoolForce__Section__c = c.SF_ID group by Student_ID, Class_Section_ID, Section_ID, b.[SchoolForce__School__c], Section_Type, c.SF_ID, b.School_ID, c.Source_School_ID) d on a.Student_ID = d.Student_ID and a.Class_Section_ID = d.Class_Section_ID and substring(a.Class_Section_ID, 1, 4) = d.School_ID
	inner join Data_Services.dbo.vw_Master_Assignment_Library_MP (nolock) k on a.Marking_Period = k.Marking_Period_3 and d.Section_Type = k.Section_Type_2
	inner join SDW_Stage_Prod.dbo.Course__c (nolock) l on d.Section_Type = l.Name
	where a.Marking_Period is not null 
	and year(Year_End__c) = 2016
	and REPLACE(j.Name__c,'Quarter ','RC') = a.Marking_Period
	and l.Reference_Id__c like '%CY%') a
	group by Name, Assignment_Library__c, SchoolForce__Due_Date__c, SchoolForce__Picklist_Value__c, SchoolForce__Include_in_Final_Grade__c, SchoolForce__Name_in_Gradebook__c, 
	SchoolForce__Possible_Points__c, SchoolForce__Time__c, SchoolForce__Weighting_Value__c, Student_ID, Marking_Period, Class_Section_ID, GPA_Value, SchoolForce__Course__c

	delete from Data_Services.dbo.SF_Grade_MP

	end

if @District = 'OCPS'
	BEGIN

	delete from Data_Services.dbo.SF_Grade_MP

	insert into Data_Services.dbo.SF_Grade_MP(SchoolForce__Assignment__c, SchoolForce__Assignment_Weighting__c, SchoolForce__Course__c, SchoolForce__Grade_Number__c, SchoolForce__Entered_Grade__c,
	SchoolForce__Points_Grade__c, SchoolForce__Possible_Points__c, SchoolForce__Time__c, SchoolForce__Student__c, SchoolForce__Student_Section__c, SchoolForce__Valid_Grade__c)
	select b.ID [SchoolForce__Assignment__c], 1 SchoolForce__Assignment_Weighting__c, a.SchoolForce__Course__c, Weighted_Value SchoolForce__Grade_Number__c, Grade_Value SchoolForce__Entered_Grade__c,
	0 SchoolForce__Points_Grade__c, 100 SchoolForce__Possible_Points__c, a.SchoolForce__Time__c, d.SF_ID SchoolForce__Student__c, e.ID SchoolForce__Student_Section__c, 1 SchoolForce__Valid_Grade__c
	from #MP_Grades_Temp (nolock) a 
	inner join Data_Services.dbo.Master_Assignment_MP (nolock) b on cast(a.SchoolForce__Due_Date__c as date) = cast(b.SchoolForce__Due_Date__c as date) and a.SchoolForce__Name_in_Gradebook__c = b.SchoolForce__Name_in_Gradebook__c and
	a.SchoolForce__Time__c = b.SchoolForce__Time__c and a.SchoolForce__Section__c = b.SchoolForce__Section__c
	inner join Data_Services.dbo.MP_Grades (nolock) c on a.Student_ID = c.Student_ID and a.Class_Section_ID = c.Class_Section_ID and a.Marking_Period = c.Marking_Period
	inner join Data_Services.dbo.Master_Student (nolock) d on a.Student_ID = d.Student_ID
	inner join Data_Services.dbo.Master_Student_Section (nolock) e on a.SchoolForce__Section__c = e.SchoolForce__Section__c and d.SF_ID = e.SchoolForce__Student__c
	left outer join Data_Services.dbo.Master_Grade_MP (nolock) f on b.ID = f.SchoolForce__Assignment__c and a.SchoolForce__Course__c = f.SchoolForce__Course__c and Weighted_Value = f.SchoolForce__Grade_Number__c
	and a.SchoolForce__Time__c = f.SchoolForce__Time__c and d.SF_ID = f.SchoolForce__Student__c and e.ID = f.SchoolForce__Student_Section__c
	where f.SchoolForce__Assignment__c is null and f.SchoolForce__Course__c is null 
	and f.SchoolForce__Grade_Number__c is null and f.SchoolForce__Time__c is null and f.SchoolForce__Student__c is null and f.SchoolForce__Student_Section__c is null
	and c.District = @District

	update Data_Services.dbo.SF_Grade_MP set SchoolForce__External_Id__c = 'OCPS_MP_Grade_' + cast(ID as varchar(10))

	insert into Data_Services.dbo.SF_Grade_MP(SchoolForce__Assignment__c, SchoolForce__Assignment_Weighting__c, SchoolForce__Course__c, SchoolForce__Grade_Number__c, SchoolForce__Entered_Grade__c,
	SchoolForce__Points_Grade__c, SchoolForce__Possible_Points__c, SchoolForce__Time__c, SchoolForce__Student__c, SchoolForce__Student_Section__c, SchoolForce__Valid_Grade__c, SchoolForce__External_Id__c)
	select b.ID [SchoolForce__Assignment__c], 1 SchoolForce__Assignment_Weighting__c, a.SchoolForce__Course__c, Weighted_Value SchoolForce__Grade_Number__c, Grade_Value SchoolForce__Entered_Grade__c,
	0 SchoolForce__Points_Grade__c, 100 SchoolForce__Possible_Points__c, a.SchoolForce__Time__c, d.SF_ID SchoolForce__Student__c, e.ID SchoolForce__Student_Section__c, 1 SchoolForce__Valid_Grade__c, f.SchoolForce__External_Id__c
	from #MP_Grades_Temp (nolock) a 
	inner join Data_Services.dbo.Master_Assignment_MP (nolock) b on cast(a.SchoolForce__Due_Date__c as date) = cast(b.SchoolForce__Due_Date__c as date) and a.SchoolForce__Name_in_Gradebook__c = b.SchoolForce__Name_in_Gradebook__c and
	a.SchoolForce__Time__c = b.SchoolForce__Time__c and a.SchoolForce__Section__c = b.SchoolForce__Section__c
	inner join Data_Services.dbo.MP_Grades (nolock) c on a.Student_ID = c.Student_ID and a.Class_Section_ID = c.Class_Section_ID and a.Marking_Period = c.Marking_Period
	inner join Data_Services.dbo.Master_Student (nolock) d on a.Student_ID = d.Student_ID
	inner join Data_Services.dbo.Master_Student_Section (nolock) e on a.SchoolForce__Section__c = e.SchoolForce__Section__c and d.SF_ID = e.SchoolForce__Student__c
	inner join Data_Services.dbo.Master_Grade_MP (nolock) f on 
	b.ID = f.SchoolForce__Assignment__c 
	and a.SchoolForce__Course__c = f.SchoolForce__Course__c 
	and a.SchoolForce__Time__c = f.SchoolForce__Time__c 
	and d.SF_ID = f.SchoolForce__Student__c 
	and e.ID = f.SchoolForce__Student_Section__c
	where c.Weighted_Value <> f.SchoolForce__Grade_Number__c

	update Data_Services.dbo.SF_Grade_MP set SchoolForce__Entered_Grade__c = [SchoolForce__Grade_Number__c]
END

if @District = 'KCPS'
BEGIN


	SELECT Name
		, Assignment_Library__c
		, SchoolForce__Due_Date__c
		, SchoolForce__Picklist_Value__c
		, SchoolForce__Include_in_Final_Grade__c
		, SchoolForce__Name_in_Gradebook__c
		, SchoolForce__Possible_Points__c
		, SchoolForce__Time__c
		, min(SchoolForce__Section__c) SchoolForce__Section__c
		, SchoolForce__Weighting_Value__c
		, Student_ID, Marking_Period
		, Class_Section_ID
		, GPA_Value
		, SchoolForce__Course__c
	INTO #MP_Grades_Temp1
	FROM 
	(SELECT DISTINCT 'Reporting Period Course Grade' Name
		, k.ID Assignment_Library__c
		,End_Date__c [SchoolForce__Due_Date__c]
		,'a1h36000000yQ4CAAU' [SchoolForce__Picklist_Value__c]
		, 1 [SchoolForce__Include_in_Final_Grade__c]
		, k.Marking_Period_2 [SchoolForce__Name_in_Gradebook__c]
		,'0' [SchoolForce__Possible_Points__c]
		,j.ID [SchoolForce__Time__c]
		, d.SF_ID [SchoolForce__Section__c]
		, 1 [SchoolForce__Weighting_Value__c]
		,a.Student_ID
		,a.Marking_Period
		,a.Class_Section_ID
		,a.GPA_Value
		,l.ID SchoolForce__Course__c
	 FROM Data_Services.dbo.MP_Grades (nolock) a 
	 INNER JOIN Data_Services.dbo.Master_Student (nolock) c ON a.Student_ID = c.Student_ID 
	 INNER JOIN Data_Services.dbo.School_Lookup_16_17 (nolock) h ON c.SchoolForce__Setup__C = h.Setup_14_15 
	 INNER JOIN SDW_Stage_Prod_17.dbo.Setup__c (nolock) i ON h.Account_ID = i.[School__c] 
	 INNER JOIN SDW_Stage_Prod_17.dbo.Time_Element__c (nolock) j ON i.[Term__c] = j.[Parent_Time_Element__c] 
	 INNER JOIN (SELECT MIN(a.ID) ID
						, Student_ID
						, Class_Section_ID
						, Section_ID
						, b.[SchoolForce__School__c]
						, Section_Type, c.SF_ID
						, c.Source_School_ID School_ID 
				FROM Data_Services.dbo.Master_Student_Section (nolock) a 
				INNER JOIN Data_Services.dbo.Master_Student (nolock) b ON a.SchoolForce__Student__c = b.SF_ID 
				INNER JOIN (SELECT DISTINCT SF_ID
								 , Class_Section_ID
								 , b.ID Section_ID
								 , Section_Type
								 , Source_School_ID 
							FROM Data_Services.dbo.Master_Section (nolock) a 
							INNER JOIN SDW_Stage_Prod_17.dbo.Course__c (nolock) b ON a.Section_Type = b.Name
							WHERE SF_ID is not null) c ON a.SchoolForce__Section__c = c.SF_ID
							GROUP BY Student_ID
									, Class_Section_ID
									, Section_ID, b.[SchoolForce__School__c]
									, Section_Type
									, c.SF_ID
									, b.School_ID
									, c.Source_School_ID) d ON a.Student_ID = d.Student_ID AND a.Class_Section_ID = d.Class_Section_ID 
				INNER JOIN Data_Services.dbo.vw_Master_Assignment_Library_MP_17 (nolock) k ON a.Marking_Period = k.Marking_Period_2 AND d.Section_Type = k.Section_Type_2 
				INNER JOIN SDW_Stage_Prod_17.dbo.Course__c (nolock) l ON d.Section_Type = l.Name
				WHERE a.Marking_Period IS NOT NULL AND YEAR(Year_End__c) = 2017 AND REPLACE(j.Name__c,'Quarter ','Q') = a.Marking_Period AND l.Reference_Id__c like '%CY%' and a.district = 'kcps') a
				GROUP BY Name
						, Assignment_Library__c
						, SchoolForce__Due_Date__c
						, SchoolForce__Picklist_Value__c
						, SchoolForce__Include_in_Final_Grade__c
						, SchoolForce__Name_in_Gradebook__c
						, SchoolForce__Possible_Points__c
						, SchoolForce__Time__c
						, SchoolForce__Weighting_Value__c
						, Student_ID, Marking_Period
						, Class_Section_ID
						, GPA_Value
						, SchoolForce__Course__c

	delete from Data_Services.dbo.SF_Grade_MP WHERE SchoolForce__External_Id__c like @District+'_MP_%' 

	INSERT INTO Data_Services.dbo.SF_Grade_MP(SchoolForce__Assignment__c
		, SchoolForce__Assignment_Weighting__c
		, SchoolForce__Course__c
		, SchoolForce__Grade_Number__c
		, SchoolForce__Entered_Grade__c
		, SchoolForce__Points_Grade__c
		, SchoolForce__Possible_Points__c
		, SchoolForce__Time__c
		, SchoolForce__Student__c
		, SchoolForce__Student_Section__c
		, SchoolForce__Valid_Grade__c)
	SELECT b.ID [SchoolForce__Assignment__c]
		, 1 SchoolForce__Assignment_Weighting__c
		, a.SchoolForce__Course__c
		, Weighted_Value SchoolForce__Grade_Number__c
		, Grade_Value SchoolForce__Entered_Grade__c
		, 0 SchoolForce__Points_Grade__c
		, 100 SchoolForce__Possible_Points__c
		, a.SchoolForce__Time__c
		, d.SF_ID SchoolForce__Student__c
		, e.ID SchoolForce__Student_Section__c
		, 1 SchoolForce__Valid_Grade__c
	FROM #MP_Grades_Temp1 (nolock) a INNER JOIN 
	Data_Services.dbo.Master_Assignment_MP (nolock) b ON 
		CAST(a.SchoolForce__Due_Date__c as date) = cast(b.SchoolForce__Due_Date__c as date) AND
		a.SchoolForce__Name_in_Gradebook__c = b.SchoolForce__Name_in_Gradebook__c AND
		a.SchoolForce__Time__c = b.SchoolForce__Time__c AND 
		a.SchoolForce__Section__c = b.SchoolForce__Section__c INNER JOIN 
	Data_Services.dbo.MP_Grades (nolock) c ON 
		a.Student_ID = c.Student_ID AND
		a.Class_Section_ID = c.Class_Section_ID AND 
		a.Marking_Period = c.Marking_Period INNER JOIN 
	Data_Services.dbo.Master_Student (nolock) d ON 
		a.Student_ID = d.Student_ID INNER JOIN
	Data_Services.dbo.Master_Student_Section (nolock) e ON 
		a.SchoolForce__Section__c = e.SchoolForce__Section__c AND 
		d.SF_ID = e.SchoolForce__Student__c LEFT OUTER JOIN 
	Data_Services.dbo.Master_Grade_MP (nolock) f ON 
		b.ID = f.SchoolForce__Assignment__c AND 
		a.SchoolForce__Course__c = f.SchoolForce__Course__c AND 
		Weighted_Value = f.SchoolForce__Grade_Number__c AND 
		a.SchoolForce__Time__c = f.SchoolForce__Time__c AND 
		d.SF_ID = f.SchoolForce__Student__c AND 
		e.ID = f.SchoolForce__Student_Section__c
	WHERE f.SchoolForce__Assignment__c IS NULL AND 
		f.SchoolForce__Course__c IS NULL AND 
		f.SchoolForce__Grade_Number__c IS NULL AND 
		f.SchoolForce__Time__c IS NULL AND 
		f.SchoolForce__Student__c IS NULL AND 
		f.SchoolForce__Student_Section__c IS NULL

	UPDATE Data_Services.dbo.SF_Grade_MP SET SchoolForce__External_Id__c = 'KCPS_MP_Grade_' + cast(ID as varchar(10))
	WHERE SchoolForce__External_Id__c IS NULL

	INSERT INTO Data_Services.dbo.SF_Grade_MP(SchoolForce__Assignment__c
		, SchoolForce__Assignment_Weighting__c
		, SchoolForce__Course__c
		, SchoolForce__Grade_Number__c
		, SchoolForce__Entered_Grade__c
		, SchoolForce__Points_Grade__c
		, SchoolForce__Possible_Points__c
		, SchoolForce__Time__c
		, SchoolForce__Student__c
		, SchoolForce__Student_Section__c
		, SchoolForce__Valid_Grade__c
		, SchoolForce__External_Id__c)
	
	SELECT b.ID [SchoolForce__Assignment__c]
	, 1 SchoolForce__Assignment_Weighting__c
	, a.SchoolForce__Course__c
	, Weighted_Value SchoolForce__Grade_Number__c
	, Grade_Value SchoolForce__Entered_Grade__c
	, 0 SchoolForce__Points_Grade__c
	, 100 SchoolForce__Possible_Points__c
	, a.SchoolForce__Time__c
	, d.SF_ID SchoolForce__Student__c
	, e.ID SchoolForce__Student_Section__c
	, 1 SchoolForce__Valid_Grade__c
	, f.SchoolForce__External_Id__c
	FROM #MP_Grades_Temp1 (nolock) a INNER JOIN 
	Data_Services.dbo.Master_Assignment_MP (nolock) b ON 
		CAST(a.SchoolForce__Due_Date__c as date) = CAST(b.SchoolForce__Due_Date__c as date) AND 
		a.SchoolForce__Name_in_Gradebook__c = b.SchoolForce__Name_in_Gradebook__c AND
		a.SchoolForce__Time__c = b.SchoolForce__Time__c AND 
		a.SchoolForce__Section__c = b.SchoolForce__Section__c INNER JOIN 
	Data_Services.dbo.MP_Grades (nolock) c ON 
		a.Student_ID = c.Student_ID AND 
		a.Class_Section_ID = c.Class_Section_ID AND 
		a.Marking_Period = c.Marking_Period INNER JOIN 
	Data_Services.dbo.Master_Student (nolock) d ON 
		a.Student_ID = d.Student_ID INNER JOIN 
	Data_Services.dbo.Master_Student_Section (nolock) e ON 
		a.SchoolForce__Section__c = e.SchoolForce__Section__c AND 
		d.SF_ID = e.SchoolForce__Student__c INNER JOIN 
	Data_Services.dbo.Master_Grade_MP (nolock) f ON 
		b.ID = f.SchoolForce__Assignment__c AND
		a.SchoolForce__Course__c = f.SchoolForce__Course__c AND 
		a.SchoolForce__Time__c = f.SchoolForce__Time__c AND 
		d.SF_ID = f.SchoolForce__Student__c AND 
		e.ID = f.SchoolForce__Student_Section__c
	WHERE c.Weighted_Value <> f.SchoolForce__Grade_Number__c

	--UPDATE Data_Services.dbo.SF_Grade_MP SET SchoolForce__Entered_Grade__c = [SchoolForce__Grade_Number__c]

END

IF @district = 'SJ'
BEGIN

	select Name, Assignment_Library__c, SchoolForce__Due_Date__c, SchoolForce__Picklist_Value__c, SchoolForce__Include_in_Final_Grade__c, SchoolForce__Name_in_Gradebook__c, 
	SchoolForce__Possible_Points__c, SchoolForce__Time__c, 
	min(SchoolForce__Section__c) SchoolForce__Section__c, 
	SchoolForce__Weighting_Value__c, Student_ID, Marking_Period, Class_Section_ID, GPA_Value, SchoolForce__Course__c
	into #MP_Grades_Temp2
	from 
	(select distinct 
	'Reporting Period Course Grade' Name, 
	k.ID Assignment_Library__c,
	End_Date__c [SchoolForce__Due_Date__c],
	(select [Value] from [Data_Services].[dbo].[Settings] where [Name] = 'Grade_MP.Picklist_Value') [SchoolForce__Picklist_Value__c], 
	1 [SchoolForce__Include_in_Final_Grade__c], 
	k.Marking_Period_2 [SchoolForce__Name_in_Gradebook__c],
	100 [SchoolForce__Possible_Points__c],
	j.ID [SchoolForce__Time__c], 
	d.SF_ID [SchoolForce__Section__c], 
	1 [SchoolForce__Weighting_Value__c]
	,a.Student_ID
	,a.Marking_Period
	,a.Class_Section_ID
	,a.GPA_Value
	,l.ID SchoolForce__Course__c
	-- into SF_Grade_MP
	from Data_Services.dbo.MP_Grades (nolock) a
	inner join Data_Services.dbo.Master_Student (nolock) c on a.Student_ID = c.Student_ID  --and substring(a.Class_Section_ID, 1, 4) = c.School_ID
	inner join Data_Services.dbo.School_Lookup_16_17 (nolock) h on c.SchoolForce__Setup__C = h.Setup_14_15 and h.Source_School_ID = c.School_ID
	inner join sdw_stage_prod_17.dbo.Setup__c (nolock) i on h.Account_ID = i.[School__c]
	inner join sdw_stage_prod_17.dbo.Time_Element__c (nolock) j on i.[Term__c] = j.[Parent_Time_Element__c]
	inner join 
	(select min(a.ID) ID
			, Student_ID
			, Class_Section_ID
			, Section_ID
			, b.[SchoolForce__School__c]
			, Section_Type, c.SF_ID
			, c.Source_School_ID School_ID 
	from Data_Services.dbo.Master_Student_Section (nolock) a 
	inner join Data_Services.dbo.Master_Student (nolock) b on a.SchoolForce__Student__c = b.SF_ID 
	inner join (select distinct SF_ID
					   , Class_Section_ID
					   , b.ID Section_ID
					   , Section_Type
					   , Source_School_ID 
			    from Data_Services.dbo.Master_Section (nolock) a 
				inner join sdw_stage_prod_17.dbo.Course__c (nolock) b on a.Section_Type = b.Name where SF_ID is not null) c on a.SchoolForce__Section__c = c.SF_ID 
				group by Student_ID
						, Class_Section_ID
						, Section_ID
						, b.[SchoolForce__School__c]
						, Section_Type
						, c.SF_ID
						, b.School_ID
						, c.Source_School_ID) d on a.Student_ID = d.Student_ID and a.Class_Section_ID = d.Class_Section_ID --and substring(a.Class_Section_ID, 1, 4) = d.School_ID
	inner join Data_Services.dbo.vw_Master_Assignment_Library_MP_17 (nolock) k on (a.Marking_Period = k.Marking_Period_2 or a.Marking_Period = k.Marking_Period_3) and d.Section_Type = k.Section_Type_2
	inner join sdw_stage_prod_17.dbo.Course__c (nolock) l on d.Section_Type = l.Name
	where a.Marking_Period is not null 
	--and schoolforce__name_in_gradebook__C like '%semes%'
	and year(Year_End__c) = 2017
	and( REPLACE(j.Name__c,'TRIMESTER ','T') = a.Marking_Period OR REPLACE(j.Name__c,'Quarter ','Q') = a.Marking_Period  OR REPLACE(j.Name__c,'Semester ','S') = a.Marking_Period) 
	and l.Reference_Id__c like '%CY%' AND A.District = 'sj') a
	group by Name, Assignment_Library__c, SchoolForce__Due_Date__c, SchoolForce__Picklist_Value__c, SchoolForce__Include_in_Final_Grade__c, SchoolForce__Name_in_Gradebook__c, 
	SchoolForce__Possible_Points__c, SchoolForce__Time__c, SchoolForce__Weighting_Value__c, Student_ID, Marking_Period, Class_Section_ID, GPA_Value, SchoolForce__Course__c
	
	delete from Data_Services.dbo.SF_Grade_MP where SchoolForce__External_Id__c like '%sj%'

	insert into Data_Services.dbo.SF_Grade_MP(SchoolForce__Assignment__c, SchoolForce__Assignment_Weighting__c, SchoolForce__Course__c, SchoolForce__Grade_Number__c, SchoolForce__Entered_Grade__c,
	SchoolForce__Points_Grade__c, SchoolForce__Possible_Points__c, SchoolForce__Time__c, SchoolForce__Student__c, SchoolForce__Student_Section__c, SchoolForce__Valid_Grade__c)
	select b.ID [SchoolForce__Assignment__c], 1 SchoolForce__Assignment_Weighting__c, a.SchoolForce__Course__c, Weighted_Value SchoolForce__Grade_Number__c, Grade_Value SchoolForce__Entered_Grade__c,
	0 SchoolForce__Points_Grade__c, 100 SchoolForce__Possible_Points__c, a.SchoolForce__Time__c, d.SF_ID SchoolForce__Student__c, e.ID SchoolForce__Student_Section__c, 1 SchoolForce__Valid_Grade__c
	from #MP_Grades_Temp2 (nolock) a 
	inner join Data_Services.dbo.Master_Assignment_MP (nolock) b on cast(a.SchoolForce__Due_Date__c as date) = cast(b.SchoolForce__Due_Date__c as date) and a.SchoolForce__Name_in_Gradebook__c = b.SchoolForce__Name_in_Gradebook__c and
	a.SchoolForce__Time__c = b.SchoolForce__Time__c and a.SchoolForce__Section__c = b.SchoolForce__Section__c
	inner join Data_Services.dbo.MP_Grades (nolock) c on a.Student_ID = c.Student_ID and a.Class_Section_ID = c.Class_Section_ID and a.Marking_Period = c.Marking_Period
	inner join Data_Services.dbo.Master_Student (nolock) d on a.Student_ID = d.Student_ID
	inner join Data_Services.dbo.Master_Student_Section (nolock) e on a.SchoolForce__Section__c = e.SchoolForce__Section__c and d.SF_ID = e.SchoolForce__Student__c
	left outer join Data_Services.dbo.Master_Grade_MP (nolock) f on b.ID = f.SchoolForce__Assignment__c and a.SchoolForce__Course__c = f.SchoolForce__Course__c and isnull(Weighted_Value,'') = isnull(f.SchoolForce__Grade_Number__c,'')
	and a.SchoolForce__Time__c = f.SchoolForce__Time__c and d.SF_ID = f.SchoolForce__Student__c and e.ID = f.SchoolForce__Student_Section__c
	where f.SchoolForce__Assignment__c is null and f.SchoolForce__Course__c is null 
	and f.SchoolForce__Grade_Number__c is null and f.SchoolForce__Time__c is null and f.SchoolForce__Student__c is null and f.SchoolForce__Student_Section__c is null

	update Data_Services.dbo.SF_Grade_MP set SchoolForce__External_Id__c = 'SJ_MP_Grade_' + cast(ID as varchar(10))
	WHERE SchoolForce__External_Id__c IS NULL

	insert into Data_Services.dbo.SF_Grade_MP(SchoolForce__Assignment__c, SchoolForce__Assignment_Weighting__c, SchoolForce__Course__c, SchoolForce__Grade_Number__c, SchoolForce__Entered_Grade__c,
	SchoolForce__Points_Grade__c, SchoolForce__Possible_Points__c, SchoolForce__Time__c, SchoolForce__Student__c, SchoolForce__Student_Section__c, SchoolForce__Valid_Grade__c, SchoolForce__External_Id__c)
	select b.ID [SchoolForce__Assignment__c], 1 SchoolForce__Assignment_Weighting__c, a.SchoolForce__Course__c, Weighted_Value SchoolForce__Grade_Number__c, Grade_Value SchoolForce__Entered_Grade__c,
	0 SchoolForce__Points_Grade__c, 100 SchoolForce__Possible_Points__c, a.SchoolForce__Time__c, d.SF_ID SchoolForce__Student__c, e.ID SchoolForce__Student_Section__c, 1 SchoolForce__Valid_Grade__c, f.SchoolForce__External_Id__c
	from #MP_Grades_Temp2 (nolock) a 
	inner join Data_Services.dbo.Master_Assignment_MP (nolock) b on cast(a.SchoolForce__Due_Date__c as date) = cast(b.SchoolForce__Due_Date__c as date) and a.SchoolForce__Name_in_Gradebook__c = b.SchoolForce__Name_in_Gradebook__c and
	a.SchoolForce__Time__c = b.SchoolForce__Time__c and a.SchoolForce__Section__c = b.SchoolForce__Section__c
	inner join Data_Services.dbo.MP_Grades (nolock) c on a.Student_ID = c.Student_ID and a.Class_Section_ID = c.Class_Section_ID and a.Marking_Period = c.Marking_Period
	inner join Data_Services.dbo.Master_Student (nolock) d on a.Student_ID = d.Student_ID
	inner join Data_Services.dbo.Master_Student_Section (nolock) e on a.SchoolForce__Section__c = e.SchoolForce__Section__c and d.SF_ID = e.SchoolForce__Student__c
	inner join Data_Services.dbo.Master_Grade_MP (nolock) f on 
	b.ID = f.SchoolForce__Assignment__c 
	and a.SchoolForce__Course__c = f.SchoolForce__Course__c 
	and a.SchoolForce__Time__c = f.SchoolForce__Time__c 
	and d.SF_ID = f.SchoolForce__Student__c 
	and e.ID = f.SchoolForce__Student_Section__c
	where isnull(c.Weighted_Value,'') <> isnull(f.SchoolForce__Grade_Number__c,'')

	--update Data_Services.dbo.SF_Grade_MP set SchoolForce__Entered_Grade__c = [SchoolForce__Grade_Number__c]

	select * into #SF_Grade_MP
	from Data_Services.dbo.SF_Grade_MP where SchoolForce__External_Id__c like 'SJ%'

alter table #SF_Grade_MP alter column SchoolForce__Grade_Number__c float null
update #SF_Grade_MP set SchoolForce__Grade_Number__c = 100.00 where SchoolForce__Grade_Number__c >= 100
--alter table #SF_Grade_MP alter column SchoolForce__Grade_Number__c varchar(256) null
delete from #SF_Grade_MP where SchoolForce__Grade_Number__c < 100 or SchoolForce__Grade_Number__c is null

update Data_Services.dbo.SF_Grade_MP 
set Data_Services.dbo.SF_Grade_MP.SchoolForce__Grade_Number__c = ran.SchoolForce__Grade_Number__c
FROM
    Data_Services.dbo.SF_Grade_MP  SI
INNER JOIN
    #SF_Grade_MP RAN
ON 
    SI.SchoolForce__External_Id__c = RAN.SchoolForce__External_Id__c

update Data_Services.dbo.SF_Grade_MP set SchoolForce__Entered_Grade__c = null where SchoolForce__Entered_Grade__c in ('NM','NC')

update Data_Services.dbo.SF_Grade_MP set SchoolForce__Entered_Grade__c = 'F' where SchoolForce__Entered_Grade__c in ('F-','F+')

END
END


GO
