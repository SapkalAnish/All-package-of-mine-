CLASS zcl_as_instances DEFINITION
  PUBLIC

  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_AS_INSTANCES IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DATA connection type REF to lcl_connection.

  DATA connections type table of REF TO lcl_connection  .


  connection = NEW #(  ).

  connection->carrier_id = 'lh'.
  connection->connection_id = '0400'.

  APPEND connection to connections.

   connection->carrier_id = 'SQ'.
  connection->connection_id = '0001'.

  APPEND connection to connections.

lcl_connection=>conn_counter = '1234'.









  ENDMETHOD.
ENDCLASS.
