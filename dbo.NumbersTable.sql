/*DBTYPE:SQLSERVER|TARGETDB:HPFSIDS*/
IF EXISTS
(
	SELECT 1 
	FROM Information_schema.Routines 
	WHERE Specific_schema = 'dbo' 
		AND specific_name = 'NumbersTable' 
		AND Routine_Type = 'FUNCTION'
) 
BEGIN 
	DROP FUNCTION IF EXISTS [dbo].[NumbersTable]
END
GO


CREATE FUNCTION [dbo].[NumbersTable] 
(
@fromNumber int,
@toNumber int,
@byStep int
) 
/*
	Object Name  : [dbo].[NumbersTable]
	Object Type  : Function
	Purpose		 : Returns a sequence of numbers between two numbers that you can pass these boundary values as parameters
	Parameters	 : From number, To number and Step
	Exec Step	 : Q
				   SELECT * FROM [dbo].[NumbersTable](1,quantity,1)
												<-: Version Log :->
*============================================================================================================================*
* [Version #]		[Modified By]		[Modified Date]		[Purpose]														 *
* -----------		-------------		---------------		---------														 *
* v1.0				---					---					Initial version													 *
* v1.1				Mahesh Mohite		08/09/2022			Changes related to CustomerAssetAPI - Datahub briding development *
*																															 *
*=========================================================================================================================== *
*/ 
RETURNS TABLE
RETURN (
	WITH CTE_NumbersTable AS (
		SELECT @fromNumber AS i
		UNION ALL
		SELECT i + @byStep
		FROM CTE_NumbersTable
		WHERE
		(i + @byStep) <= @toNumber
	)
	SELECT * 
	FROM CTE_NumbersTable
	
)
GO
GRANT SELECT ON [dbo].[NumbersTable] TO DMUsr01;
GO
