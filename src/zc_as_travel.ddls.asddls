@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'AS: PROJECT VIEW ON TRAVEL'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_AS_TRAVEL
  provider contract transactional_query
  as projection on ZR_AS_I_TRAVEL
{
  key TravelId,
  key travel_uuid,

      @Consumption.valueHelpDefinition: [ { entity: { name: '/DMO/I_Agency_StdVH', element: 'AgencyID' } } ]
      AgencyId,

      @Consumption.valueHelpDefinition: [ { entity: { name: '/DMO/I_Customer_StdVH', element: 'CustomerID' } } ]
      CustomerID,

      BeginDate,
      EndDate,
      CurrencyCode,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      BookingFee,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      TotalPrice,

      Description,
      Status,
      @Semantics.systemDateTime.lastChangedAt: true
      LastChangedAt,

      // Redirect to the child projection view
      _item : redirected to composition child ZC_AS_TravelItem   // capital 'I' in Item
}
