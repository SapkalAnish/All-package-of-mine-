CLASS zcl_arithmetic1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_ARITHMETIC1 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*   declaration

    TYPES: t_result  TYPE p LENGTH 8 DECIMALS 2,
           t_result1 TYPE p LENGTH 8 DECIMALS 0,
           t_result2 TYPE i.

    DATA: result  TYPE t_result,
          result1 TYPE t_result,
          result2 TYPE t_result,
          result3 TYPE t_result,
          result4 TYPE t_result,
          result5 TYPE t_result,
          result6 TYPE t_result,
          result7 TYPE t_result.
* calculation
    result = 1 + 2.
    result1 = 2 - 3.
    result2 =  2 * 3.
    result3 = 2 / 3.
    result4 = sqrt( 2 ) .
    result5 = ipow( base = 2  exp = 3 ) .
    result6 = ( 8 * 7 - 6 ) / ( 5 + 4 ) .
    result7 = 8 * 7 - 6 / 5 + 4.

    out->write( result ).
    out->write( result1 ).
    out->write( result2 ).
    out->write( result3 ).
    out->write( result4 ).
    out->write( result5 ).
    out->write( result6 ).
    out->write( result7 ).

    out->write( 'anish' ).


    out->write( 'hello' ) .

  ENDMETHOD.
ENDCLASS.
