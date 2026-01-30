@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR2 - All CGST amounts'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZFI_GSTR2_CGST_AMT
  as select from I_OperationalAcctgDocItem
{

  key CompanyCode,
  key AccountingDocument,
  key FiscalYear,
      CompanyCodeCurrency,
      TaxCode,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'

      AmountInTransactionCurrency as CGSTAmt,

      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when TaxCode between 'CA' and 'CH'
      then  AmountInTransactionCurrency
      when TaxCode between 'DA' and 'DH'
      then  AmountInTransactionCurrency
      else cast('0.00'as abap.curr( 13,2))
      end                         as RcmCGST

}
where
  TransactionTypeDetermination = 'JIC'
group by
  CompanyCode,
  AccountingDocument,
  FiscalYear,
  CompanyCodeCurrency,
  TaxCode,
  AmountInTransactionCurrency,
  TransactionTypeDetermination
