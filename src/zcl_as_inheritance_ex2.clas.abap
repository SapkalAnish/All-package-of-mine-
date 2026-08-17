CLASS zcl_as_inheritance_ex2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_AS_INHERITANCE_EX2 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    "** example of object declaration and creation using inline declaration technique ***
    DATA(lo_obj) = NEW lcl_vehicle( ).

    out->write(
      EXPORTING
        data = lcl_vehicle=>mv_s_text "calling static attribute of a class
    ).

    out->write(
      EXPORTING
        data = lo_obj->mv_text "calling instance attribute of a class
    ).

    out->write(
      EXPORTING
        data = lo_obj->mv_counter "calling instance attribute of a class
    ).

    DATA(lv_value) = lcl_vehicle=>set_counter( ).
    out->write(
      EXPORTING
        data = lcl_vehicle=>mv_s_counter "calling static attribute of a class
    ).

    lo_obj   = NEW lcl_vehicle( ).
    lv_value = lcl_vehicle=>set_counter( ). "calling static method of a class

    out->write(
      EXPORTING
        data = lo_obj->mv_counter "instance counter of the second object
    ).

    out->write(
      EXPORTING
        data = lv_value "current value returned by set_counter
    ).

  ENDMETHOD.
ENDCLASS.
