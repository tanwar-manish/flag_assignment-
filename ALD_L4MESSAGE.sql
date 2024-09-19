/*DBTYPE:SQLSERVER|TARGETDB:HPFSIDS*/


IF EXISTS (
			SELECT	1
			FROM	sys.objects so
			INNER JOIN sys.schemas ss	ON ss.schema_id	= so.schema_id
			WHERE	so.name	= 'ALD_L4MESSAGE'
			AND		so.type	= 'P'
			AND		ss.name	= 'dbo'
	)
	BEGIN;
		DROP PROCEDURE dbo.ALD_L4MESSAGE;
	END
GO 
------------ Deployment date Apr 22  --------------------------  
  
  
CREATE PROCEDURE [dbo].[ALD_L4MESSAGE]  
(  
    @L4 XML,  
    @ErrMsg NVARCHAR(512) OUTPUT  
)  
AS  
/*  
    Name:    ALD_L4MESSAGE  
    Version:         1.0  
    Created BY:     Ramakant Dixit. ramakant.dixit@wipro.com  
    Created Date:  Dec 14, 2021.  
    Parameters:  
            1.  L4.  Input XML type. Takes XML message which need to insert into the table.  
            4.  ErrMsg. Output Varchar type. Returns error Msg (if any) to a calling process else return success.  
    ==========================================================  
        Revision history   
    ===========================  
    Version            Modified By        Date            Comments  
    ==========================================================  
    1.1                Vijay            Mar 22, 2022    Updated as per User    Story - 8924 Rejected Product should have respective status in ProdException table + Invoice Status  
                                                    in SupplierInvoiceException and SupplierInvoiceProductException tables  
    1.2                Vijay            Apr 22,2022        Added ReferenceDoc field in Insert statement of ProductRejections table  
*/  
  
BEGIN  
  
  
        DECLARE @TranCount INT  
        DECLARE   
                @RequestType  varchar(100),  
                @RequestedItemNumber  varchar(100),  
                @Category  varchar(100),  
                @ManufactureCode  varchar(50),  
                @CompanyCode  varchar(50),  
                @Source  varchar(100),  
                @Origination  varchar(50),  
                @OriginationDoc  varchar(100),  
                @ProductName  varchar(100),  
                @ProductRequestStatus  varchar(250),  
                @RejectionMessage  varchar(250),  
                @RequestComments  varchar(250),  
                @Createdby  varchar(100),  
                @CreatedDateTime  datetime,  
                @FoundInLMD  varchar(50),  
                @FoundInProductCatalog  varchar(50),  
                @FoundInProductCrossReference  varchar(50),  
                @Geo  varchar(100),  
                @Comments  varchar(250),  
                @RequestOriginatedApplication  varchar(100),  
                @RequestOriginatedBy  varchar(100),  
                @User  varchar(100),  
                @UserCreatedId  varchar(50),  
                @UserCreatedTimestamp  datetime,  
                @UserModifiedId  varchar(50),  
                @UserModifiedTimestamp  datetime,  
                @EventTime  datetime,  
                @InvoiceURL VARCHAR(100)  
                ,@SupplierInvoiceId int            -- 1.1  
                ,@ReferenceDoc varchar(250)        -- 1.1      
                  
  
    SET NOCOUNT ON;  
    SET XACT_ABORT ON;  
    SET @TranCount = @@TRANCOUNT;  
  
      IF(@TranCount > 0) SAVE TRAN SP1  
        BEGIN TRY;  
            BEGIN TRAN;  
  
                    SET @RequestType  = @L4.value('/xml[1]/RequestType[1]','varchar(100)')  
                    SET @RequestedItemNumber  = @L4.value('/xml[1]/RequestedItemNumber[1]','varchar(100)')  
                    SET @Category  = @L4.value('/xml[1]/Category[1]','varchar(100)')  
                    SET @ManufactureCode  = @L4.value('/xml[1]/ManufactureCode[1]','varchar(50)')  
                    SET @CompanyCode  = @L4.value('/xml[1]/CompanyCode[1]','varchar(50)')  
                    SET @Source  = @L4.value('/xml[1]/Source[1]','varchar(100)')  
                    SET @Origination  = @L4.value('/xml[1]/Origination[1]','varchar(50)')  
                    SET @OriginationDoc  = @L4.value('/xml[1]/OriginationDoc[1]','varchar(100)')  
                    SET @ProductName  = @L4.value('/xml[1]/ProductName[1]','varchar(100)')  
                    SET @ProductRequestStatus  = @L4.value('/xml[1]/ProductRequestStatus[1]','varchar(250)')  
                    SET @RejectionMessage  = @L4.value('/xml[1]/RejectionMessage[1]','varchar(250)')  
    SET @RequestComments  = @L4.value('/xml[1]/RequestComments[1]','varchar(250)')  
                    SET @Createdby  = @L4.value('/xml[1]/Createdby[1]','varchar(100)')  
                    SET @CreatedDateTime  = @L4.value('/xml[1]/CreatedDateTime[1]','datetime')  
                    SET @FoundInLMD  = @L4.value('/xml[1]/FoundInLMD[1]','varchar(50)')  
                    SET @FoundInProductCatalog  = @L4.value('/xml[1]/FoundInProductCatalog[1]','varchar(50)')  
                    SET @FoundInProductCrossReference  = @L4.value('/xml[1]/FoundInProductCrossReference[1]','varchar(50)')  
                    SET @Geo  = @L4.value('/xml[1]/Geo[1]','varchar(100)')  
                    SET @Comments  = @L4.value('/xml[1]/Comments[1]','varchar(250)')  
                    SET @RequestOriginatedApplication  = @L4.value('/xml[1]/RequestOriginatedApplication[1]','varchar(100)')  
                    SET @RequestOriginatedBy  = @L4.value('/xml[1]/RequestOriginatedBy[1]','varchar(100)')  
                    SET @User  = @L4.value('/xml[1]/User[1]','varchar(100)')  
                    SET @EventTime  = @L4.value('/xml[1]/EventTime[1]','datetime')  
                    SET @InvoiceURL  = @L4.value('/xml[1]/InvoiceURL[1]','varchar(100)')  
                    Set @ReferenceDoc =  @L4.value('/xml[1]/ReferenceDoc[1]','varchar(100)')  
                      
  
                    INSERT INTO [dbo].[ProductRejections]  
                                    (  
                                    RequestType,  
                                    RequestedItemNumber,  
                                    Category,  
                                    ManufacturedCode,  
                                    CompanyCode,  
                                    [Source],  
                                    Origination,  
                                    OriginationDoc,  
                                    ProductName,  
                                    ProductRequestStatus,  
                                    RejectionMessage,  
                                    RequestComments,  
                                    Createdby,  
                                    CreatedDateTime,  
                                    FoundInLMD,  
                                    FoundInProductCatalog,  
                                    FoundInProductCrossReference,  
                                    Geo,  
                                    Comments,  
                                    RequestOriginatedApplication,  
                                    RequestOriginatedBy,  
                                    [User],  
                                    EventTime,  
                                    InvoiceURL  
                                    ,ReferenceDoc    --1.2  
                              
                                    )  
                VALUES                (  
                                        ISNULL(@RequestType,'NA')  ,  
                                        ISNULL(@RequestedItemNumber ,'NA')  ,  
                                        ISNULL(@Category ,'NA')  ,  
                                        ISNULL(@ManufactureCode,'NA')  ,  
                                        ISNULL(@CompanyCode,'NA')  ,  
                                        ISNULL(@Source,'NA')  ,  
                                        ISNULL(@Origination,'NA')  ,  
                                        ISNULL(@OriginationDoc,'NA') ,  
                                        ISNULL(@ProductName,'NA') ,  
                                        Case When @ProductRequestStatus IS NULL or @ProductRequestStatus='' Then 'System Rejected'        -- 1.1  
                                             Else  ISNULL(@ProductRequestStatus,'NA') End  ,  
                                        ISNULL(@RejectionMessage,'NA')  ,  
                                        ISNULL(@RequestComments ,'NA')  ,  
                                        ISNULL(@Createdby,'NA')  ,  
                       ISNULL(@CreatedDateTime,'1900-01-01'),  
                                        CASE WHEN @FoundInLMD ='No' THEN 'N'  
                                            WHEN  @FoundInLMD ='Yes' THEN 'Y'  
                                            ELSE  '' END,  
                                        CASE WHEN @FoundInProductCatalog='No' THEN 'N'  
                                            WHEN  @FoundInProductCatalog='Yes' THEN 'Y'  
                                            ELSE '' END,  
                                        CASE WHEN @FoundInProductCrossReference='No' THEN 'N'  
                                            WHEN  @FoundInProductCrossReference='Yes' THEN 'Y'  
                                            ELSE '' END,  
                                        ISNULL(@Geo,'NA')  ,  
                                        ISNULL(@Comments ,'NA')  ,  
                                        ISNULL(@RequestOriginatedApplication,'NA')  ,  
                                        ISNULL(@RequestOriginatedBy,'NA')  ,  
                                        ISNULL(@User,'NA')  ,  
                                        ISNULL(@EventTime,'1900-01-01'),  
                                        ISNULL(@InvoiceURL,'NA')  
                                        ,@ReferenceDoc        --1.2  
                                          
                                    )  
                          
                --  1.1 - Start ---- added below code block   
  
                If @ProductRequestStatus IS NOT NULL  -- only for user rejection  
                Begin  
  
                set @SupplierInvoiceId = (Select SupplierInvoiceId   
                                          From (  
                                                Select SupplierInvoiceId,row_number() over(order by UserCreatedTimeStamp desc)rno   
                                                From dbo.SupplierInvoiceExceptions   
                                                Where SupplierInvoiceNumber = @ReferenceDoc  
                                                  
                                                )A   
                                          Where rno = 1   
                                          ) -- get latest timestamp record  
  
                Update dbo.SupplierInvoiceProductExceptions  
                SET SupplierInvoiceProductStatus='Rejected',  
                    UserModifiedId = USER_NAME(),          
                    UserModifiedTimeStamp = GETDATE()  
                Where SupplierProductNumber = @RequestedItemNumber  
                and SupplierInvoiceId = @SupplierInvoiceId   
  
                  
                Update dbo.SupplierInvoiceExceptions  
                SET SupplierInvoiceStatus='Rejected',  
                    UserModifiedId = USER_NAME(),          
                    UserModifiedTimeStamp = GETDATE()  
                Where SupplierInvoiceId = @SupplierInvoiceId  
  
                End  
                  
                -- 1.1 - End  
  
                IF(@TranCount = 0 ) COMMIT TRAN;  
                SET @ErrMsg='Processed Successfully'  
            END TRY  
            BEGIN CATCH  
                    SET @ErrMsg  
                            = 'ERROR_NUMBER=' + CAST(ERROR_NUMBER() AS VARCHAR) + ' ,ERROR_LINE=' + CAST(ERROR_LINE() AS VARCHAR)  
                              + ', ERROR_MESSAGE=' + ERROR_MESSAGE()  
  
  
                      
                    IF(@TranCount = 0 ) ROLLBACK TRAN;  
                    IF(@TranCount > 0)ROLLBACK TRAN SP1;  
  
                    INSERT INTO [PHX01].[GPO_to_IDS_SSIS_Process_Log] (Process,PackageName,ErrMessage)  
                    VALUES('ALD L4 SP','dbo.ALD_L4MESSAGE',ERROR_MESSAGE())  
            END CATCH  
  
        ------------------------  
  
  
END  

GO

IF EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'DMUsr01')
    BEGIN
			GRANT EXECUTE 	ON [dbo].[ALD_L4MESSAGE] TO DMUsr01
			GRANT UPDATE	ON [dbo].[ALD_L4MESSAGE] TO DMUsr01
			GRANT SELECT	ON [dbo].[ALD_L4MESSAGE] TO DMUsr01
    END
GO
  