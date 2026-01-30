@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR2 -Supply Attract Reverse Charge'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZFI_GSTR2_SUPP_ATTR_REV
  as select from I_OperationalAcctgDocItem
{

  key CompanyCode,
  key AccountingDocument,
  key FiscalYear,
      case
      when TaxCode between 'CA' and 'CL'
      then 'YES'
      when TaxCode between 'DA' and 'DL'
      then 'YES'
      else 'NO'
      end as SuppAttRevChrge,

      case
      when TaxCode between 'DI' and 'DL'
      then 'YES'
      when TaxCode between 'DA' and 'DH'
      then 'YES'
      else 'NO'
      end as NDGst
}
where
     AccountingDocumentType = 'RE'
  or AccountingDocumentType = 'KR'
  or AccountingDocumentType = 'KG'
group by
  CompanyCode,
  AccountingDocument,
  FiscalYear,
  TaxCode
