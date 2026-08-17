CLASS lhc_ZR_AS_I_EMPLOYEE DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zr_as_i_employee RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zr_as_i_employee RESULT result.
    METHODS validatesal FOR VALIDATE ON SAVE
      IMPORTING keys FOR zr_as_i_employee~validatesal.

ENDCLASS.

CLASS lhc_ZR_AS_I_EMPLOYEE IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD validatesal.

  READ ENTITIES OF zr_as_i_employee
  ENTITY zr_As_i_employee
  FIELDS ( Salary )
  WITH CORRESPONDING #( keys )
  RESULT DATA(lt_emp).
  if lt_emp is not INITIAL.
       data(ls_emp) = VALUE #( lt_emp[ 1 ] optional ).
      if ls_emp-salary <= 10000.

         APPEND VALUE #( %tky = ls_emp-%tky ) to failed-zr_as_i_employee.
         append value #(
                          %tky = ls_emp-%tky
                          %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error

                                             text = 'salary shoulde be greater than 10000')
                        ) to reported-zr_as_i_employee.


       ENDIF.

ENDIF.


  ENDMETHOD.

ENDCLASS.
