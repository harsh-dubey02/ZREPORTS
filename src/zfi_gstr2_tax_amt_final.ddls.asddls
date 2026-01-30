@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR2 - Tax amounts Final'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZFI_GSTR2_TAX_AMT_FINAL
  as select from ZFI_GSTR2_TAX_AMT

{
  key CompanyCode,
  key AccountingDocument,
  key FiscalYear,
  key TaxCode,
      CompanyCodeCurrency,
       @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(IGSTAmt) as IGSTAmt,
       @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(RcmIGST) as RcmIGST,
       @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(NonDedIGST) as NonDedIGST,
       @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(NonDedRcmIGST) as NonDedRcmIGST,
       @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(CGSTAmt) as CGSTAmt,
       @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(RcmCGST) as RcmCGST,
       @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(NonDedCGST) as NonDedCGST,
       @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(NonDedRcmCGST) as NonDedRcmCGST,
       @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(SGSTAmt) as SGSTAmt,
       @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(RcmSGST) as RcmSGST,
       @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(NonDedSGST) as NonDedSGST,
       @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(NonDedRcmSGST) as NonDedRcmSGST

}
group by
    CompanyCode,
    AccountingDocument,
    FiscalYear,
    TaxCode,
    CompanyCodeCurrency
