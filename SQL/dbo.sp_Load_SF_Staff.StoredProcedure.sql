USE [Data_Services]
GO
/****** Object:  StoredProcedure [dbo].[sp_Load_SF_Staff]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Load_SF_Staff]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--Clear Table for Staff load
TRUNCATE TABLE dbo.SF_Staff
--Pull and structure data to load for transfer staff to SchoolForce
INSERT INTO dbo.SF_Staff (SchoolForce__First_Name_Staff__c, SchoolForce__Staff_Last_Name__c, SchoolForce__Organization__c,Source_School_ID, DistStaffID, SchoolForce__Active__c, SchoolForce__Individual__c)

SELECT TL.FirstName AS SchoolForce__First_Name_Staff__c
	,TL.LastName AS SchoolForce__Staff_Last_Name__c
	,S.Account_ID AS SchoolForce__Organization__c
	,S.Source_School_ID
	,TL.DistStaffID
	,SchoolForce__Active__c ='1'
	,sdc.id AS SchoolForce__Individual__c
FROM
	(SELECT School_Name,b.Math_Teacher_Name AS Teacher_Name
FROM 
	Student a INNER JOIN Class b 
		ON a.Student_ID = b.Student_ID) AS T INNER JOIN 
	School_Lookup S 
		ON T.School_Name = S.Source_School_Name INNER JOIN 
	vw_Teacher_List TL
		ON TL.Teacher = T.Teacher_Name INNER JOIN 
	SF_Contact_Staff CS
		ON Convert(varchar,TL.DistStaffID) + '_' + Replace(Rand(TL.DistStaffID),'.','Qz')= CS.Email INNER JOIN 
	SDW_Stage.dbo.Contact SDC
		ON CS.Email = SDC.SchoolForce__ID__c 
GROUP BY S.Account_ID,S.Source_School_ID,TL.FirstName,TL.LastName,TL.DistStaffID,sdc.id
END



GO
