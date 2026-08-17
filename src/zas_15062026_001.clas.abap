CLASS zas_15062026_001 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.


****attribute of class****
    DATA : ms_flight TYPE /dmo/flight. "Work area as attribute"
    DATA : mv_text TYPE string.
    CONSTANTS : gc_text TYPE string VALUE 'constructor is called '.

    METHODS:
      constructor,
      display_flight.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZAS_15062026_001 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*declearing reference variable of a class ***

    DATA: lo_obj TYPE REF TO zas_15062026_001.

*Instantiating object of a class ***

    lo_obj = NEW zas_15062026_001( ).

*calling   method of a class **
    lo_obj->display_flight(  ).

    out->write(
    EXPORTING
      data   = lo_obj->mv_text

  ).


    out->write(
      EXPORTING
        data   = lo_obj->ms_flight

    ).


  ENDMETHOD.


  METHOD display_flight.

*** SELECT SINGLE is to read single row from the database table and keeping it into workarea directly ***
    SELECT SINGLE * FROM /dmo/flight
    INTO  @me->ms_flight.

    IF sy-subrc = 0.
      " ME  is self referencing system defined reference variable (object of class)

    ENDIF.
  ENDMETHOD.


  METHOD constructor.

    mv_text = gc_text.

  ENDMETHOD.
ENDCLASS.
