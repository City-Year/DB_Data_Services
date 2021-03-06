USE [Data_Services]
GO
/****** Object:  StoredProcedure [dbo].[sp_School_Lookup_Logic]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_School_Lookup_Logic]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	insert into Data_Services.dbo.School_Lookup(School_Name, Account_ID, School_Grades, County, Source_School_Name, Source_School_ID, Setup_14_15)
	select a.Name School_Name, a.ID Account_ID, 'N/A' School_Grades, 'NOLA' County, a.Name Source_School_Name,
	case a.Name
		WHEN 'Samuel J. Green Charter School' Then 1
		WHEN 'Arthur Ashe' THEN 2
		WHEN 'Phillis Wheatley Community School' THEN 3
		WHEN 'Langston Hughes Charter School' THEN 4
		WHEN 'Joseph S. Clark High School' THEN 5
	END Source_School_ID, b.ID Setup_14_15 
	from SDW_Stage_Prod.dbo.Account (nolock) a 
	inner join SDW_Stage_Prod.dbo.Setup__c (nolock) b on a.ID = b.School__c
	left outer join Data_Services.dbo.School_Lookup (nolock) d on a.name = d.School_Name and a.ID = d.Account_ID
	where BillingState = 'LA' and BillingCity = 'New Orleans' and d.School_Name is null and d.Account_ID is null

	insert into Data_Services.dbo.School_Lookup(School_Name, Account_ID, School_Grades, County, Source_School_Name, Source_School_ID, Setup_14_15)
	select a.Name School_Name, a.ID Account_ID, 'N/A' School_Grades, 'SJ' County, 
	case a.Name
		when 'Dorsa ES' then 'A.J. Dorsa Elementary School'
--		when' ' then 'Aptitud Academy'
		when 'Aptitude Community at Goss ES' then 'Aptitud Community Academy at Goss'
		when 'Chavez ES' then 'Cesar Chavez Elementary School'
		when 'Arbuckle ES' then 'Clyde Arbuckle Elementary School'
		when 'Fischer MS' then 'Clyde L. Fischer Middle School'
		when 'Donald J. Meyer Elementary School' then 'Donald Meyer Elementary School'
		when 'Cureton ES' then 'Horace Cureton Elementary School'
		when 'Mathson MS' then 'Lee Mathson Middle School'
		when 'Ocala MS' then 'Ocala Middle School'
--		when' ' then 'Renaissance at Mathson'
		when 'San Antonio Elementary School' then 'San Antonio Elementary School'
		when 'Sylvia Cassell Elementary School' then 'Sylvia Cassell Elementary School'
		when 'Ryan ES' then 'Thomas P. Ryan Elementary School'
	End Source_School_Name,
	case a.Name
		when 'Dorsa ES' then 415
--		when '' then 432
		when 'Aptitude Community at Goss ES' then 412
		when 'Chavez ES' then 406
		when 'Arbuckle ES' then 414
		when 'Fischer MS' then 413
		when 'Donald J. Meyer Elementary School' then 418
		when 'Cureton ES' then 401
		when 'Mathson MS' then 405
		when 'Ocala MS' then 426
--		when '' then 491
		when 'San Antonio Elementary School' then 424
		when 'Sylvia Cassell Elementary School' then 420
		when 'Ryan ES' then 410
	END Source_School_ID, b.ID Setup_14_15 
	from SDW_Stage_Prod.dbo.Account (nolock) a 
	inner join SDW_Stage_Prod.dbo.Setup__c (nolock) b on a.ID = b.School__c
	left outer join Data_Services.dbo.School_Lookup (nolock) d on a.name = d.School_Name and a.ID = d.Account_ID
	where BillingState = 'CA' and BillingCity = 'San Jose' and d.School_Name is null and d.Account_ID is null
	order by School_Name

END

GO
