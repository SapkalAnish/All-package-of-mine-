CLASS zcl_test5 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TEST5 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  out->write( 'How are you?'(hau) ).
  out->write( text-001 ).
DATA result type i.
DATA: text TYPE string.

text = 'env'.

result = numofchar( text ).

out->write( result ).
result = find( val = text sub = 'n' ).
out->write( result ).
  ENDMETHOD.
ENDCLASS.
