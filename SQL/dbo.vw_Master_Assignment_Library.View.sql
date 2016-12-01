USE [Data_Services]
GO
/****** Object:  View [dbo].[vw_Master_Assignment_Library]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_Master_Assignment_Library]
AS
SELECT     ID, '1' Marking_Period, 'Q1' Marking_Period_2, 'Homework' Assignment_Type, 'Math' Section_Type, 'Math' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%1%Math%Homework%'
UNION
SELECT     ID, '2' Marking_Period, 'Q2' Marking_Period_2, 'Homework' Assignment_Type, 'Math' Section_Type, 'Math' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%2%Math%Homework%'
UNION
SELECT     ID, '3' Marking_Period, 'Q3' Marking_Period_2, 'Homework' Assignment_Type, 'Math' Section_Type, 'Math' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%3%Math%Homework%'
UNION
SELECT     ID, '4' Marking_Period, 'Q4' Marking_Period_2, 'Homework' Assignment_Type, 'Math' Section_Type, 'Math' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%4%Math%Homework%'
UNION
SELECT     ID, '1' Marking_Period, 'Q1' Marking_Period_2, 'Homework' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%1%ELA%Homework%'
UNION
SELECT     ID, '2' Marking_Period, 'Q2' Marking_Period_2, 'Homework' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%2%ELA%Homework%'
UNION
SELECT     ID, '3' Marking_Period, 'Q3' Marking_Period_2, 'Homework' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%3%ELA%Homework%'
UNION
SELECT     ID, '4' Marking_Period, 'Q4' Marking_Period_2, 'Homework' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%4%ELA%Homework%'
UNION
SELECT     ID, '1' Marking_Period, 'Q1' Marking_Period_2, 'Quiz' Assignment_Type, 'Math' Section_Type, 'Math' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%1%Math%Quiz%'
UNION
SELECT     ID, '2' Marking_Period, 'Q2' Marking_Period_2, 'Quiz' Assignment_Type, 'Math' Section_Type, 'Math' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%2%Math%Quiz%'
UNION
SELECT     ID, '3' Marking_Period, 'Q3' Marking_Period_2, 'Quiz' Assignment_Type, 'Math' Section_Type, 'Math' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%3%Math%Quiz%'
UNION
SELECT     ID, '4' Marking_Period, 'Q4' Marking_Period_2, 'Quiz' Assignment_Type, 'Math' Section_Type, 'Math' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%4%Math%Quiz%'
UNION
SELECT     ID, '1' Marking_Period, 'Q1' Marking_Period_2, 'Quiz' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%1%ELA%Quiz%'
UNION
SELECT     ID, '2' Marking_Period, 'Q2' Marking_Period_2, 'Quiz' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%2%ELA%Quiz%'
UNION
SELECT     ID, '3' Marking_Period, 'Q3' Marking_Period_2, 'Quiz' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%3%ELA%Quiz%'
UNION
SELECT     ID, '4' Marking_Period, 'Q4' Marking_Period_2, 'Quiz' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%4%ELA%Quiz%'
UNION
SELECT     ID, '1' Marking_Period, 'Q1' Marking_Period_2, 'Test' Assignment_Type, 'Math' Section_Type, 'Math' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%1%Math%Test%'
UNION
SELECT     ID, '2' Marking_Period, 'Q2' Marking_Period_2, 'Test' Assignment_Type, 'Math' Section_Type, 'Math' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%2%Math%Test%'
UNION
SELECT     ID, '3' Marking_Period, 'Q3' Marking_Period_2, 'Test' Assignment_Type, 'Math' Section_Type, 'Math' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%3%Math%Test%'
UNION
SELECT     ID, '4' Marking_Period, 'Q4' Marking_Period_2, 'Test' Assignment_Type, 'Math' Section_Type, 'Math' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%4%Math%Test%'
UNION
SELECT     ID, '1' Marking_Period, 'Q1' Marking_Period_2, 'Test' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%1%ELA%Test%'
UNION
SELECT     ID, '2' Marking_Period, 'Q2' Marking_Period_2, 'Test' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%2%ELA%Test%'
UNION
SELECT     ID, '3' Marking_Period, 'Q3' Marking_Period_2, 'Test' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%3%ELA%Test%'
UNION
SELECT     ID, '4' Marking_Period, 'Q4' Marking_Period_2, 'Test' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%4%ELA%Test%'
UNION
SELECT     ID, '1' Marking_Period, 'Q1' Marking_Period_2, 'Project' Assignment_Type, 'Math' Section_Type, 'Math'
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%1%Math%Project%'
UNION
SELECT     ID, '2' Marking_Period, 'Q2' Marking_Period_2, 'Project' Assignment_Type, 'Math' Section_Type, 'Math'
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%2%Math%Project%'
UNION
SELECT     ID, '3' Marking_Period, 'Q3' Marking_Period_2, 'Project' Assignment_Type, 'Math' Section_Type, 'Math'
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%3%Math%Project%'
UNION
SELECT     ID, '4' Marking_Period, 'Q4' Marking_Period_2, 'Project' Assignment_Type, 'Math' Section_Type, 'Math'
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%4%Math%Project%'
UNION
SELECT     ID, '1' Marking_Period, 'Q1' Marking_Period_2, 'Project' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%1%ELA%Project%'
UNION
SELECT     ID, '2' Marking_Period, 'Q2' Marking_Period_2, 'Project' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%2%ELA%Project%'
UNION
SELECT     ID, '3' Marking_Period, 'Q3' Marking_Period_2, 'Project' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%3%ELA%Project%'
UNION
SELECT     ID, '4' Marking_Period, 'Q4' Marking_Period_2, 'Project' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%4%ELA%Project%'
UNION
SELECT     ID, '1' Marking_Period, 'Q1' Marking_Period_2, 'Uncategorized' Assignment_Type, 'Math' Section_Type, 'Math' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%1%Math%Uncategorized%'
UNION
SELECT     ID, '2' Marking_Period, 'Q2' Marking_Period_2, 'Uncategorized' Assignment_Type, 'Math' Section_Type, 'Math' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%2%Math%Uncategorized%'
UNION
SELECT     ID, '3' Marking_Period, 'Q3' Marking_Period_2, 'Uncategorized' Assignment_Type, 'Math' Section_Type, 'Math' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%3%Math%Uncategorized%'
UNION
SELECT     ID, '4' Marking_Period, 'Q4' Marking_Period_2, 'Uncategorized' Assignment_Type, 'Math' Section_Type, 'Math' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%4%Math%Uncategorized%'
UNION
SELECT     ID, '1' Marking_Period, 'Q1' Marking_Period_2, 'Uncategorized' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%1%ELA%Uncategorized%'
UNION
SELECT     ID, '2' Marking_Period, 'Q2' Marking_Period_2, 'Uncategorized' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%2%ELA%Uncategorized%'
UNION
SELECT     ID, '3' Marking_Period, 'Q3' Marking_Period_2, 'Uncategorized' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%3%ELA%Uncategorized%'
UNION
SELECT     ID, '4' Marking_Period, 'Q4' Marking_Period_2, 'Uncategorized' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%4%ELA%Uncategorized%'
UNION
SELECT     ID, '1' Marking_Period, 'Q1' Marking_Period_2, 'Classwork' Assignment_Type, 'Math' Section_Type, 'Math' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%1%Math%Classwork%'
UNION
SELECT     ID, '2' Marking_Period, 'Q2' Marking_Period_2, 'Classwork' Assignment_Type, 'Math' Section_Type, 'Math' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%2%Math%Classwork%'
UNION
SELECT     ID, '3' Marking_Period, 'Q3' Marking_Period_2, 'Classwork' Assignment_Type, 'Math' Section_Type, 'Math' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%3%Math%Classwork%'
UNION
SELECT     ID, '4' Marking_Period, 'Q4' Marking_Period_2, 'Classwork' Assignment_Type, 'Math' Section_Type, 'Math' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%4%Math%Classwork%'
UNION
SELECT     ID, '1' Marking_Period, 'Q1' Marking_Period_2, 'Classwork' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%1%ELA%Classwork%'
UNION
SELECT     ID, '2' Marking_Period, 'Q2' Marking_Period_2, 'Classwork' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%2%ELA%Classwork%'
UNION
SELECT     ID, '3' Marking_Period, 'Q3' Marking_Period_2, 'Classwork' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%3%ELA%Classwork%'
UNION
SELECT     ID, '4' Marking_Period, 'Q4' Marking_Period_2, 'Classwork' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%4%ELA%Classwork%'


GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[21] 4[20] 2[42] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_Master_Assignment_Library'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_Master_Assignment_Library'
GO
