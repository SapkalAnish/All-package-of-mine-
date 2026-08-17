@AbapCatalog.sqlViewName: 'ZASICARRVH'
@AbapCatalog.compiler.compareFilter: true

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'unit8 : Exercise 19'
@Metadata.ignorePropagatedAnnotations: true
define view ZAS_I_CarrierVH as select from /dmo/carrier
{
    @UI.lineItem: [{ position : 20  }]
    key carrier_id as CarrierID,
    @UI.lineItem: [{ position : 30 }]
    name as Name

}
