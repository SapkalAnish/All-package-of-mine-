@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ASSOCIATION EXAMPLE 1'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCDS_ASSOC_EX01 as select from /dmo/flight as a 
//                                                    inner join /dmo/booking as b on a.carrier_id = b.carrier_id
association [*] to /dmo/booking as _booking on a.carrier_id = _booking.carrier_id
{
    key a.carrier_id as carrier,
    a.connection_id,
    a.currency_code,
    @Semantics.amount.currencyCode: 'currency_code'
    a.price,
   _booking.booking_id as booking_id,
   _booking.customer_id as customer,
   _booking
    
}
where a.carrier_id = 'SQ'
