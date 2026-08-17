*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_VEHICLE DEFINITION.

  PUBLIC SECTION.

** INTANCE IF CLASS **
    DATA : mv_text TYPE string.
    DATA : mv_counter TYPE i.

    METHODS :
      constructor.

* STATIC ATTRIBUTE **
    CLASS-DATA : mv_s_text TYPE string.
    CLASS-DATA : mv_s_counter TYPE i.

    CLASS-METHODS:
      class_constructor,
      set_counter RETURNING VALUE(r_value) TYPE i.
ENDCLASS.


CLASS lcl_VEHICLE IMPLEMENTATION.
  METHOD class_constructor.

    mv_s_text = 'THIS IS A STATIC CONTRO CALL'.

  ENDMETHOD.

  METHOD constructor.

    DATA : lv_counter TYPE i.

    mv_counter = mv_counter + lv_counter + 1.

    mv_text = 'THIS IS A INSTANCE CONTROLLER'.

  ENDMETHOD.

  METHOD set_counter.

    DATA:lv_counter TYPE i.



    r_value = lv_counter + 1.
    mv_s_counter = mv_s_counter + r_value.

  ENDMETHOD.

ENDCLASS.
