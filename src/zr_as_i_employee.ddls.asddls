@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'EMPLOYEES ROOT VIEW ENTITY'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZR_AS_I_EMPLOYEE as select from zas_employees
//composition of target_data_source_name as _association_name
{
    key emp_uuid as EmpUuid,
    key empid as Empid,
    fname as Fname,
    lname as Lname,
    currencycode as Currencycode,
    @Semantics.amount.currencyCode: 'Currencycode'
    salary as Salary,
    dob as Dob,
    age as Age,
    changedby as Changedby,
    lastchangedat as Lastchangedat
  //  _association_name // Make association public
}
