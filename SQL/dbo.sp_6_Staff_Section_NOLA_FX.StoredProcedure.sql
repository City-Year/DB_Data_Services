USE [Data_Services]
GO
/****** Object:  StoredProcedure [dbo].[sp_6_Staff_Section_NOLA_FX]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_6_Staff_Section_NOLA_FX]
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	
	DELETE FROM Data_Services.dbo.SF_Staff_Section WHERE SF_Staff_ID IN (SELECT SF_ID FROM Data_Services.dbo.Master_Staff WHERE  SchoolForce__Organization__c = '0011a00000CbEq4AAF')

	INSERT INTO Data_Services.dbo.SF_Staff_Section(SF_Staff_ID
	, SF_Section_ID
	, Active)

	SELECT DISTINCT b.SF_ID SF_Staff_ID
		, c.SF_ID SF_Section_ID
		, '1' Active
	FROM Data_Services.dbo.Class_Processed (NOLOCK) a INNER JOIN 
	Data_Services.dbo.Master_Staff (NOLOCK) b ON 
		a.Teacher_Name = b.TeacherName INNER JOIN 
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
	WHERE b.SchoolForce__Organization__c = '0011a00000CbEq4AAF' AND 
	d.SchoolForce__Staff__c IS NULL AND SchoolForce__Section__c IS NULL

END


GO
