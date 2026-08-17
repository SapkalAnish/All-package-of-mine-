CLASS zas_cl_01072026 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZAS_CL_01072026 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA : lt_employees TYPE TABLE OF zas_employees.
    lt_employees = VALUE #( (  client = sy-mandt
                             empid = 'E001'
                             fname = 'Ajay'
                             lname = 'sharma'
                             currencycode = 'INR'
                             salary = 20000
                             dob = '19870624' )

                            (   client = sy-mandt
                             empid = 'E002'
                             fname = 'abhishek'
                             lname = 'saini'
                             currencycode = 'INR'
                             salary = 20000
                             dob = '20040624'

                                   ) ) .


    LOOP AT lt_employees INTO DATA(ls_employees).
      INSERT zas_employees FROM @ls_employees.
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
