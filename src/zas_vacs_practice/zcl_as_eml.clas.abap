CLASS zcl_as_eml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_AS_EML IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DATA i_agency TYPE TABLE for UPDATE /DMO/R_AgencyTP.

  i_agency = VALUE #( ( AgencyID = '070003'  name = 'Modified Agency' ) ) .

  MODIFY ENTITIES OF /DMO/R_AgencyTP
  ENTITY /DMO/Agency
  UPDATE FIELDS ( name )
  with i_agency.

  COMMIT ENTITIES.


  ENDMETHOD.
ENDCLASS.
