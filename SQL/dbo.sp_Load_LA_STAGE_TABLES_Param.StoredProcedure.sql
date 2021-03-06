USE [Data_Services]
GO
/****** Object:  StoredProcedure [dbo].[sp_Load_LA_STAGE_TABLES_Param]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =========================================================================================
-- AUTHOR:		
-- CREATE DATE: 
-- DESCRIPTION:	
-- HISTORY:		
-- ========================================================================================
CREATE    PROCEDURE [dbo].[sp_Load_LA_STAGE_TABLES_Param] @TableName varchar(80)
AS

BEGIN
SET NOCOUNT ON

IF @TableName = 'LA_Class_Sec_Enrollment'
BEGIN

   	--CLASS: LOAD FROM ENROLLMENT-----------------------------------------------------------------------------------------------------------


	DELETE FROM Data_Services.dbo.Class WHERE DISTRICT = 'LA'

	INSERT INTO Data_Services.dbo.Class (Student_ID, Class_Section_ID, Period_Name, Period, Teacher_Name, District, RunDate,Section_Type,Marking_Period,
						Course_ID,Teacher_ID)
    SELECT Student_ID,Course,LEFT(Course, CHARINDEX('-',Course)-1), Period, 
			CASE WHEN Teacher_Name = ',' THEN NULL ELSE Teacher_Name END,'LA' AS District,GetDate(), '' AS Section_type,'' AS MArking_Period,
	       RIGHT(Course,LEN(Course)-CHARINDEX('-',Course)) AS Course_ID,'' AS Teacher_ID
    FROM dbo.[LA_Class_SEC_Enrollment]  order by student_ID
    
      
    
    --STUDENT: LOAD FROM ENROLLMENT-----------------------------------------------------------------------------------------------------------

	DELETE FROM dbo.Student WHERE DISTRICT = 'LA'

	INSERT INTO dbo.Student (Student_ID,School_ID,School_Name,School_Year,First_Name,Last_Name,Grade,Date_Of_Birth,Sex,Ethnicity,Race,
						Disability_Flag,ELL_Flag,Home_Language,Address_Line_1,Address_Line_2,City,State,Zip,Home_Phone,District,RunDate)

	SELECT DISTINCT Student_ID
	-- length of id incompatible with school lookup table,SUBSTRING(School_ID,2,4)
	,School_ID
	,School_Name
	,'' AS School_Year
	-- mismapped, SUBSTRING(Student_Name,0,CHARINDEX(',',Student_Name,0))
	-- mismapped , RIGHT(Student_Name,LEN(Student_Name)-CHARINDEX(',',Student_Name))
	, RIGHT(Student_Name,LEN(Student_Name)-CHARINDEX(',',Student_Name))
	, SUBSTRING(Student_Name,0,CHARINDEX(',',Student_Name,0))
	, Grade
	, '' AS Date_Of_Birth
	, Gender, '' AS Ethnicity, Ethn
	,  SpEd, ELL_Flag
	, '' AS Home_Language
	, '' AS Address_Line_1
	, '' AS Address_Line_2
	, '' AS City
	, '' AS State
	, '' AS ZipCode
	, '' AS Home_Phone
	,'LA' AS District
	, getdate() AS RunDate
	from [dbo].[LA_Class_SEC_Enrollment] 

		

	UPDATE dbo.Student SET Ethnicity = Case When Race = 'BL' THEN 'Black or African American' 
															  When Race = 'AS' THEN 'Asian'
															  When Race = 'AI' THEN 'American Indian'
															  When Race = 'PI' THEN 'Pacific Islander'
															  When Race = 'FI' THEN 'Filipino'
															  When Race = 'WH' THEN 'White'
															  When Race = 'AA' THEN 'African American'
															  When Race = 'HI' THEN 'White'
															  ELSE ''
															  END	  
			
	FROM Student WHERE DISTRICT = 'LA'
END

IF @TableName = 'LA_Assignment_Grades_Sec_ELA'
BEGIN     

 --ASSIGNMENT_GRADES LOAD FROM LA_SECONDARY_ROSTER_ELA AND LA_SECONDARY_ROSTER_MATH----------------------------------------------------

  delete from dbo.[Assignment_Grades] where district = 'LA' 

  --ELA TERM 1
  --Grade_value_5Wk_Term1
   INSERT INTO dbo.[Assignment_Grades] (Student_id,class_section_id,marking_period,Assignment_type,Assignment_name,Grade_value,
                                    assignment_weight,applicable_state_standard_identifier,Date,District,rundate)
   Select unique_student_id,Class_section_Name_term1,'Q1','Progress_Report','Grade_Value_5Wk_Term1',Grade_value_5Wk_Term1,NULL,NULL,NULL,'LA', getdate()
   FROM [dbo].[LA_Assignment_Grades_Sec_ELA]  

   --Grade_value_mid_Term1
   INSERT INTO dbo.[Assignment_Grades] (Student_id,class_section_id,marking_period,Assignment_type,Assignment_name,Grade_value,
                                    assignment_weight,applicable_state_standard_identifier,Date,District,rundate)
   Select unique_student_id,Class_section_Name_term1,'Q1','Progress_Report','Grade_Value_10Wk_Term1',Grade_value_mid_Term1,NULL,NULL,NULL,'LA', getdate()
   FROM [dbo].[LA_Assignment_Grades_Sec_ELA]

   

   --Grade_value_15Wk_Term1
   INSERT INTO dbo.[Assignment_Grades] (Student_id,class_section_id,marking_period,Assignment_type,Assignment_name,Grade_value,
                                    assignment_weight,applicable_state_standard_identifier,Date,District,rundate)
   Select unique_student_id,Class_section_Name_term1,'Q2','Progress_Report','Grade_Value_15Wk_Term1',Grade_value_15Wk_Term1,NULL,NULL,NULL,'LA', getdate()
   FROM [dbo].[LA_Assignment_Grades_Sec_ELA]

   

   --Grade_value_Final_Term1
   INSERT INTO dbo.[Assignment_Grades] (Student_id,class_section_id,marking_period,Assignment_type,Assignment_name,Grade_value,
                                    assignment_weight,applicable_state_standard_identifier,Date,District,rundate)
   Select unique_student_id,Class_section_Name_term1,'Q2','Progress_Report','Grade_Value_20Wk_Term1',Grade_value_Final_Term1,NULL,NULL,NULL,'LA', getdate()
   FROM [dbo].[LA_Assignment_Grades_Sec_ELA] 

  
   --ELA TERM 2
   --Grade_value_5Wk_Term2 
   INSERT INTO dbo.[Assignment_Grades] (Student_id,class_section_id,marking_period,Assignment_type,Assignment_name,Grade_value,
                                    assignment_weight,applicable_state_standard_identifier,Date,District,rundate)
   Select unique_student_id,Class_section_Name_term1,'Q3','Progress_Report','Grade_Value_5Wk_Term2',Grade_value_5Wk_Term2,NULL,NULL,NULL,'LA', getdate()
   FROM [dbo].[LA_Assignment_Grades_Sec_ELA]

    


   --Grade_value_mid_Term2
   INSERT INTO dbo.[Assignment_Grades] (Student_id,class_section_id,marking_period,Assignment_type,Assignment_name,Grade_value,
                                    assignment_weight,applicable_state_standard_identifier,Date,District,rundate)
   Select unique_student_id,Class_section_Name_term1,'Q3','Progress_Report','Grade_Value_30Wk_Term1',Grade_value_mid_Term2,NULL,NULL,NULL,'LA', getdate()
   FROM [dbo].[LA_Assignment_Grades_Sec_ELA]

  

   --Grade_value_15Wk_Term2
   INSERT INTO dbo.[Assignment_Grades] (Student_id,class_section_id,marking_period,Assignment_type,Assignment_name,Grade_value,
                                    assignment_weight,applicable_state_standard_identifier,Date,District,rundate)
   Select unique_student_id,Class_section_Name_term1,'Q4','Progress_Report','Grade_Value_15Wk_Term2',Grade_value_15Wk_Term2,NULL,NULL,NULL,'LA', getdate()
   FROM [dbo].[LA_Assignment_Grades_Sec_ELA]

   --Grade_value_Final_Term2
   INSERT INTO Data_Services.dbo.[Assignment_Grades] (Student_id,class_section_id,marking_period,Assignment_type,Assignment_name,Grade_value,
                                    assignment_weight,applicable_state_standard_identifier,Date,District,rundate)
   Select unique_student_id,Class_section_Name_term1,'Q4','Progress_Report','Grade_Value_40Wk_Term1',Grade_value_Final_Term2,NULL,NULL,NULL,'LA', getdate()
   FROM [dbo].[LA_Assignment_Grades_Sec_ELA]
   
 END    

IF @TableName = 'LA_Assignment_Grades_Sec_Math'
BEGIN
  
  --MATH----TERM 1---------------------------------------------------------------------
  --Grade_value_5Wk_Term1
   INSERT INTO dbo.[Assignment_Grades] (Student_id,class_section_id,marking_period,Assignment_type,Assignment_name,Grade_value,
                                    assignment_weight,applicable_state_standard_identifier,Date,District,rundate)
   Select unique_student_id,Class_section_Name_term1,'Q1','Progress_Report','Grade_Value_5Wk_Term1',Grade_value_5Wk_Term1,NULL,NULL,NULL,'LA', getdate()
   FROM [dbo].[LA_Assignment_Grades_Sec_Math]  --[LA_Secondary_Roster_Math] 

   --Grade_value_mid_Term1
   INSERT INTO dbo.[Assignment_Grades] (Student_id,class_section_id,marking_period,Assignment_type,Assignment_name,Grade_value,
                                    assignment_weight,applicable_state_standard_identifier,Date,District,rundate)
   Select unique_student_id,Class_section_Name_term1,'Q1','Progress_Report','Grade_Value_10Wk_Term1',Grade_value_mid_Term1,NULL,NULL,NULL,'LA', getdate()
   FROM [dbo].[LA_Assignment_Grades_Sec_Math]

   --Grade_value_15Wk_Term1
   INSERT INTO dbo.[Assignment_Grades] (Student_id,class_section_id,marking_period,Assignment_type,Assignment_name,Grade_value,
                                    assignment_weight,applicable_state_standard_identifier,Date,District,rundate)
   Select unique_student_id,Class_section_Name_term1,'Q2','Progress_Report','Grade_Value_15Wk_Term1',Grade_value_15Wk_Term1,NULL,NULL,NULL,'LA', getdate()
   FROM [dbo].[LA_Assignment_Grades_Sec_Math]

   --Grade_value_Final_Term1
   INSERT INTO dbo.[Assignment_Grades] (Student_id,class_section_id,marking_period,Assignment_type,Assignment_name,Grade_value,
                                    assignment_weight,applicable_state_standard_identifier,Date,District,rundate)
   Select unique_student_id,Class_section_Name_term1,'Q2','Progress_Report','Grade_Value_20Wk_Term1',Grade_value_Final_Term1,NULL,NULL,NULL,'LA', getdate()
   FROM [dbo].[LA_Assignment_Grades_Sec_Math]


   --MATH TERM 2
   --Grade_value_5Wk_Term2 
   INSERT INTO dbo.[Assignment_Grades] (Student_id,class_section_id,marking_period,Assignment_type,Assignment_name,Grade_value,
                                    assignment_weight,applicable_state_standard_identifier,Date,District,rundate)
   Select unique_student_id,Class_section_Name_term1,'Q3','Progress_Report','Grade_Value_5Wk_Term2',Grade_value_5Wk_Term2,NULL,NULL,NULL,'LA', getdate()
   FROM [dbo].[LA_Assignment_Grades_Sec_Math]

   --Grade_value_mid_Term2
   INSERT INTO dbo.[Assignment_Grades] (Student_id,class_section_id,marking_period,Assignment_type,Assignment_name,Grade_value,
                                    assignment_weight,applicable_state_standard_identifier,Date,District,rundate)
   Select unique_student_id,Class_section_Name_term1,'Q3','Progress_Report','Grade_Value_30Wk_Term1',Grade_value_mid_Term2,NULL,NULL,NULL,'LA', getdate()
   FROM [dbo].[LA_Assignment_Grades_Sec_Math]

   --Grade_value_15Wk_Term2
   INSERT INTO dbo.[Assignment_Grades] (Student_id,class_section_id,marking_period,Assignment_type,Assignment_name,Grade_value,
                                    assignment_weight,applicable_state_standard_identifier,Date,District,rundate)
   Select unique_student_id,Class_section_Name_term1,'Q4','Progress_Report','Grade_Value_15Wk_Term2',Grade_value_15Wk_Term2,NULL,NULL,NULL,'LA', getdate()
   FROM [dbo].[LA_Assignment_Grades_Sec_Math]

   --Grade_value_Final_Term2
   INSERT INTO dbo.[Assignment_Grades] (Student_id,class_section_id,marking_period,Assignment_type,Assignment_name,Grade_value,
                                    assignment_weight,applicable_state_standard_identifier,Date,District,rundate)
   Select unique_student_id,Class_section_Name_term1,'Q4','Progress_Report','Grade_Value_40Wk_Term1',Grade_value_Final_Term2,NULL,NULL,NULL,'LA', getdate()
   FROM [dbo].[LA_Assignment_Grades_Sec_Math]
 END
 
 IF @TableName = 'LA_Assignment_Grades_Sec_ELA'

BEGIN   

--MP_GRADES: LOAD FROM LA_Assignment_Grades_Sec_ELA and LA_Assignment_Grades_Sec_Math  TABLE ---------------------------

	DELETE FROM dbo.[MP_Grades] WHERE DISTRICT = 'LA'

	

--MP_GRADE ELA Q1
   INSERT INTO dbo.[MP_Grades] (Student_id,marking_period,class_section_id,Grade_value,Weighted_Value,GPA_Value,District,rundate,
							Course_ID,Teacher_ID,Period,applicable_state_standard_identifier,applicable_state_standard_Description)
                                 
   Select unique_student_id,'Q1',Class_Section_Name_Term1,Grade_value_Mid_Term1,'' AS Weighted_Average,'' AS GPA_Value, 'LA', getdate(),  
		  '' AS Course_ID, '' AS Teacher_ID, '' AS Period, '' AS applicable_state_standard_identifier, '' AS applicable_state_standard_Description  -- Grade_value_Mid_Term1,NULL,NULL,NULL,'LA', 
   FROM [dbo].[LA_Assignment_Grades_Sec_ELA]

--MP_GRADE ELA Q2
   INSERT INTO dbo.[MP_Grades] (Student_id,marking_period,class_section_id,Grade_value,Weighted_Value,GPA_Value,District,rundate,
							Course_ID,Teacher_ID,Period,applicable_state_standard_identifier,applicable_state_standard_Description)
                                 
   Select unique_student_id,'Q2',Class_Section_Name_Term1,Grade_value_Final_Term1,'' AS Weighted_Average,'' AS GPA_Value, 'LA', getdate(),  
		  '' AS Course_ID, '' AS Teacher_ID, '' AS Period, '' AS applicable_state_standard_identifier, '' AS applicable_state_standard_Description  -- Grade_value_Mid_Term1,NULL,NULL,NULL,'LA', 
   FROM [dbo].[LA_Assignment_Grades_Sec_ELA]

 --MP_GRADE ELA Q3
   INSERT INTO dbo.[MP_Grades] (Student_id,marking_period,class_section_id,Grade_value,Weighted_Value,GPA_Value,District,rundate,
							Course_ID,Teacher_ID,Period,applicable_state_standard_identifier,applicable_state_standard_Description)
                                 
   Select unique_student_id,'Q3',Class_Section_Name_Term1,Grade_value_Mid_Term2,'' AS Weighted_Average,'' AS GPA_Value, 'LA', getdate(),  
		  '' AS Course_ID, '' AS Teacher_ID, '' AS Period, '' AS applicable_state_standard_identifier, '' AS applicable_state_standard_Description  -- Grade_value_Mid_Term1,NULL,NULL,NULL,'LA', 
   FROM [dbo].[LA_Assignment_Grades_Sec_ELA]


  --MP_GRADE ELA Q4
   INSERT INTO dbo.[MP_Grades] (Student_id,marking_period,class_section_id,Grade_value,Weighted_Value,GPA_Value,District,rundate,
							Course_ID,Teacher_ID,Period,applicable_state_standard_identifier,applicable_state_standard_Description)
                                 
   Select unique_student_id,'Q4',Class_Section_Name_Term1,Grade_value_Final_Term2,'' AS Weighted_Average,'' AS GPA_Value, 'LA', getdate(),  
		  '' AS Course_ID, '' AS Teacher_ID, '' AS Period, '' AS applicable_state_standard_identifier, '' AS applicable_state_standard_Description  -- Grade_value_Mid_Term1,NULL,NULL,NULL,'LA', 
   FROM [dbo].[LA_Assignment_Grades_Sec_ELA]

END

IF @TableName = 'LA_Assignment_Grades_Sec_MATH'
BEGIN
--MP_GRADE MATH Q1
   INSERT INTO dbo.[MP_Grades] (Student_id,marking_period,class_section_id,Grade_value,Weighted_Value,GPA_Value,District,rundate,
							Course_ID,Teacher_ID,Period,applicable_state_standard_identifier,applicable_state_standard_Description)
                                 
   Select unique_student_id,'Q1',Class_Section_Name_Term1,Grade_value_Mid_Term1,'' AS Weighted_Average,'' AS GPA_Value, 'LA', getdate(),  
		  '' AS Course_ID, '' AS Teacher_ID, '' AS Period, '' AS applicable_state_standard_identifier, '' AS applicable_state_standard_Description  -- Grade_value_Mid_Term1,NULL,NULL,NULL,'LA', 
   FROM [dbo].[LA_Assignment_Grades_Sec_MATH]  --[LA_Secondary_Roster_MATH]

--MP_GRADE MATH Q2
   INSERT INTO dbo.[MP_Grades] (Student_id,marking_period,class_section_id,Grade_value,Weighted_Value,GPA_Value,District,rundate,
							Course_ID,Teacher_ID,Period,applicable_state_standard_identifier,applicable_state_standard_Description)
                                 
   Select unique_student_id,'Q2',Class_Section_Name_Term1,Grade_value_Final_Term1,'' AS Weighted_Average,'' AS GPA_Value, 'LA', getdate(),  
		  '' AS Course_ID, '' AS Teacher_ID, '' AS Period, '' AS applicable_state_standard_identifier, '' AS applicable_state_standard_Description  -- Grade_value_Mid_Term1,NULL,NULL,NULL,'LA', 
   FROM [dbo].[LA_Assignment_Grades_Sec_MATH]

 --MP_GRADE MATH Q3
   INSERT INTO dbo.[MP_Grades] (Student_id,marking_period,class_section_id,Grade_value,Weighted_Value,GPA_Value,District,rundate,
							Course_ID,Teacher_ID,Period,applicable_state_standard_identifier,applicable_state_standard_Description)
                                 
   Select unique_student_id,'Q3',Class_Section_Name_Term1,Grade_value_Mid_Term2,'' AS Weighted_Average,'' AS GPA_Value, 'LA', getdate(),  
		  '' AS Course_ID, '' AS Teacher_ID, '' AS Period, '' AS applicable_state_standard_identifier, '' AS applicable_state_standard_Description  -- Grade_value_Mid_Term1,NULL,NULL,NULL,'LA', 
   FROM [dbo].[LA_Assignment_Grades_Sec_MATH]


  --MP_GRADE MATH Q4
   INSERT INTO dbo.[MP_Grades] (Student_id,marking_period,class_section_id,Grade_value,Weighted_Value,GPA_Value,District,rundate,
							Course_ID,Teacher_ID,Period,applicable_state_standard_identifier,applicable_state_standard_Description)
                                 
   Select unique_student_id,'Q4',Class_Section_Name_Term1,Grade_value_Final_Term2,'' AS Weighted_Average,'' AS GPA_Value, 'LA', getdate(),  
		  '' AS Course_ID, '' AS Teacher_ID, '' AS Period, '' AS applicable_state_standard_identifier, '' AS applicable_state_standard_Description  -- Grade_value_Mid_Term1,NULL,NULL,NULL,'LA', 
   FROM [dbo].[LA_Assignment_Grades_Sec_MATH]
   
END

END



GO
