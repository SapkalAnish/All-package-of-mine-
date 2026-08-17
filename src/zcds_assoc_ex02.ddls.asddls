@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ASSOCIATION EXAMPLE 2'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCDS_ASSOC_EX02 as select from /dmo/customer
association[*] to ZCDS_ASSOC_EX01 as _cust on $projection.customer = _cust.customer
{
    key customer_id as customer,
    concat( first_name , last_name ) as name,
    _cust
}
