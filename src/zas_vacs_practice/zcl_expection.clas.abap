CLASS zcl_expection DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_EXPECTION IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA result TYPE i.
    DATA numbers TYPE TABLE OF i.

    APPEND 123 TO numbers.

*  example 1: Conversion error ( no number )

    CONSTANTS c_text TYPE string VALUE 'ABC'.
    CONSTANTS c_text1 TYPE string VALUE 123.

    out->write( |example 1: Conversion error ( no number )| ).

    TRY.
        result = c_text.
        out->write( |converted content is { result }| ).
      CATCH cx_sy_conversion_no_number.
        out->write( |error : { c_text } is not a number| ).
    ENDTRY.

*example 2 : division by zero error

    CONSTANTS : c_number  TYPE i VALUE 0,
                c_number1 TYPE i VALUE 7.

    out->write( |example 2 : division by zero error| ).

    TRY.
        result = 100 / c_number.
        out->write( |100 divided by { c_number } equals { result }| ).
      CATCH cx_sy_zerodivide.
        out->write( |error : division by zero is not defined| ).
    ENDTRY.

*example 3 : itab  error ( line not found)

    CONSTANTS: c_index  TYPE i VALUE 2,
               c_index1 TYPE i VALUE 1.

    out->write( |example 3 : itab  error| ).

    TRY.
        result = numbers[ c_index ].
        out->write( |content of row { c_index } equlas { result }| ).
      CATCH cx_sy_itab_line_not_found.
        out->write( |error : itab has less than { c_index } row| ).
    ENDTRY.

*example 4 : combination of different excepation
    CONSTANTS : c_char  TYPE c LENGTH 1 VALUE 'x',
                c_char2 TYPE c LENGTH 1 VALUE '1',
                c_char3 TYPE c LENGTH 1 VALUE '0',
                c_char4 TYPE c LENGTH 1 VALUE '2'.

    out->write( |example 4 : combination of different excepation| ).

    TRY.

        result = numbers[ 2 / c_char ].
        out->write( | result : { result } | ).
      CATCH cx_sy_zerodivide.
        out->write( |error : division by zero is not defined| ).
      CATCH cx_sy_conversion_no_number.
        out->write( |error : { c_char } is not a number| ).
      CATCH cx_sy_itab_line_not_found.
        out->write( |error : itab has less than { 2 / c_char } row| ).
    ENDTRY.







  ENDMETHOD.
ENDCLASS.
