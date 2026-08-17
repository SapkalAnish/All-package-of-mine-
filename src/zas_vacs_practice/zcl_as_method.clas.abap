CLASS zcl_as_method DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_AS_METHOD IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  constants: c_carrier_id type /dmo/carrier_id value 'LH',
             c_connection_id type /dmo/connection_id value '0400'.

       data connection type ref to lcl_connection.

       DATA connections type TABLE of REF TO lcl_connection.

*       CREATE instances

connection = new #(  ).

* call method and handle the exception

out->write( |i_carrier_id : '{ c_carrier_id }'| ).
out->write( |c_connection_id : '{ c_connection_id }'| ).

try.
connection->set_attributes( EXPORTING i_carrier_id = c_carrier_id
                                      i_connection_id = c_connection_id ).

   APPEND connection to connections.
   out->write( |method called successful| )  .
catch cx_abap_invalid_value.
 out->write( |method call failed| ).

ENDTRY.



  ENDMETHOD.
ENDCLASS.
