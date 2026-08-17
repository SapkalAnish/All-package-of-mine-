CLASS zcl_as_constructor DEFINITION
  PUBLIC

  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_AS_CONSTRUCTOR IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA connection TYPE REF TO lcl_connection.

    DATA connections TYPE TABLE OF REF TO lcl_connection  .

    TRY.
        connection = NEW #( i_carrier_id = 'lh'
                            i_connection_id = '0400' ).
        APPEND connection to connections.
      CATCH cx_abap_invalid_value.
        out->write( |value is invalid| ).
    ENDTRY.

        LOOP AT connection->get_output( ) INTO DATA(line).

    ENDLOOP.

    out->write( data = connection->get_output( )
               name = '' ).
   out->write( |conn_counter : { lcl_connection=>conn_counter }| ).

    TRY.
        connection = NEW #( i_carrier_id = 'AA'
                            i_connection_id = '0017' ).
        APPEND connection TO connections.
      CATCH cx_abap_invalid_value.
        out->write( |value is invalid| ).
        APPEND connection TO connections.
    ENDTRY.

        LOOP AT connection->get_output( ) INTO DATA(line1).

    ENDLOOP.

    out->write( data = connection->get_output( )
               name = '' ).
    out->write( |conn_counter : { lcl_connection=>conn_counter }| ).


    TRY.
        connection = NEW #( i_carrier_id = 'SQ'
                            i_connection_id = '0001' ).
        APPEND connection TO connections.
      CATCH cx_abap_invalid_value.
        out->write( |value is invalid| ).
    ENDTRY.

        LOOP AT connection->get_output( ) INTO line. "just trying for own purpose

    ENDLOOP.

    out->write( data = connection->get_output( )
               name = '' ).
    out->write( |conn_counter : { lcl_connection=>conn_counter }| ).

*  try.
*  connection->set_attributes( EXPORTING
*                              i_carrier_id = 'lh'
*                              i_connection_id = '0400' ).
*  out->write( |method called successful| ).
*  catch cx_abap_invalid_value.
*  out->write( |method failed| ) .
*  ENDTRY.
*
*  connection->carrier_id = 'lh'.
*  connection->connection_id = '0400'.
*
*  APPEND connection to connections.
*
*      connection = NEW #(  ).
*   connection->carrier_id = 'AA'.
*  connection->connection_id = '0017'.
*
*  APPEND connection to connections.
*
*    connection = NEW #(  ).
*   connection->carrier_id = 'SQ'.
*  connection->connection_id = '0001'.

*  APPEND connection to connections.

*    lcl_connection=>conn_counter = '1234'.



    LOOP AT connections INTO connection.

      out->write( connection->get_output(  ) ).

      out->write( |conn_counter : { lcl_connection=>conn_counter }| ).


    ENDLOOP.

*    out->write(
*      EXPORTING
*        data   = connections
**     name   =
**   RECEIVING
**     output =
*    ).










  ENDMETHOD.
ENDCLASS.
