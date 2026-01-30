@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR2 - Tax amounts'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZFI_GSTR2_TAX_AMT
  as select from    I_OperationalAcctgDocTaxItem as a

    left outer join ZFI_GSTR2_IGST_AMT           as c on  a.CompanyCode        = c.CompanyCode
                                                      and a.AccountingDocument = c.AccountingDocument
                                                      and a.FiscalYear         = c.FiscalYear
                                                      and a.TaxCode            = c.TaxCode

    left outer join ZFI_GSTR2_CGST_AMT           as d on  a.CompanyCode        = d.CompanyCode
                                                      and a.AccountingDocument = d.AccountingDocument
                                                      and a.FiscalYear         = d.FiscalYear
                                                      and a.TaxCode            = d.TaxCode

    left outer join ZFI_GSTR2_SGST_AMT           as e on  a.CompanyCode        = e.CompanyCode
                                                      and a.AccountingDocument = e.AccountingDocument
                                                      and a.FiscalYear         = e.FiscalYear
                                                      and a.TaxCode            = e.TaxCode

    left outer join ZFI_GSTR2_TAX_ND             as f on  a.CompanyCode        = f.CompanyCode
                                                      and a.AccountingDocument = f.AccountingDocument
                                                      and a.FiscalYear         = f.FiscalYear
                                                      and a.TaxCode            = f.TaxCode

{

  key       a.CompanyCode,
  key       a.AccountingDocument,
  key       a.FiscalYear,
  key       a.TaxCode,
            c.CompanyCodeCurrency,
            @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
            c.IGSTAmt,
            @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
            c.RcmIGST,
            @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
            f.NonDedIGST as NonDedIGST,
            @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
            f.NonDedRcmIGST as NonDedRcmIGST,
            @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
            d.CGSTAmt,
            @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
            d.RcmCGST,
            @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
            f.NonDedSGST    as NonDedCGST,
            @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
            f.NonDedRcmSGST as NonDedRcmCGST,
            @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
            e.SGSTAmt,
            @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
            e.RcmSGST,
            @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
            f.NonDedSGST as NonDedSGST,
            @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
            f.NonDedRcmSGST as NonDedRcmSGST
}
where
     a.TransactionTypeDetermination = 'JII'
  or a.TransactionTypeDetermination = 'JIC'
  or a.TransactionTypeDetermination = 'JIS'
  or a.TransactionTypeDetermination = 'NVV'
group by
  a.CompanyCode,
  a.AccountingDocument,
  a.FiscalYear,
  a.TaxCode,
  c.CompanyCodeCurrency,
  c.IGSTAmt,
  c.RcmIGST,
  f.NonDedIGST,
  f.NonDedRcmIGST,
  d.CGSTAmt,
  d.RcmCGST,
  e.SGSTAmt,
  e.RcmSGST,
  f.NonDedSGST,
  f.NonDedRcmSGST
