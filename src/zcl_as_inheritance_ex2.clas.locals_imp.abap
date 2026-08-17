*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_vehicle DEFINITION.

  PUBLIC SECTION.
    "** INSTANCE ATTRIBUTES/METHODS ****
    DATA: mv_text    TYPE string.
    DATA: mv_counter TYPE i.

    METHODS:
      constructor.

    "*** STATIC ATTRIBUTES/METHODS ****
    CLASS-DATA: mv_s_text    TYPE string.
    CLASS-DATA: mv_s_counter TYPE i.

    CLASS-METHODS:
      class_constructor,
      set_counter RETURNING VALUE(r_value) TYPE i.

ENDCLASS.

CLASS lcl_vehicle IMPLEMENTATION.

  METHOD constructor.
    mv_text = 'this is instance constructor call'.

    " increment static counter each time an instance is created,
    " and store the running total in the instance attribute
    mv_s_counter = mv_s_counter + 1.
    mv_counter   = mv_s_counter.
  ENDMETHOD.

  METHOD class_constructor.
    mv_s_text = 'this is a static constructor call'.
  ENDMETHOD.

  METHOD set_counter.
    " increment static counter and return the new value
    mv_s_counter = mv_s_counter + 1.
    r_value      = mv_s_counter.
  ENDMETHOD.

ENDCLASS.
