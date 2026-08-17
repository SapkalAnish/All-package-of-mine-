CLASS zcl_access_structure DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_ACCESS_STRUCTURE IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    TYPES: BEGIN OF st_connection,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
             carrier_name    TYPE /dmo/carrier_name,
           END OF st_connection,
           BEGIN OF st_connection_nested,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
             message         TYPE symsg,
             carrier_name    TYPE /dmo/carrier_name,
           END OF st_connection_nested.

    DATA : connection        TYPE st_connection,
           connection_nested TYPE st_connection_nested.

* example 1 : Access to structure components

    connection-airport_from_id = 'ABC'.
    connection-airport_to_id = 'xyz'.
    connection-carrier_name = 'My Airline'.

    "Access to subcomponents of nested structures

    connection_nested-message-msgty = 'E'.
    connection_nested-message-msgid = 'ABC'   .
    connection_nested-message-msgno = '123'.

    out->write( connection ).
    out->write( connection_nested ).

*example 2 : Filling a structure with value #(   )

    CLEAR connection.

    connection = VALUE #( airport_from_id = 'LON'
                          airport_to_id = 'wxy'
                          carrier_name = 'My_airlines' ).

    "nested value to fill nested structure
    connection_nested = VALUE #( airport_from_id = 'IND'
                                 airport_to_id = 'ABC'
                                  message = VALUE #( msgty = 'E'
                                                     msgid = 'cbn'
                                                     msgno = '012' )
                                   carrier_name = 'practice'         ) .
    out->write( connection ).
    out->write( connection_nested ).

*example 3 : wrong result after direct assignment

    connection_nested = connection.

    out->write( |example 3 : wrong result after direct assignment | ) .
    out->write(
      EXPORTING
        data   = connection
       name   = 'Source Structure'
*  RECEIVING
*    output =
    ).

    out->write( |component coonrction_nested-message-msgid : { connection_nested-message-msgid }| ) .
    out->write( |component connection_nested-carrier_name : { connection_nested-carrier_name }| ) .

*example 4 : Assigning Structure using corresponding #( )

    CLEAR connection_nested.

    connection_nested = CORRESPONDING #( connection ).

    out->write( |example 4 : correct result after assignment with corresponding| ).
    out->write(
      EXPORTING
        data   = connection
*      name   =
*    RECEIVING
*      output =
    ).

    out->write( |component coonrction_nested-message-msgid : { connection_nested-message-msgid }| ) .
    out->write( |component connection_nested-carrier_name : { connection_nested-carrier_name }| ) .
  ENDMETHOD.
ENDCLASS.
