CLASS zcl_accessing_complex_tables DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_ACCESSING_COMPLEX_TABLES IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    TYPES : BEGIN OF st_connection,
              carrier_ID      TYPE /dmo/carrier_id,
              connection_id   TYPE /dmo/connection_id,
              airport_from_id TYPE /dmo/airport_from_id,
              airport_to_id   TYPE /dmo/airport_to_id,
              carrier_name    TYPE /dmo/carrier_name,
            END OF st_connection,

            tt_connections TYPE SORTED TABLE OF st_connection WITH NON-UNIQUE KEY carrier_id connection_id,

            BEGIN OF st_carrier,
              carrier_id    TYPE /dmo/carrier_id,
              currency_code TYPE /dmo/currency_code,
            END OF st_carrier.


    DATA : connections TYPE tt_connections,
           connection  LIKE LINE OF connections,

           carriers    TYPE STANDARD TABLE OF st_carrier WITH NON-UNIQUE KEY carrier_id,
           carrier     LIKE LINE OF carriers.

*           preparation : Fill internal Table with data

    connections = VALUE #( ( carrier_id = 'JL'
                              connection_id = '0408'
                              airport_from_id = 'FRA'
                              airport_to_id = 'NRT'
                              carrier_name = 'Japan Airlines' )
                              ( carrier_id = 'AA'
                                 connection_id = '0017'
                                 airport_from_id = 'MIA'
                                 airport_to_id = 'HAV'
                                 carrier_name = 'American Airlines' )
                                 ( carrier_id = 'SQ'
                                   connection_id = '0001'
                                   airport_from_id = 'SFO'
                                   airport_to_id = 'SIN'
                                   carrier_name = 'Singapore Airlines' )
                                   ( carrier_id = 'UA'
                                     connection_id = '0078'
                                     airport_from_id = 'SIN'
                                     airport_to_id = 'SFO'
                                     carrier_name = 'United Airlines' )
                                     ).

    carriers = VALUE #( ( carrier_id = 'SQ'
                          currency_code = '' )
                          ( carrier_id = 'JL'
                          currency_code = '' )
                          ( carrier_id = 'AA'
                            currency_code = ' ' )
                            ( carrier_id = 'UA'
                             currency_code = '' )
                             ).


*     example 1 : Table expression with key access

    out->write( |example 1 : table expression with key access| ).

    out->write(
      EXPORTING
        data   = connections
      name   = |internal table connections|
*  RECEIVING
*    output =
    ).

    " with key fields value

    connection = connections[ carrier_id = 'SQ'
                              connection_id = '0001' ].
    out->write(
      EXPORTING
        data   = connection
        name   = |carrier_id = 'SQ' and connection_id = '0001'|
*    RECEIVING
*      output =
    ).

    "with non key fields value

    connection =  connections[ airport_from_id = 'SFO'
                               airport_to_id   = 'SIN' ]  .

    out->write(
      EXPORTING
        data   = connection
        name   =  |aiport_from_id = sfo and airport_to_id = sin|
*     RECEIVING
*       output =
    ).

*   example 2 : loop with key access

    out->write( |example 2 : loop with key access| ).

    LOOP AT connections INTO connection WHERE airport_from_id <> 'MIA'.

      out->write(
        EXPORTING
          data   = connection
          name   = |this is the row number { sy-tabix } : |
*  RECEIVING
*    output =
      ).
    ENDLOOP.

*example 3 : modify table ( key access )

    out->write(  | example 3 : modify table (key access)| ).
    out->write(
      EXPORTING
        data   = carriers
        name   = |table carriers before modify table|
*  RECEIVING
*    output =
    ).

    carrier = carriers[ carrier_id = 'JL' ].

    carrier-currency_code = 'JFY'.

    MODIFY TABLE carriers FROM carrier.

    out->write(
      EXPORTING
        data   = carriers
        name   = |table carriers after modify table|
*  RECEIVING
*    output =
    ).

*example 4 : modify ( index access )

    out->write( |example 4 : modify(index access| ).

    carrier-carrier_id = 'LH'.
    carrier-currency_code = 'EUR'.

    MODIFY carriers FROM carrier INDEX 1.

    out->write(
      EXPORTING
        data   = carriers
        name   = |table carrier after modify with index|
*  RECEIVING
*    output =
    ).

*example 5 : modify in loop

    out->write( |example 5 : modify in loop| ).

    LOOP AT carriers INTO carrier WHERE currency_code IS INITIAL.

      carrier-currency_code = 'USD'.
      MODIFY carriers FROM carrier.
    ENDLOOP.

    out->write(
      EXPORTING
        data   = carriers
        name   = |table carriers after the loop |
*  RECEIVING
*    output =
    ).









  ENDMETHOD.
ENDCLASS.
