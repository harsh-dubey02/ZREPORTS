@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1 Report'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZFI_GSTR1_REPORT
  as select from    ZFI_GSTR1_REP1    as a
    left outer join ZFI_GSTR1_TAX_AMT as c on  a.CompanyCode        = c.CompanyCode
                                           and a.AccountingDocument = c.AccountingDocument
                                           and a.FiscalYear         = c.FiscalYear
    left outer join ZR_FIT_TAX_PERC   as n on c.TaxCode = n.Taxcode
    left outer join I_TaxCodeText     as k on c.TaxCode = k.TaxCode

{
  key a.CompanyCode,
  key a.FiscalYear,
  key a.AccountingDocument,
      a.GLAccount,
      a.GLAccountName,
      a.Customer,
      a.CustGstin,
      a.CustomerName,
      a.BusinessPlace,
      a.InvRefNumber,
      a.DocumentType,
      a.DocTypeDesc,
      a.DocumentDate,
      a.PostingDate,
      a.PlaceOfSupply,
      a.SuppAttRevChrge,
      c.TaxCode,
      //      k.TaxCodeName,

      case c.TaxCode
      when 'ZE'   then 'GST Output Tax (CGST + UGST - 5%)'
      when 'ZF'   then 'GST Output Tax (CGST + UGST - 12%)'
      when 'ZG'   then 'GST Output Tax (CGST + UGST - 18%)'
      when 'ZH'   then 'GST Output Tax (CGST + UGST - 28%)'
      else
      k.TaxCodeName
      end as TaxCodeName,

      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when a.ItemTaxAmt < 0
      then a.ItemTaxAmt * -1
      end as ItemTaxAmt,
      n.IgstRate,
      n.CgstRate,
      n.SgstRate,
      case c.TaxCode
      when 'ZE'   then '2.5'
      when 'ZF'   then '6.0'
      when 'ZG'   then '9.0'
      when 'ZH'   then '14.0'
      end as UgstRate,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when c.IGSTAmt < 0
      then c.IGSTAmt * -1
      end as IGSTAmt,
      //      c.IGSTAmt,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when c.CGSTAmt < 0
      then c.CGSTAmt * -1
      end as CGSTAmt,
      //      c.CGSTAmt,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when c.SGSTAmt < 0
      then c.SGSTAmt * -1
      end as SGSTAmt,
      //c.SGSTAmt,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when c.UGSTAmt < 0
      then c.UGSTAmt * -1
      end as UGSTAmt,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when a.InvoiceAmt < 0
      then a.InvoiceAmt * -1
      else a.InvoiceAmt
      end as InvoiceAmt,
      //a.InvoiceAmt,
      a.HsnSacCode,
      a.ProfitCenter,
      a.ProfitCenterDesp,
      a.HsnNature,
      a.GstinStatus,
      a.OurGSTIN,
      a.BookingDate,
      a.CarpetArea,
      a.UnitNo,
      a.PurchasingDocumentPriceUnit,
      @Semantics.quantity.unitOfMeasure: 'PurchasingDocumentPriceUnit'
      a.Qty,
      a.Uom,
      a.IRN,
      //      a.IRNDate,
      a.ParkBy,
      a.PostBy,
      a.CompanyCodeCurrency,
      a.CompanyCodeName,
      a.CSreference,
      a.MilestoneDescp,
      a.Pan

}
group by
  a.CompanyCode,
  a.FiscalYear,
  a.AccountingDocument,
  a.GLAccount,
  a.GLAccountName,
  a.Customer,
  a.CustGstin,
  a.CustomerName,
  a.BusinessPlace,
  a.InvRefNumber,
  a.DocumentType,
  a.DocTypeDesc,
  a.DocumentDate,
  a.PostingDate,
  a.PlaceOfSupply,
  a.SuppAttRevChrge,
  c.TaxCode,
  k.TaxCodeName,
  a.ItemTaxAmt,
  n.IgstRate,
  n.CgstRate,
  n.SgstRate,
  c.IGSTAmt,
  c.CGSTAmt,
  c.SGSTAmt,
  a.InvoiceAmt,
  a.HsnSacCode,
  a.ProfitCenter,
  a.ProfitCenterDesp,
  a.HsnNature,
  a.GstinStatus,
  a.OurGSTIN,
  a.BookingDate,
  a.CarpetArea,
  a.UnitNo,
  a.PurchasingDocumentPriceUnit,
  a.Qty,
  a.Uom,
  a.IRN,
  a.Pan,
  a.ParkBy,
  a.PostBy,
  a.CompanyCodeCurrency,
  a.CompanyCodeName,
  c.UGSTAmt,
  a.CSreference,
  a.MilestoneDescp
