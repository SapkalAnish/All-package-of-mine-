@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ROOT VIEW ENTITY'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZR_AS_I_TRAVEL
  as select from zas_travel
  composition [ 0..* ] of  ZI_AS_TRAVELITEM  as _item
{
  key travel_id       as TravelId,
  key travel_uuid     as travel_uuid,

      agency_id       as AgencyId,
      customer_id     as CustomerID,
      begin_date      as BeginDate,
      end_date        as EndDate,
      currency_code   as CurrencyCode,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      booking_fee     as BookingFee,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      total_price     as TotalPrice,

      description     as Description,
      status          as Status,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at as LastChangedAt,
      
      _item
}
