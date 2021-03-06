USE [Data_Services]
GO
/****** Object:  StoredProcedure [dbo].[sp_1a_Student_Contact]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_1a_Student_Contact]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO Data_Services.dbo.Master_Contact_Student(AccountID
	, RecordType
	, Student_ID
	, Last_Name
	, First_Name
	, Date_Of_Birth
	, Sex
	, Ethnicity
	, Disability_Flag
	, ELL_Flag
	, Home_Language
	, Address_Line_1
	, City
	, State
	, Zip
	, Home_Phone
	, Race
	, SF_ID
	)
	SELECT a.AccountID
	, a.RecordType
	, a.Student_ID
	, a.Last_Name
	, a.First_Name
	, a.Date_Of_Birth
	, a.Sex
	, a.Ethnicity
	, a.Disability_Flag
	, a.ELL_Flag
	, a.Home_Language
	, a.Address_Line_1
	, a.City
	, a.State
	, a.Zip
	, a.Home_Phone
	, a.Race
	, b.Id SF_ID
	FROM Data_Services.dbo.SF_Contact_Student (NOLOCK) a INNER JOIN 
	SDW_Stage_Prod_17.dbo.Contact (NOLOCK) b ON 
		a.Student_ID = b.ID__c LEFT OUTER JOIN 
	Data_Services.dbo.Master_Contact_Student (NOLOCK) c ON 
		a.Student_ID = c.Student_ID
	WHERE c.Student_ID IS NULL

END

GO
