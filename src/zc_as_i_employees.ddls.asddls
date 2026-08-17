@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PROJECT VIEW ENTITY FOR EMPLOYEES'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_AS_I_EMPLOYEES
provider contract transactional_query as projection on ZR_AS_I_EMPLOYEE

{
    key EmpUuid,
    key Empid,
    Fname,
    Lname,
    Currencycode,
    @Semantics.amount.currencyCode: 'Currencycode'
    Salary,
    Dob,
    Age,
    Changedby,
    Lastchangedat
}
