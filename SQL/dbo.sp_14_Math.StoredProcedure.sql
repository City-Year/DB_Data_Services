USE [Data_Services]
GO
/****** Object:  StoredProcedure [dbo].[sp_14_Math]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_14_Math] @District varchar(255) = null
AS
BEGIN
SET NOCOUNT ON;
	IF @district = 'SJ'
	BEGIN
	delete from Data_Services.dbo.SF_Assessment_Math

	select 
	b.SF_ID Student_ID, 
	(select ID  FROM [sdw_stage_prod_17].[dbo].[Picklist_Value__c] where name = 'CAASPP - Math') SchoolForce__Type__c,
	'Mathematics' SchoolForce__Assessment_Name__c,
	cast(a.Date as date) [Date_Administered__c],
	isnull(Scale_Score, 0) FSA_Math_Score_c,
	isnulL(Profiency_Rating_Level, 'N/A') Local_Benchmark__c
	,b.District + '_' + cast(cast(b.School_ID as integer) as varchar(4)) + '_' + b.Student_ID + '_' [SchoolForce__External_Id__c]
	into #Math1
	from Data_Services.dbo.Assessments (nolock) a
	inner join Data_Services.dbo.Master_Student (Nolock) b on a.Student_ID = b.Student_ID and a.district = 'sj'
	where a.Assessment_Name in ('CAASPP') AND A.Assessment_Subject_Topic = 'MATH'

	insert into Data_Services.dbo.SF_Assessment_Math(Student_ID, SchoolForce__Type__c, SchoolForce__Assessment_Name__c, Date_Administered__c, FSA_Math_Score_c, Local_Benchmark__c, [SchoolForce__External_Id__c])
	select a.Student_ID, a.SchoolForce__Type__c, a.SchoolForce__Assessment_Name__c, a.[Date_Administered__c], a.FSA_Math_Score_c, a.Local_Benchmark__c, a.[SchoolForce__External_Id__c]
	from #Math1 (nolock) a
	left outer join Data_Services.dbo.Master_Assessment_Math (nolock) c
	on a.Student_ID = c.Student_ID and a.SchoolForce__Type__c = c.SchoolForce__Type__c and a.SchoolForce__Assessment_Name__c = c.SchoolForce__Assessment_Name__c and cast(a.Date_Administered__c as date) = cast(c.Date_Administered__c as date) and isnull(a.Local_Benchmark__c, 'N/A') = c.Local_Benchmark__c 
	where c.Student_ID is null	
	and c.SchoolForce__Type__c is null
	and c.SchoolForce__Assessment_Name__c is null	
	and cast(c.Date_Administered__c as date) is null
	and c.Local_Benchmark__c is null

	update Data_Services.dbo.SF_Assessment_Math set [SchoolForce__External_Id__c] = [SchoolForce__External_Id__c] + cast(ID as varchar(5))
	where [SchoolForce__External_Id__c] like 'SJ%'
END

if @District = 'OCPS'
BEGIN
	delete from Data_Services.dbo.SF_Assessment_Math

	select 
	b.SF_ID Student_ID, 
	(select [Value] from [Data_Services].[dbo].[Settings] where [Name] = 'Math.Type') SchoolForce__Type__c,
	'Florida State Assessment Mathematics' SchoolForce__Assessment_Name__c,
	cast(a.Date as date) [Date_Administered__c],
	Scale_Score FSA_Math_Score_c,
	isnull(Profiency_Rating_Level, 'N/A') Local_Benchmark__c
	,b.District + '_' + cast(cast(b.School_ID as integer) as varchar(4)) + '_' + b.Student_ID + '_' [SchoolForce__External_Id__c]
	into #Math
	from Data_Services.dbo.Assessments (nolock) a
	inner join Data_Services.dbo.Master_Student (Nolock) b on a.Student_ID = b.Student_ID
	where a.Assessment_Name in ('BENCHMARKS FSA MATH') 
	and Scale_Score is not null and convert(datetime, a.[Date], 1) >= '1-JAN-15'

	insert into Data_Services.dbo.SF_Assessment_Math(Student_ID, SchoolForce__Type__c, SchoolForce__Assessment_Name__c, Date_Administered__c, FSA_Math_Score_c, Local_Benchmark__c, [SchoolForce__External_Id__c])
	select a.Student_ID, a.SchoolForce__Type__c, a.SchoolForce__Assessment_Name__c, a.[Date_Administered__c], a.FSA_Math_Score_c, a.Local_Benchmark__c, a.[SchoolForce__External_Id__c]
	from #Math (nolock) a
	left outer join Data_Services.dbo.Master_Assessment_Math (nolock) c
	on a.Student_ID = c.Student_ID and a.SchoolForce__Type__c = c.SchoolForce__Type__c and a.SchoolForce__Assessment_Name__c = c.SchoolForce__Assessment_Name__c and cast(a.Date_Administered__c as date) = cast(c.Date_Administered__c as date) and isnull(a.Local_Benchmark__c, 'N/A') = c.Local_Benchmark__c 
	where c.Student_ID is null	
	and c.SchoolForce__Type__c is null
	and c.SchoolForce__Assessment_Name__c is null	
	and cast(c.Date_Administered__c as date) is null
	and c.Local_Benchmark__c is null

	update Data_Services.dbo.SF_Assessment_Math set [SchoolForce__External_Id__c] = [SchoolForce__External_Id__c] + cast(ID as varchar(5))
	where [SchoolForce__External_Id__c] LIKE 'OCPS%'
END
END



GO
