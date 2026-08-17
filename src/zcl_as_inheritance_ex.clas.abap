CLASS zcl_as_inheritance_ex DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS ZCL_AS_INHERITANCE_EX IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

***example of object declaration and creation using INLINE declaration technique***
    DATA(lo_obj) = NEW lcl_VEHICLE(  ). "1st instantiation of local class

    OUT->write(
      EXPORTING
        data   = LCL_VEHICLE=>mv_s_text "CALLING STATIC ATTRIBUTE OF A CLASS

    ).

     OUT->write(
      EXPORTING
        data   = LO_OBJ->MV_TEXT "CALLING INSTANCE ATTRIBUTE OF A CLASS

    ).

     OUT->write(
      EXPORTING
        data   = LO_OBJ->mv_counter "CALLING INSTANCE ATTRIBUTE OF A CLASS


    ).


**Static Methods/Attributes of a class is called by class name **
    DATA(LV_VALUE) = lcl_VEHICLE=>set_counter(  )."CALLING A METHOD OF A CLASS

     OUT->write(
      EXPORTING
        data   = LCL_VEHICLE=>MV_S_COUNTER "CALLING STATIC ATTRIBUTE OF A CLASS

    ).


    lo_obj = NEW lcl_VEHICLE(  ). "2nd nstantiation of local class

    LV_VALUE = LCL_VEHICLE=>SET_COUNTER(  )."CALLING STATIC METHOD OF A CLASS

        OUT->write(
      EXPORTING
        data   = LCL_VEHICLE=>MV_S_COUNTER "CALLING STATIC ATTRIBUTE OF A CLASS

    ).

        OUT->write(
      EXPORTING
        data   = LO_OBJ->mv_COUNTER "CALLING instance  ATTRIBUTE OF A CLASS

    ).



  ENDMETHOD.
ENDCLASS.
