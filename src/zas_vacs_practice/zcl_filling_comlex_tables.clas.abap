CLASS zcl_filling_comlex_tables DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FILLING_COMLEX_TABLES IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    TYPES :BEGIN OF st_connection,
             carrier_id      TYPE /dmo/carrier_id,
             connection_id   TYPE /dmo/connection_id,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
             carrier_name    TYPE /dmo/carrier_name,
           END OF st_connection,

           tt_connections TYPE STANDARD TABLE OF st_connection WITH NON-UNIQUE KEY carrier_id connection_id,

           BEGIN OF st_carrier,
             carrier_id   TYPE /dmo/carrier_id,
             carrier_name TYPE /dmo/carrier_name,
           END OF st_carrier,

           tt_carriers TYPE STANDARD TABLE OF st_carrier WITH NON-UNIQUE KEY carrier_id.

    DATA  : connections TYPE tt_connections,
            carriers    TYPE tt_carriers.

*  example 1 : Append with structured data object ( work area )

    DATA :connection TYPE st_connection.

    "declare the work area with like line of

    DATA connection1 LIKE LINE OF connections.

    connection-carrier_id = 'NN'   .
    connection-connection_id = '1234'.
    connection-airport_from_id = 'ABC'.
    connection-airport_to_id = 'XYZ' .
    connection-carrier_name = 'My Airline'.

    connection1 = VALUE #( carrier_id = 'AS'
                           connection_id = '4567'
                           airport_from_id = 'XCV'
                           airport_to_id = 'LON'
                           carrier_name = 'INDOGo' ).

    APPEND connection1 TO connections   .

    out->write( |example 1 : Append with work area| )  .
    out->write( connections ).

* example 2 : Append with value #(  ) expression

    APPEND VALUE #( carrier_id = 'NN'
                    connection_id = '1234'
                    airport_from_id = 'ABC'
                    airport_to_id = 'XYZ'
                    carrier_name = 'My Airline' )
                    TO connections.

    out->write( |example 2 : Append with value| ).
    out->write( connections )   .

*   example 3 : Filling an Internal Table with Several Rows

    carriers =  VALUE #( ( carrier_id = 'AA'
                         carrier_name = |american airlines| )
                         ( carrier_id = |JL| carrier_name = |Japan Airlines| )
                         ( carrier_id = |SQ| carrier_name = |Singapore Airlines| ) )   .

    out->write( |Example 3 : Fill internal table with value| ) .
    out->write( carriers )  .

* example 4 : Filling one internal table from another

    connections = CORRESPONDING #( carriers ).

    out->write( |example 4 : corresponding for internal tables| )  .
    out->write(
      EXPORTING
        data   = carriers
       name   = |source table carriers|
*   RECEIVING
*     output =
    ).

    out->write(
      EXPORTING
        data   = connections
        name   =  |target table connections|
*   RECEIVING
*     output =
    ).







  ENDMETHOD.
ENDCLASS.
