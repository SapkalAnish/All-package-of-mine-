CLASS zcl_conditional_branching_as DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_CONDITIONAL_BRANCHING_AS IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    CONSTANTS : c_number  TYPE i VALUE 0,
                c_number1 TYPE i VALUE 1,
                c_number2 TYPE i VALUE 2,
                c_number3 TYPE i VALUE -1,
                c_number4 TYPE i VALUE -2.

*  example 1 : simple if .... endif

    out->write( | example 1 : simple if .... endif| ).
    IF  c_number IS INITIAL.

      out->write( |the value of number is 0 :{ c_number }| ).

    ELSE.

      out->write( |the value is not initial :{ c_number }| ).


    ENDIF.

* example 2 : optional branches elseif and else

    out->write( | example 2 : optional branches elseif and else| ).

    IF c_number1 IS INITIAL.
      out->write( |the value of number is 0 :{ c_number }| ).
    ELSEIF c_number1 > 0.
      out->write( |the value of c_number1 is grater than zero : { c_number1 }|  ).
    ELSE.
      out->write( | the value of c_number1 is less than zero : { c_number1 } | ).
    ENDIF.

*  example 3 : case .... ENDCASE.

    out->write( |example 3 : case .... ENDCASE.| ).

    CASE c_number3.
      WHEN 0.
        out->write( |the value of number is 0 :{ c_number3 }| ).
      WHEN 1.
        out->write( |the value of c_number3 is 1 : { c_number3 }|  ).
      WHEN -2.
        out->write( | the value of c_number3 is -2 : { c_number3 } | ).
      WHEN OTHERS.
        out->write( | the value of c_number3 is non  of above : { c_number3 } | ).
    ENDCASE.









  ENDMETHOD.
ENDCLASS.
