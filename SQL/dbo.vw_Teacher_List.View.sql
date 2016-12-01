USE [Data_Services]
GO
/****** Object:  View [dbo].[vw_Teacher_List]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






/* filter out 'Calculated ADA tracker' and 'Consequence Tracker'*/
CREATE VIEW [dbo].[vw_Teacher_List]
AS
Select Distinct Teacher,B.FirstName,B.LastName,B.DistStaffID from (SELECT Teacher_Name As Teacher FROM Class_Processed)as A inner join ProxyTeacherIDs as B
	on A.Teacher = B.TeacherName 





GO
