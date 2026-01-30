@AbapCatalog.sqlViewName: 'ZV_GSTR2_SUPRPT'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR2 Supplier Report CDS View'

define view Ztestr2
  as select from    I_OperationalAcctgDocItem    as a
    left outer join I_Supplier                   as b on a.Supplier = b.Supplier
    left outer join ZFI_GSTR2_TAXAMT_F           as i on  a.AccountingDocument = i.AccountingDocument
                                                      and a.FiscalYear         = i.FiscalYear
                                                      and a.CompanyCode        = i.CompanyCode
    left outer join I_OperationalAcctgDocTaxItem as c on  a.CompanyCode            = c.CompanyCode
                                                      and a.AccountingDocument     = c.AccountingDocument
                                                      and a.AccountingDocumentItem = c.TaxItem
                                                      and a.FinancialAccountType = 'K'

{
  key a.CompanyCode                                                                     as CompanyCode,
      a.BusinessPlace                                                                   as BusinessPlace,
      a.AccountingDocumentType                                                          as AccountingDocumentType,
      a.Supplier                                                                        as Supplier,
      a.AccountingDocument                                                              as BillingDocument,
      a.DocumentDate                                                                    as DocumentDate,
      a.AccountingDocumentItem                                                          as AccountingDocumentItem,
      a.IN_HSNOrSACCode                                                                 as HSNCode,
      a.Product                                                                         as Product,
      a.PostingDate                                                                     as PostingDate,
      b.SupplierName                                                                    as SupplierName,
      b.TaxNumber3                                                                      as SupplierGSTIN,
      c.TransactionTypeDetermination                                                    as GSTTaxCode,
      c.TaxAmountInTransCrcy                                                            as TaxAmountInTransCrcy,
      c.TaxBaseAmountInTransCrcy                                                        as TaxBaseAmountInTransCrcy,

      cast( ( c.TaxBaseAmountInTransCrcy + c.TaxAmountInTransCrcy ) as abap.dec(23,2) ) as TotalValue

}
