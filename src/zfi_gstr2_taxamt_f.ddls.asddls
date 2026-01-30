@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR2 - Taxable amount'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZFI_GSTR2_TAXAMT_F
  as select from ZFI_GSTR2_TAXABLE_AMT

{

  key CompanyCode,
  key AccountingDocument,
  key FiscalYear,
  key TaxCode,
      TransactionCurrency,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      sum(TaxableAmt) as TaxableAmt
}
group by
    CompanyCode,
    AccountingDocument,
    FiscalYear,
    TaxCode,
    TransactionCurrency
