USE [Data_Services]
GO
/****** Object:  View [dbo].[vw_Master_Assignment_Library_MP_17]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_Master_Assignment_Library_MP_17]
AS
SELECT     ID, '1' Marking_Period, 'Q1' Marking_Period_2, 'RC1' Marking_Period_3, 'Reporting Period' Assignment_Type, 'Math' Section_Type, 'Math' Section_Type_2
FROM         SDW_Stage_Prod_17.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%1%Math%Reporting%Site%'
UNION
SELECT     ID, '2' Marking_Period, 'Q2' Marking_Period_2, 'RC2' Marking_Period_3, 'Reporting Period' Assignment_Type, 'Math' Section_Type, 'Math' Section_Type_2
FROM         SDW_Stage_Prod_17.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%2%Math%Reporting%Site%'
UNION
SELECT     ID, '3' Marking_Period, 'Q3' Marking_Period_2, 'RC3' Marking_Period_3, 'Reporting Period' Assignment_Type, 'Math' Section_Type, 'Math' Section_Type_2
FROM         SDW_Stage_Prod_17.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%3%Math%Reporting%Site%'
UNION
SELECT     ID, '4' Marking_Period, 'Q4' Marking_Period_2, 'RC4' Marking_Period_3, 'Reporting Period' Assignment_Type, 'Math' Section_Type, 'Math' Section_Type_2
FROM         SDW_Stage_Prod_17.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%4%Math%Reporting%Site%'
UNION
SELECT     ID, '1' Marking_Period, 'Q1' Marking_Period_2, 'RC1' Marking_Period_3, 'Reporting Period' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod_17.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%1%ELA%Reporting%Site%'
UNION
SELECT     ID, '2' Marking_Period, 'Q2' Marking_Period_2, 'RC2' Marking_Period_3, 'Reporting Period' Assignment_Type, 'ELA' Section_Type,  'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod_17.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%2%ELA%Reporting%Site%'
UNION
SELECT     ID, '3' Marking_Period, 'Q3' Marking_Period_2, 'RC3' Marking_Period_3, 'Reporting Period' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod_17.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%3%ELA%Reporting%Site%'
UNION
SELECT     ID, '4' Marking_Period, 'Q4' Marking_Period_2, 'RC4' Marking_Period_3, 'Reporting Period' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod_17.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%4%ELA%Reporting%Site%'
UNION
SELECT     ID, '1' Marking_Period, 'Trimester 1' Marking_Period_2, 'T1' Marking_Period_3, 'Reporting Period' Assignment_Type, 'Math' Section_Type, 'Math' Section_Type_2
FROM         SDW_Stage_Prod_17.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Tri%1%Math%Reporting%Site%'
UNION
SELECT     ID, '2' Marking_Period, 'Trimester 2' Marking_Period_2, 'T2' Marking_Period_3, 'Reporting Period' Assignment_Type, 'Math' Section_Type, 'Math' Section_Type_2
FROM         SDW_Stage_Prod_17.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Tri%2%Math%Reporting%Site%'
UNION
SELECT     ID, '3' Marking_Period, 'Trimester 3' Marking_Period_2, 'T3' Marking_Period_3, 'Reporting Period' Assignment_Type, 'Math' Section_Type, 'Math' Section_Type_2
FROM         SDW_Stage_Prod_17.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Tri%3%Math%Reporting%Site%'
UNION
SELECT     ID, '1' Marking_Period, 'Trimester 1' Marking_Period_2, 'T1' Marking_Period_3, 'Reporting Period' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod_17.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Tri%1%ELA%Reporting%Site%'
UNION
SELECT     ID, '2' Marking_Period, 'Trimester 2' Marking_Period_2, 'T2' Marking_Period_3, 'Reporting Period' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod_17.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Tri%2%ELA%Reporting%Site%'
UNION
SELECT     ID, '3' Marking_Period, 'Trimester 3' Marking_Period_2, 'T3' Marking_Period_3, 'Reporting Period' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod_17.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Tri%3%ELA%Reporting%Site%'
UNION
SELECT     ID, '1' Marking_Period, 'Semester 1' Marking_Period_2, 'S1' Marking_Period_3, 'Reporting Period' Assignment_Type, 'Math' Section_Type, 'Math' Section_Type_2
FROM         SDW_Stage_Prod_17.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Sem%1%Math%Reporting%Site%'
UNION
SELECT     ID, '2' Marking_Period, 'Semester 2' Marking_Period_2, 'S2' Marking_Period_3, 'Reporting Period' Assignment_Type, 'Math' Section_Type, 'Math' Section_Type_2
FROM         SDW_Stage_Prod_17.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Sem%2%Math%Reporting%Site%'
UNION
SELECT     ID, '1' Marking_Period, 'Semester 1' Marking_Period_2, 'S1' Marking_Period_3, 'Reporting Period' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod_17.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Sem%1%ELA%Reporting%Site%'
UNION
SELECT     ID, '2' Marking_Period, 'Semester 2' Marking_Period_2, 'S2' Marking_Period_3, 'Reporting Period' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod_17.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Sem%2%ELA%Reporting%Site%'
UNION
SELECT     ID, '1' Marking_Period, 'Quarter 1' Marking_Period_2, '1' Marking_Period_3, 'Reporting Period' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod_17.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%1%ELA%Reporting%Site%'
UNION
SELECT     ID, '2' Marking_Period, 'Quarter 2' Marking_Period_2, '2' Marking_Period_3, 'Reporting Period' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod_17.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%2%ELA%Reporting%Site%'
UNION
SELECT     ID, '3' Marking_Period, 'Quarter 3' Marking_Period_2, '3' Marking_Period_3, 'Reporting Period' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod_17.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%3%ELA%Reporting%Site'
UNION
SELECT     ID, '4' Marking_Period, 'Quarter 4' Marking_Period_2, '4' Marking_Period_3, 'Reporting Period' Assignment_Type, 'ELA' Section_Type, 'ELA/Literacy' Section_Type_2
FROM         SDW_Stage_Prod_17.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%4%ELA%Reporting%Site%'
UNION
SELECT     ID, '1' Marking_Period, 'Quarter 1' Marking_Period_2, '1' Marking_Period_3, 'Reporting Period' Assignment_Type, 'MATH' Section_Type, 'MATH' Section_Type_2
FROM         SDW_Stage_Prod_17.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%1%MATH%Reporting%Site%'
UNION
SELECT     ID, '2' Marking_Period, 'Quarter 2' Marking_Period_2, '2' Marking_Period_3, 'Reporting Period' Assignment_Type, 'MATH' Section_Type, 'MATH' Section_Type_2
FROM         SDW_Stage_Prod_17.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%2%MATH%Reporting%Site%'
UNION
SELECT     ID, '3' Marking_Period, 'Quarter 3' Marking_Period_2, '3' Marking_Period_3, 'Reporting Period' Assignment_Type, 'MATH' Section_Type, 'MATH' Section_Type_2
FROM         SDW_Stage_Prod_17.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%3%MATH%Reporting%Site'
UNION
SELECT     ID, '4' Marking_Period, 'Quarter 4' Marking_Period_2, '4' Marking_Period_3, 'Reporting Period' Assignment_Type, 'MATH' Section_Type, 'MATH' Section_Type_2
FROM         SDW_Stage_Prod_17.dbo.Assignment_Lib__c
WHERE     Name LIKE '%Qtr%4%MATH%Reporting%Site%'


GO
