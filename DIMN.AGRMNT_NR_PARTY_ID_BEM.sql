/*DBTYPE:SQLSERVER|TARGETDB:HPFSIDS*/
IF EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'TestType' AND ss.name = N'dbo')
begin
drop TYPE [dbo].[TestType]
end
go
CREATE TYPE [dbo].[TestType] AS TABLE(
	[TestColumn] [nvarchar](10)
	)
go
IF  not EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'AGRMNT_NR_PARTY_ID_BEM' AND ss.name = N'DIMN')
begin

CREATE TYPE [DIMN].[AGRMNT_NR_PARTY_ID_BEM] AS TABLE(
	[AGRMNT_NR] [varchar](30) NOT NULL,
	[PARTY_ID] [nvarchar](100) NULL,
	[END_PARTY_ID] [nvarchar](100) NULL,
	[BEM_ID] [numeric](18, 0) NULL
)
end
GO
GRANT EXECUTE ON type::[DIMN].[AGRMNT_NR_PARTY_ID_BEM] TO DMUsr01
go
