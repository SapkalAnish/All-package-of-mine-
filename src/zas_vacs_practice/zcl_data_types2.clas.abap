CLASS zcl_data_types2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_DATA_TYPES2 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*  example1: LOCAL TYPES

types: my_type type string,
       my_type1 type i,
       my_type2 TYPE d, "specifies date
       my_type3 TYPE c length 1, "length is mandatory otherwise by default value be 1
       my_type4 TYPE n length 10, " length is mandatory
       my_type5 type p length 5 DECIMALS 2. "length and decimal is mandatory

*       variable based on local type
       DATA my_variable TYPE my_type5.

       out->write( 'my_variable( type my_type )' ).
       out->write( my_variable ).

*       example2 : global types

DATA airport TYPE /dmo/airport_id  VALUE 'fra'.

out->write( 'airpot (type /dmo/airport_id) ' ).
out->write( airport ).

* example3: constants

CONSTANTS : c_text type string value 'hello world',
            c_number TYPE i value 12345.
*            c_text2 TYPE string. value is mandatory in constant
out->write( 'c_text (type string)' ).
out->write( c_text ).

out->write( 'c_number (type i)' ).
out->write( c_number ).

*example4 : Literals

out->write( '12345   ' ). "text literal type (type c)
out->write( `12345    ` ). "string literal (type string)
out->write( 12345       ). "number literal (type i)

*out->wrtie( 12345.45    )." syntax error no number literal with digits decimal is mot allowed  even in single quote deciaml is not allowed in literal or direct writing in write statement it will lead to syntax error

















  ENDMETHOD.
ENDCLASS.
