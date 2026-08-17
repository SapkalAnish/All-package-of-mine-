CLASS zcl_complex_table DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_COMPLEX_TABLE IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  TYPES : BEGIN OF st_connection,
          carrier_id type /dmo/carrier_id,
          connection_id type /dmo/connection_id,
          airport_from_id type /dmo/airport_from_id,
          airport_to_id type /dmo/airport_to_id,
          carrier_name type /dmo/carrier_name,
          END OF st_connection.

*          example 1 : Simple and Complex internal Table

"simple table (scalar row type )

DATA numbers TYPE TABLE OF i.

"complex table(structured row type)
DATA : connections type table of st_connection.

out->write( |example 1 : simple and complex internal table| ).
out->write(
  EXPORTING
    data   = numbers
   name   =  'simple table numbers'
*  RECEIVING
*    output =
).

out->write(
  EXPORTING
    data   = connections
   name   = 'complex table connections'
*  RECEIVING
*    output =
).

*example 2 : complex internal tables

"standard table with non-unique standard key ( short form )

DATA: connections_1 TYPE table of st_connection,
      "standard table with non-unique standard key (explict form)
      connections_2 TYPE STANDARD TABLE OF st_connection WITH NON-UNIQUE DEFAULT KEY,
      "sorted table with non-unique explicit key
      connections_3 TYPE SORTED TABLE OF st_connection WITH NON-UNIQUE key airport_from_id airport_to_id,
      "sorted hashed with unique key explicit key
      connections_4 TYPE HASHED TABLE OF st_connection WITH UNIQUE KEY carrier_id connection_id.

* example 3 : Local Table Types

TYPES : tt_connections TYPE SORTED TABLE OF st_connection with UNIQUE key carrier_id connection_id.

DATA connections_5 TYPE tt_connections.

*example 4 : global table type

data flights type /dmo/t_flight.

out->write( |example 4 : global table type /dmo/t_flight| ).
out->write(
  EXPORTING
    data   = flights
   name   = |internal table flight|
*  RECEIVING
*    output =
).






  ENDMETHOD.
ENDCLASS.
