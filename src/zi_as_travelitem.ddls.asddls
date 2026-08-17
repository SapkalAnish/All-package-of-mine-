@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'INTERVIEW FOR TRAVEL ITEM'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_AS_TRAVELITEM as select from zas_travelitem
association to parent ZR_AS_I_TRAVEL as _travel
    on $projection.Travelid = _travel.TravelId
   and $projection.TravelUuid = _travel.travel_uuid
{
    key item_uuid as ItemUuid,
    travel_uuid as TravelUuid,
    agency_id as AgencyId,
    travelid as Travelid,
    carrier_id as CarrierId,
    connection_id as ConnectionId,
    flight_date as FlightDate,
    booking_id as BookingId,
    passenger_first_name as PassengerFirstName,
    passenger_last_name as PassengerLastName,
    lastchangedat as Lastchangedat,
    _travel
}
