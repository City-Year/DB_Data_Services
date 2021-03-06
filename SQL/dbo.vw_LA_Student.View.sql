USE [Data_Services]
GO
/****** Object:  View [dbo].[vw_LA_Student]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [dbo].[vw_LA_Student]
AS
SELECT [Student_ID]
      ,[School_ID]
      ,[School_Name]
      ,[School_Year]
      ,[First_Name]
      ,[Last_Name]
      ,[Grade]
      ,[Date_Of_Birth]
      ,[Sex]
      ,[Ethnicity]
      ,[Race]
      ,[Disability_Flag]
      ,[ELL_Flag]
      ,[Home_Language]
      ,[Address_Line_1]
      ,[Address_Line_2]
      ,[City]
      ,[State]
      ,[Zip]
      ,[Home_Phone]
      ,[District]
      ,[RunDate]
  FROM [Data_Services].[dbo].[Student] Where District = 'LA'



GO
