/*DBTYPE:SQLSERVER|TARGETDB:HPFSIDS*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DBO.logerror') AND type in (N'P', N'PC'))
BEGIN
DROP PROCEDURE DBO.logerror
END
GO 
CREATE PROCEDURE DBO.logerror  
--==============================================================================  
-- Procedure:     logerror  
--  
-- Purpose:       Create entry in error log, either by proc parameters or #table.  
--  
-- Parameters:    Either passed-in parameters or table "#logerror", defined thusly:  
--              
-- Returns:       nothing.  
--EXEC  dbo.logerror 'ASIAPACIFIC\nallaecl','usp_cp_UpdateCDFLabelDesc','CDF LBL INS:'
--=========================== Modification Log ==================================  
-- DATE        Release    WHO       Control    Modification  
-- --------   -------    -------    -------    -----------------------------------------  
-- 05/01/2023    CP      DH Team    Initial 
 
--===============================================================================  
(  
    @pv_username    varchar(50),  
    @pv_category    varchar(40),  
    @pv_description varchar(2000)  
)  
  
as  
begin  
  

    -- try to provide a username if we weren't given one  
    set @pv_username = coalesce(@pv_username, suser_sname());  
  
    -- if the temporary table does not exist...  
    if @pv_category is not null and @pv_description is not null   
        begin  
        -- use the procedure parameters passed in  
        insert into dbo.ep_error_log with (rowlock)  
            (  
            entry_user,  
            entry_timestamp,  
            category,  
            description  
            )   
        values    (  
            @pv_username,  
            getdate(),  
            @pv_category,  
            @pv_description  
            );  
        end  
  
end;
GO

GRANT EXECUTE ON DBO.logerror TO DMUsr01
GO