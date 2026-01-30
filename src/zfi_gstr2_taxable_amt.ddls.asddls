@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR2 - taxable amount'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZFI_GSTR2_TAXABLE_AMT
  as select from I_OperationalAcctgDocTaxItem

{
  key CompanyCode,
  key AccountingDocument,
  key FiscalYear,
  key TaxCode,
      TransactionCurrency,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      TaxBaseAmountInTransCrcy as TaxableAmt

}
where
     TransactionTypeDetermination = 'JII'
  or TransactionTypeDetermination = 'JIC'
  or TransactionTypeDetermination = 'JIS'
  or TransactionTypeDetermination = 'NVV'
group by
  CompanyCode,
  AccountingDocument,
  FiscalYear,
  TransactionCurrency,
  TaxBaseAmountInTransCrcy,
  TaxCode
