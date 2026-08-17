CLASS zcl_select DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SELECT IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA : airport_from_id TYPE /dmo/airport_from_id,
           airport_to_id   TYPE  /dmo/airport_to_id.

* example 1:  select single field from single record
    SELECT SINGLE FROM /dmo/connection
    FIELDS
    airport_from_id
    WHERE
    carrier_id = 'LH'  AND connection_id = '0400'
    INTO @airport_from_id.

    out->write( |Example 1 :| ).
    out->write( |flight LH departs from : { airport_from_id }| ) .

*example 2 : multiple field from single record

    SELECT SINGLE FROM /dmo/connection
    FIELDS
    airport_from_id , airport_to_id
    WHERE
    carrier_id = 'SQ' AND connection_id = '0001'
    INTO ( @airport_from_id  , @airport_to_id )  .

    out->write( |Example 2 :| ).
    out->write( |flight SQ departs from : { airport_from_id } to destination : { airport_to_id }| ).

*example 3 : empty result and sy-subrc

    SELECT SINGLE
    FROM /dmo/connection
    FIELDS
    carrier_id ,
    airport_from_id
    WHERE
    carrier_id = 'xx' AND connection_id = '0017'
    INTO ( @DATA(airport_carrier_ID) , @DATA(airport_from_id2) ) .

    IF sy-subrc EQ 0.
      out->write( |example 3:| ).
      out->write( |flight { airport_carrier_id } depats from : { airport_from_id2 }| ).
    ELSE.
      out->write( |there is no flight { airport_carrier_ID } but still airport_from_id = { airport_from_id2 } !| ).

    ENDIF.






  ENDMETHOD.
ENDCLASS.
