CLASS zcl_iterations_as DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_ITERATIONS_AS IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    CONSTANTS : c_number  TYPE i VALUE 3,
                c_number1 TYPE i VALUE 5,
                c_number2 TYPE i VALUE 10.

    DATA number TYPE i.

*  example 1 : do ... endo with times
    out->write( | example 1 : do ... endo with times| ) .
    DO c_number TIMES.
      out->write( |*| ).
      out->write( |*| ).
      out->write( 1 ).
      out->write( |hello world| ).
      out->write( |anish| ).
      out->write( |*| ).
    ENDDO.

      DO c_number2 TIMES.
      out->write( |*| ).

      ENDDO.

*example 2 : do .... enddo with abort condition

    out->write( |example 2 : do .... enddo with abort condition| ).

    number = c_number * c_number1.

    DO.

      out->write( |{ sy-index }: value of number : { number }| ).
      number = number - 1.
      IF number <= c_number.
        EXIT.
      ENDIF.
    ENDDO.




  ENDMETHOD.
ENDCLASS.
