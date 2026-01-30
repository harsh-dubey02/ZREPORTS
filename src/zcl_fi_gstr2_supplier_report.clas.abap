CLASS zcl_fi_gstr2_supplier_report DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FI_GSTR2_SUPPLIER_REPORT IMPLEMENTATION.


  METHOD if_rap_query_provider~select.

*    IF io_request->is_data_requested( ).
    DATA: lt_response TYPE TABLE OF zfi_gstr2_tax_report,
          ls_response TYPE zfi_gstr2_tax_report.
    DATA(lv_top)           = io_request->get_paging( )->get_page_size( ).
    DATA(lv_skip)          = io_request->get_paging( )->get_offset( ).
    DATA(lt_clause)        = io_request->get_filter( )->get_as_sql_string( ).
    DATA(lt_fields)        = io_request->get_requested_elements( ).
    DATA(lt_sort)          = io_request->get_sort_elements( ).

    IF lv_top < 0.
      lv_top = 1.
    ENDIF.

    TRY.
        DATA(lt_filter_cond) = io_request->get_filter( )->get_as_ranges( ).
      CATCH cx_rap_query_filter_no_range INTO DATA(lx_no_sel_option).
    ENDTRY.


    DATA(lr_bukrs)   =  VALUE #( lt_filter_cond[ name   = 'BUKRS' ]-range OPTIONAL ).
    DATA(lr_bupla)   =  VALUE #( lt_filter_cond[ name   = 'BUPLA' ]-range OPTIONAL ).
    DATA(lr_budat)   =  VALUE #( lt_filter_cond[ name   = 'BUDAT' ]-range OPTIONAL ).
    DATA(lr_fkdat)   =  VALUE #( lt_filter_cond[ name   = 'FKDAT' ]-range OPTIONAL ).
    DATA(lr_mwskz)   =  VALUE #( lt_filter_cond[ name   = 'MWSKZ' ]-range OPTIONAL ).
    DATA(lr_blart)   =  VALUE #( lt_filter_cond[ name   = 'BLART' ]-range OPTIONAL ).



    SELECT FROM i_operationalacctgdocitem AS a
                 LEFT OUTER JOIN
                            i_supplier  AS b
                 ON ( a~supplier = b~supplier )
                 LEFT OUTER JOIN
                            zfi_gstr2_taxamt_f AS i
                 ON  a~accountingdocument = i~accountingdocument
                     AND a~fiscalyear         = i~fiscalyear
                     AND a~companycode        = i~companycode
                     AND a~taxcompanycode <> '**'
                 LEFT OUTER JOIN
                            i_operationalacctgdoctaxitem AS c
                 ON  a~companycode = c~companycode
                     AND a~accountingdocument = c~accountingdocument
                     AND a~accountingdocumentitem = c~taxitem

          FIELDS a~companycode,
                 a~businessplace,
                 a~accountingdocumenttype,
                 a~supplier,
                 a~billingdocument,
                 a~documentdate,
                 a~accountingdocumentitem,
                 a~in_hsnorsaccode AS hsncode,
                 a~product,
                 a~postingdate,
                 b~suppliername,
                 b~taxnumber3 AS suppliergstin ,
                 c~transactiontypedetermination AS gsttaxcode,
                 c~taxamountintranscrcy,
                 c~taxbaseamountintranscrcy
           WHERE  a~companycode     IN @lr_bukrs
           AND a~businessplace   IN @lr_bupla
           AND a~postingdate     IN @lr_budat
           AND a~documentdate    IN @lr_fkdat
           AND c~transactiontypedetermination IN @lr_mwskz
           AND a~accountingdocumenttype IN @lr_blart
           INTO TABLE @DATA(lt_data).


    LOOP AT lt_data INTO DATA(ls_data).

      ls_response-companycode                = ls_data-companycode.
      ls_response-businessplace             = ls_data-businessplace.
      ls_response-accountingdocumenttype    = ls_data-accountingdocumenttype.
      ls_response-supplier                  = ls_data-supplier.
      ls_response-billingdocument           = ls_data-billingdocument.
      ls_response-documentdate              = ls_data-documentdate.
      ls_response-accountingdocumentitem    = ls_data-accountingdocumentitem.
      ls_response-hsncode                   = ls_data-hsncode.
      ls_response-product                   = ls_data-product.
      ls_response-postingdate               = ls_data-postingdate.
      ls_response-suppliername              = ls_data-suppliername.
      ls_response-suppliergstin             = ls_data-suppliergstin.
      ls_response-gsttaxcode                = ls_data-gsttaxcode.
      ls_response-taxamountintranscrcy      = ls_data-taxamountintranscrcy.
      ls_response-taxbaseamountintranscrcy  = ls_data-taxbaseamountintranscrcy.
      ls_response-totalvalue                = ls_data-taxbaseamountintranscrcy + ls_data-taxamountintranscrcy.



      APPEND ls_response TO lt_response.
      CLEAR ls_response.

    ENDLOOP.

    io_response->set_total_number_of_records( lines( lt_data ) ).
    io_response->set_data( lt_response ).


  ENDMETHOD.
ENDCLASS.
