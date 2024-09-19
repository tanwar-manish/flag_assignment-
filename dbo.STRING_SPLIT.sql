/*DBTYPE:SQLSERVER|TARGETDB:HPFSIDS*/
IF EXISTS
(
	SELECT 1 
	FROM Information_schema.Routines 
	WHERE Specific_schema = 'dbo' 
		AND specific_name = 'STRING_SPLIT' 
		AND Routine_Type = 'FUNCTION'
) 
BEGIN 
	DROP FUNCTION IF EXISTS [dbo].[STRING_SPLIT]
END
GO


CREATE FUNCTION [dbo].[STRING_SPLIT]
(
    @string_value NVARCHAR(MAX),
    @delimiter_character CHAR(1)
)
/*
	Object Name  : [dbo].[STRING_SPLIT]
	Object Type  : Function
	Purpose		 : Returns a array of string of string value based on delimiter character values as parameters
	Parameters	 : string value, delimiter character
	Exec Step	 : 
				   SELECT * FROM [dbo].[STRING_SPLIT]('1,2,3',',')
												<-: Version Log :->
*============================================================================================================================*
* [Version #]		[Modified By]		[Modified Date]		[Purpose]														 *
* -----------		-------------		---------------		---------														 *
* v1.0				---					---					Initial version													 *
* v1.1				Mahesh Mohite		28/07/2022			Changes related to CustomerAssetAPI - Datahub briding development *
*																															 *
*=========================================================================================================================== *
*/ 
RETURNS @result_set TABLE(value NVARCHAR(MAX))
BEGIN
    DECLARE @start_position INT,
            @ending_position INT
    SELECT @start_position = 1,
            @ending_position = CHARINDEX(@delimiter_character, @string_value)
    WHILE @start_position < LEN(@string_value) + 1
            BEGIN
        IF @ending_position = 0 
           SET @ending_position = LEN(@string_value) + 1
        INSERT INTO @result_set (value) 
        VALUES(SUBSTRING(@string_value, @start_position, @ending_position - @start_position))
        SET @start_position = @ending_position + 1
        SET @ending_position = CHARINDEX(@delimiter_character, @string_value, @start_position)
    END
    RETURN
END
GO
GRANT SELECT ON [dbo].[STRING_SPLIT] TO DMUsr01;
GO
GRANT SELECT ON [dbo].[STRING_SPLIT] TO hpfstibco_rw;
GO
