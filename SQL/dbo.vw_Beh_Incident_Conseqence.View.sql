USE [Data_Services]
GO
/****** Object:  View [dbo].[vw_Beh_Incident_Conseqence]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[vw_Beh_Incident_Conseqence]
AS
SELECT Distinct [Offense],a.Consequence
  FROM [Data_Services].[dbo].[Behavior] a 


GO
