CLASS zcl_string_literals DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_STRING_LITERALS IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  types t_amount type p length 8 DECIMALS 2.

  DATA: amount TYPE t_amount VALUE '3.30',
        amount1 TYPE t_amount value '1.20',
        amount2 TYPE t_amount VALUE '2.10',
        the_date TYPE d   VALUE '19891109',
        my_number type p length 3 DECIMALS 2 value '-273.15',
        part1 TYPE string value 'hello',
        part2 TYPE string value 'world'.



*        string templeates
DATA(text) = |hello world|.
DATA(text2) = |total : { amount1 + amount2 }|.
data(text3) = |firstword : { part1 }|.
data(text4) = |total : { amount } EUR|.
data(text5) = |total : { amount1 + amount2 } INR|.

* format option


data(text6) = |raw date : { the_date }|.
data(text7) = |iso date : { the_date  date = ISO }|.
data(text8) = |user date : { the_date DATE = USER }|.


*number

data(text9) = |raw number :{ my_number }|.
data(text10) = |user format : { my_number NUMBER = USER } |.
data(text11) = |sign right : { my_number SIGN = RIGHT }|.
data(text12) = |scientific : { my_number STYLE = SCIENTIFIC }|.

*concate operation

data(text13) = part1 && part2.
data(text14) = part1 && | | && part2.
DATA(text15) = |{ amount1 } + { amount2 }| && |=| && |{ amount1 + amount2 }|.

out->write( text ).
out->write( text2 ).
out->write( text3 ).
out->write( text4 ).
out->write( text5 ).
out->write( text6 ).
out->write( text7 ).
out->write( text8 ).
out->write( text9 ).
out->write( text10 ).
out->write( text11 ).
out->write( text12 ).
out->write( text13 ).
out->write( text14 ).
out->write( text15 ).
out->write( the_date ).

**** alternative code for above
*  " basic templates & concatenation
*    out->write( |hello world| ).
*    out->write( |total : { amount1 + amount2 }| ).
*    out->write( |firstword : { part1 }| ).
*    out->write( |total : { amount } EUR| ).
*    out->write( |total : { amount1 + amount2 } INR| ).
*
*    " date formatting
*    out->write( |raw date : { the_date }| ).
*    out->write( |iso date : { the_date DATE = ISO }| ).
*    out->write( |user date : { the_date DATE = USER }| ).
*
*    " number formatting
*    out->write( |raw number : { my_number }| ).
*    out->write( |user format : { my_number NUMBER = USER }| ).
*    out->write( |sign right : { my_number SIGN = RIGHT }| ).
*    out->write( |scientific : { my_number STYLE = SCIENTIFIC }| ).
*
*    " concatenation operators
*    out->write( part1 && part2 ).
*    out->write( part1 && || && part2 ).
*    out->write( |{ amount1 } + { amount2 }| && |=| && |{ amount1 + amount2 }| ).








  ENDMETHOD.
ENDCLASS.
