CLASS zcl_as_methods DEFINITION
  PUBLIC

  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_AS_METHODS IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DATA connection type REF to lcl_connection.

  DATA connections type table of REF TO lcl_connection  .


  connection = NEW #(  ).

  try.
  connection->set_attributes( EXPORTING
                              i_carrier_id = 'lh'
                              i_connection_id = '0400' ).
  out->write( |method called successful| ).
  catch cx_abap_invalid_value.
  out->write( |method failed| ) .
  ENDTRY.

  connection->carrier_id = 'lh'.
  connection->connection_id = '0400'.

  APPEND connection to connections.

      connection = NEW #(  ).
   connection->carrier_id = 'AA'.
  connection->connection_id = '0017'.

  APPEND connection to connections.

    connection = NEW #(  ).
   connection->carrier_id = 'SQ'.
  connection->connection_id = '0001'.

  APPEND connection to connections.

lcl_connection=>conn_counter = '1234'.

LOOP at connection->get_output( ) into DATA(line).

ENDLOOP.

out->write( data = connection->get_output( )
           name = '' ).

 LOOP AT connections INTO connection.

 out->write( connection->get_output(  ) ).
 ENDLOOP.

 out->write(
   EXPORTING
     data   = connections
*     name   =
*   RECEIVING
*     output =
 ).










  ENDMETHOD.
ENDCLASS.
