CLASS zcl_all_variable DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  DATA myint type i .
  DATA my_pack TYPE p LENGTH 10 DECIMALS 2.
  data my_char18 TYPE c LENGTH 18 value 'abcdefnji'.
  DATA mychar4 TYPE c LENGTH 4.
  DATA my_string TYPE string.






    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_ALL_VARIABLE IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*    DATA variable TYPE string.
*    DATA variable TYPE i.
*     DATA variable TYPE n LENGTH 10.
*     DATA variable TYPE d.
*     DATA variable TYPE p DECIMALS 2.
     data variable TYPE c LENGTH 10 .
*

out->write( 'Ressult with initial value' ).
out->write( variable ).
out->write( '---------' ).

variable = '19891109'.

out->write( 'result with value 19891109' ).
out->write( variable ).
out->write( '----------------' ).

myint = 8.
my_pack = '-273.15'.
myint = mychar4.
mychar4 = my_char18.
my_string = 'hello'.









  ENDMETHOD.
ENDCLASS.
