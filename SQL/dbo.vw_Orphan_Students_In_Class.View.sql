USE [Data_Services]
GO
/****** Object:  View [dbo].[vw_Orphan_Students_In_Class]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_Orphan_Students_In_Class]
AS
SELECT DISTINCT a.Student_ID as OrphanID,b.Student_ID 
FROM Class_Processed AS a LEFT JOIN 
	SF_Student b WITH(NOLOCK)ON 
		a.Student_ID = b.Student_ID
WHERE b.Student_ID is null 


GO
