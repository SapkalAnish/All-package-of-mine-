CLASS zcl_simple_table DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SIMPLE_TABLE IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*  internal table declaration

DATA numbers TYPE table of i.

* table type local
TYPES tt_strings type table of string.

DATA texts1 type tt_strings.

* table type global

DATA texts2 TYPE TABLE of string_table.
DATA texts3 TYPE string_table.

* workarea

data number TYPE i VALUE 1234.
DATA text type string.

* example 1  : APPEND

APPEND 4711 to numbers.
APPEND number to numbers.
APPEND 2 * number to numbers.

out->write( |example 1 : appemd number | ).
out->write(  numbers ).

* example 2 : clear
clear numbers.
out->write( |example 2 : clear number | ).
out->write( numbers ).

* example 3 : table expression

APPEND 4711 to numbers.
APPEND number to numbers.
append 2 * number to numbers.

out->write( |example 3 : table expression| ).

number = numbers[ 1 ].

out->write( |context of row 1 :{ number }| ).

number = numbers[ 2 ].

out->write( |context of row 2 :{ number }| ).

out->write( |context of row : { numbers[ 3 ] }| ).

out->write( |context of row0 : { numbers[ 1 ] }| ).
* example 4 : loop .... endloop

out->write( |example 4: loop| ).

LOOP AT numbers into number .

out->write( |row: (sy-tabix) content { number }| ).

ENDLOOP.

*example 5 : inline declaration in loop of workarea

out->write( |example 5 :inline| ).

LOOP AT numbers into data(number1_inline).
out->write( |row: (sy-tabix) content { number1_inline }| ).

ENDLOOP.










  ENDMETHOD.
ENDCLASS.
