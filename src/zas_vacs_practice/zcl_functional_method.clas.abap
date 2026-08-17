CLASS zcl_functional_method DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FUNCTIONAL_METHOD IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  data :connection type ref to lcl_connection,
   connections type table of REF to lcl_connection.

*   CREATE instance
connection = new #(  ).
connection->set_attributes( exporting i_carrier_id = 'lh'
                                      i_connection_id = '0400' ).

APPEND connection to connections.

*calling functional methods

" in a value assignment ( with inline declaration for result)

data(result) = connection->get_output(  ).

" in logical expression
if connection->get_output(  ) is NOT INITIAL.

"as operand in a statement

LOOP AT connection->get_output(  ) into data(line).

ENDLOOP.

out->write( data = connection->get_output( )
            name = ' ' ).

ENDIF.



  ENDMETHOD.
ENDCLASS.
