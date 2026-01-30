@ObjectModel: {
    query: {
       implementedBy: 'ABAP:ZCL_FI_GSTR2_SUPPLIER_REPORT'
    }
}

@UI.headerInfo: { typeName: 'GSTR Report' ,
                  typeNamePlural: 'GSTR Report' }


@EndUserText.label: 'GSTR2 Report'
define custom entity Zfi_gstr2_tax_report
{

      @UI.facet                : [{ id : 'Bukrs',
                purpose        : #STANDARD,
                type           : #IDENTIFICATION_REFERENCE,
                label          : 'Sales Register',
                position       : 10 },

                { id           : 'fkdat',
                purpose        : #STANDARD,
                type           : #IDENTIFICATION_REFERENCE,
                label          : 'Billing Date',
                position       : 20 } 
                ]

      @UI.selectionField       : [{ position: 10 }]
      @UI.lineItem             : [{ label: 'Company Code', position: 10 }]
      @UI.identification       : [{ label: 'Company Code', position: 10 }]
  key companycode              : bukrs;

      @UI.selectionField       : [{ position: 20 }]
      @UI.lineItem             : [{ label: 'Business Place', position: 20 }]
      @UI.identification       : [{ label: 'Business Place', position: 20 }]
  key businessplace            : bwkey;

      @UI.selectionField       : [{ position: 30 }]
      @UI.lineItem             : [{ label: 'Accounting Document Type', position: 30 }]
      @UI.identification       : [{ label: 'Accounting Document Type', position: 30 }]
  key accountingdocumenttype   : blart;

      @UI.selectionField       : [{ position: 40 }]
      @UI.lineItem             : [{ label: 'Supplier', position: 40 }]
      @UI.identification       : [{ label: 'Supplier', position: 40 }]
  key supplier                 : lifnr;

      @UI.selectionField       : [{ position: 50 }]
      @UI.lineItem             : [{ label: 'Billing Document', position: 50 }]
      @UI.identification       : [{ label: 'Billing Document', position: 50 }]
  key billingdocument          : vbeln;

      @UI.selectionField       : [{ position: 60 }]
      @UI.lineItem             : [{ label: 'Document Date', position: 60 }]
      @UI.identification       : [{ label: 'Document Date', position: 60 }]
  key documentdate             : datum;

      @UI.selectionField       : [{ position: 70 }]
      @UI.lineItem             : [{ label: 'Accounting Document Item', position: 70 }]
      @UI.identification       : [{ label: 'Accounting Document Item', position: 70 }]
  key accountingdocumentitem   : posnr;

      @UI.selectionField       : [{ position: 80 }]
      @UI.lineItem             : [{ label: 'HSN/SAC Code', position: 80 }]
      @UI.identification       : [{ label: 'HSN/SAC Code', position: 80 }]
      hsncode                  : abap.char(20);

      @UI.selectionField       : [{ position: 90 }]
      @UI.lineItem             : [{ label: 'Product', position: 90 }]
      @UI.identification       : [{ label: 'Product', position: 90 }]
      product                  : matnr;

      @UI.selectionField       : [{ position: 100 }]
      @UI.lineItem             : [{ label: 'Posting Date', position: 100 }]
      @UI.identification       : [{ label: 'Posting Date', position: 100 }]
      postingdate              : datum;

      @UI.lineItem             : [{ label: 'Supplier Name', position: 110 }]
      @UI.identification       : [{ label: 'Supplier Name', position: 110 }]
      suppliername             : abap.char(40);

      @UI.lineItem             : [{ label: 'Supplier GSTIN', position: 120 }]
      @UI.identification       : [{ label: 'Supplier GSTIN', position: 120 }]
      suppliergstin            : stcd3;

      @UI.lineItem             : [{ label: 'GST Tax Code', position: 130 }]
      @UI.identification       : [{ label: 'GST Tax Code', position: 130 }]
      gsttaxcode               : abap.char(4);
      @UI.lineItem             : [{ label: 'Currency', position: 135 }]
      @UI.identification       : [{ label: 'Currency', position: 135 }]
      currency                 : waers;

      @UI.lineItem             : [{ label: 'Tax Amount', position: 140 }]
      @UI.identification       : [{ label: 'Tax Amount', position: 140 }]
      @Semantics.amount.currencyCode: 'currency'
      taxamountintranscrcy     : abap.curr(13,2);

      @UI.lineItem             : [{ label: 'Tax Base Amount', position: 150 }]
      @UI.identification       : [{ label: 'Tax Base Amount', position: 150 }]
      @Semantics.amount.currencyCode: 'currency'
      taxbaseamountintranscrcy : abap.curr(13,2);

      @UI.lineItem             : [{label: 'Total Value', position: 260 ,importance: #HIGH }]
      @UI.identification       : [{ label: 'Total Value', position: 260 }]
      @Semantics.amount.currencyCode: 'currency'
      totalvalue               : abap.curr(10,2);


}
