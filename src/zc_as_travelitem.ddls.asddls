@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PROJECT VIEW ENTITY FOR travelitem'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_AS_TravelItem as projection on ZI_AS_TRAVELITEM
{
    key ItemUuid,
    TravelUuid,
    AgencyId,
    Travelid,
    CarrierId,
    ConnectionId,
    FlightDate,
    BookingId,
    PassengerFirstName,
    PassengerLastName,
    Lastchangedat,
    /* Associations */
    _travel : redirected to parent ZC_AS_TRAVEL
}
