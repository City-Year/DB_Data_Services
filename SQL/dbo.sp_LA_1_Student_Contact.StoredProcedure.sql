USE [Data_Services]
GO
/****** Object:  StoredProcedure [dbo].[sp_LA_1_Student_Contact]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date	 <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE  PROCEDURE [dbo].[sp_LA_1_Student_Contact]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	

	Delete from Data_Services.dbo.SF_Contact_Student where substring(Student_ID,1,2) = 'LA' 
	--truncate table Data_Services.dbo.Master_Contact_Student

	-- SF_Contact_Student
	INSERT INTO Data_Services.dbo.SF_Contact_Student(AccountID
			,RecordType
			,Student_ID
			,Last_Name
			,First_Name
			,Date_Of_Birth
			,Sex
			,Ethnicity
			,Disability_Flag
			,ELL_Flag
			,Home_Language
			,Address_Line_1
			,City
			,State
			,Zip
			,Home_Phone
			,Race)
	SELECT --(SELECT [Value] FROM [Data_Services].[dbo].[Settings] WHERE [Name] = 'Contact.Account_ID') 
	'0013600000QJeqz' AccountID
	, -- (SELECT ID FROM [SDW_STAGE_PROD_17].[dbo].[RecordType] WHERE [Name] = 'student') 
	'012360000007jgNAAQ' RecordType -- staff 0121a000000VC5xAAG student 0121a000000VC5yAAG
	-- 012550000008VdFAAU (OLD ID)
	, a.District + '_' + cast(cast(a.School_ID as integer) as varchar(10)) + '_' + a.Student_ID Student_ID
	, Last_Name
	, First_Name
	, Date_Of_Birth
	, CASE Sex WHEN 'M' THEN 'Male'
			  ELSE 'Female'
	  END 
	, Ethnicity
	, Disability_Flag
	, CASE ELL_Flag WHEN 'Y' THEN '1' 
			   ELSE '0' 
	  END
	, Home_Language
	, Address_Line_1
	, City
	, State
	, Zip
	, Home_Phone
	, Ethnicity
	FROM Data_Services.dbo.Student (NOLOCK) a 
	left outer join SDW_Stage_PROD_17.dbo.Contact (NOLOCK) b on a.District + '_' + cast(cast(a.School_ID AS INTEGER) AS VARCHAR(4)) + '_' + a.Student_ID = b.ID__c
	WHERE b.ID__c is null
	AND district = 'LA'

	
END


GO
