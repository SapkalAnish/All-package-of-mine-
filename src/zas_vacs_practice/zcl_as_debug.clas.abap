CLASS zcl_as_debug DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_AS_DEBUG IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    TYPES: t_amount     TYPE p LENGTH 8 DECIMALS 2,
           t_percentage TYPE p LENGTH 2 DECIMALS 1.

*         INPUT FOR CALCULATION

    CONSTANTS: loan_total      TYPE t_amount     VALUE '50000',
               interest_rate   TYPE t_percentage VALUE '2.0',
               payment_month   TYPE t_amount VALUE '1000.00',
               spec_repay_year TYPE t_amount VALUE '10000.00',
*            extra payment per year
               spec_repay_mode TYPE c LENGTH 1 VALUE 'q'.

*            OUTPUT

    DATA: loan_remaining      TYPE t_amount,
          interset_month      TYPE t_amount,
          repayment_month     TYPE t_amount,
          interset_total      TYPE t_amount,
          special_repayment   TYPE t_amount,

          months_counter      TYPE i,
          months_btw_spec_pay TYPE i,
          repayment_plan      TYPE TABLE OF string.

*     PROCESSING

    " INITIALIZATIONS

    loan_remaining = loan_total.

    CASE spec_repay_mode.
      WHEN 'a'.
        months_btw_spec_pay = 12.
        special_repayment = spec_repay_year.
      WHEN 'H'.
        months_btw_spec_pay = 6.
        special_repayment = spec_repay_year / 2.
      WHEN 'q'.
        months_btw_spec_pay = 3.
        special_repayment = spec_repay_year / 4.
      WHEN OTHERS.
        out->write( 'invalid extra payment mode' ).

    ENDCASE.

*calculation

    DO.

      IF loan_remaining <= 0.

        EXIT.

      ENDIF.

      DO months_btw_spec_pay TIMES.

        months_counter = months_counter + 1.

        "calculate interest and back payment for current month

        interset_month = loan_remaining * ( interest_rate / 100 ) / 12.

        repayment_month = payment_month - interset_month.

        interset_total = interset_total + interset_month.

        loan_remaining = loan_remaining - repayment_month.

* add payment to Repayment_plan

        APPEND | month { months_counter } - interset:{ interset_month } Remaining loan: { loan_remaining } |
         TO repayment_plan.

        IF loan_remaining < 0.
          EXIT.

        ENDIF.

      ENDDO.

      IF loan_remaining < 0.

        EXIT.
      ENDIF.

      loan_remaining = loan_remaining - special_repayment.

      APPEND | special repayment of { special_repayment }! remaining loan { loan_remaining } |

      TO repayment_plan.

    ENDDO.

* output

    out->write( | stating value of loan: { loan_total } | ).
    out->write( | monthly payment: { payment_month } | ).
    out->write( |special repayment { special_repayment } every { months_btw_spec_pay } months.| ).
    out->write( |----------------------------------------Result--------------------------------| ).
    out->write( |total repayment after { months_counter DIV 12 } years and { months_counter MOD 12 } months.| ).
    out->write( |total interest paid: { interset_total }| ).
    out->write( name = 'repayment_plan:'
                data = repayment_plan ).






















  ENDMETHOD.
ENDCLASS.
