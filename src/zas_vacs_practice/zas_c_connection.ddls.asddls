@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZASACONN'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZAS_C_Connection
  provider contract transactional_query
  as projection on ZAS_R_Connection
  association [1..1] to ZAS_R_Connection as _BaseEntity on $projection.UUID = _BaseEntity.UUID
{
  key UUID,
  
  @Consumption.valueHelpDefinition: [{ entity: {name: 'ZAS_I_CarrierVH',
                                                element: 'CarrierID'} }]
  CarrierID,
  ConnectionID,
  AirportFromID,
  CityFrom,
  CountryFrom,
  AirportToID,
  CityTo,
  CountryTo,
  @Semantics: {
    user.createdBy: true
  }
  LocalCreatedBy,
  @Semantics: {
    systemDateTime.createdAt: true
  }
  LocalCreatedAt,
  @Semantics: {
    user.localInstanceLastChangedBy: true
  }
  LocalLastChangedBy,
  @Semantics: {
    systemDateTime.localInstanceLastChangedAt: true
  }
  LocalLastChangedAt,
  @Semantics: {
    systemDateTime.lastChangedAt: true
  }
  LastChangedAt,
  _BaseEntity
}
