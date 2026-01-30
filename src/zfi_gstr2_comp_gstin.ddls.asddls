@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR2 - Company Gstin'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZFI_GSTR2_COMP_GSTIN
  as select from I_OperationalAcctgDocItem as a
{

  key CompanyCode,
  key AccountingDocument,
  key FiscalYear,
      BusinessPlace,
      case CompanyCode
      when '1100' then '06ABNCS8610B1ZF'
      when '1200' then '27AAJCN7374A1ZD'
      when '1300' then '27ABNCS8537R1Z4'
      when '2000' then ( case BusinessPlace
                          when '2009' then '09AAACH5716K1ZF'
                            when '2010' then '10AAACH5716K1ZW'
                            when '2008' then '08AAACH5716K1ZH'
                            when '2027' then '27AAACH5716K1ZH'
                            when '2022' then '22AAACH5716K1ZR'
                            when '2005' then '05AAACH5716K1ZN'
                            when '2023' then '23AAACH5716K1ZP' end )


      when '1000' then ( case BusinessPlace

                            when '1009' then '09AAACD8005H1ZU'
                            when '1010' then '10AAACD8005H1ZB'
                            when '1008' then '08AAACD8005H1ZW'
                            when '1006' then '06AAACD8005H1Z0'
                            when '1022' then '22AAACD8005H1Z6'
                            when '1027' then '27AAACD8005H1ZW'
                            when '1005' then '05AAACD8005H2Z1'
                            when '1023' then '23AAACD8005H1Z4'
                         end )

       when '3000' then ( case BusinessPlace
                          when '3009' then '09AAFCD2604R2ZA'
                          when '3027' then '27AAFCD2604R1ZD'
                            end )

       when '4000' then ( case BusinessPlace
                            when '4009' then '09AABCD2003N1ZU'
                            when '4010' then '10AABCD2003N2ZA'
                            when '4027' then '27AABCD2003N2ZV' end )


           end as CompGSTIN

}
group by
  CompanyCode,
  AccountingDocument,
  FiscalYear,
  BusinessPlace
