@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR2 - MSME Vendor'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZFI_GSTR2_MSME_VEND
  as select from I_OperationalAcctgDocItem

{

  key CompanyCode,
  key FiscalYear,
  key AccountingDocument,
      case GLAccount
      when '0022000001' then 'Yes'
      else 'No'
      end as MsmeStatus

}
where
  FinancialAccountType = 'K'
group by
  CompanyCode,
  FiscalYear,
  AccountingDocument,
  GLAccount
