CLASS zcl_fill_travelitem DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

ENDCLASS.



CLASS ZCL_FILL_TRAVELITEM IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA: lt_travel        TYPE TABLE OF zas_travel,
          lt_travelitem    TYPE TABLE OF zas_travelitem,
          ls_travelitem    TYPE zas_travelitem,
          lv_uuid          TYPE sysuuid_x16,
          lv_travel_uuid_b TYPE sysuuid_x16,
          lv_initial_uuid  TYPE sysuuid_x16,
          lt_fix           TYPE TABLE OF zas_travelitem.

    "==========================================================
    " PART A: Generic - 1 travel item for EVERY travel record
    "==========================================================

    out->write( '========== PART A: Generic fill for all travels ==========' ).

    CLEAR: lt_travel, lt_travelitem.

    SELECT * FROM zas_travel
      INTO TABLE @lt_travel
      UP TO 5 ROWS.

    out->write( |Step A1: Found { lines( lt_travel ) } record(s) in ZAS_TRAVEL.| ).

    IF lt_travel IS INITIAL.
      out->write( 'PART A skipped: No records found in ZAS_TRAVEL.' ).
    ELSE.

      LOOP AT lt_travel INTO DATA(ls_travel).

        out->write( |Processing travel_id: { ls_travel-travel_id }, agency_id: { ls_travel-agency_id }| ).

        TRY.
            lv_uuid = cl_system_uuid=>create_uuid_x16_static( ).
          CATCH cx_uuid_error INTO DATA(lx_uuid).
            out->write( |UUID generation failed: { lx_uuid->get_text( ) }| ).
            CONTINUE.
        ENDTRY.

        CLEAR ls_travelitem.
        ls_travelitem-item_uuid            = lv_uuid.
        ls_travelitem-travel_uuid          = ls_travel-travel_uuid.
        ls_travelitem-agency_id            = ls_travel-agency_id.
        ls_travelitem-travelid             = ls_travel-travel_id.
        ls_travelitem-carrier_id           = 'LH'.
        ls_travelitem-connection_id        = '0400'.
        ls_travelitem-flight_date          = cl_abap_context_info=>get_system_date( ) + 30.
        ls_travelitem-booking_id           = '00001'.
        ls_travelitem-passenger_first_name = 'John'.
        ls_travelitem-passenger_last_name  = 'Doe'.
        ls_travelitem-lastchangedat        = cl_abap_context_info=>get_system_date( ).

        APPEND ls_travelitem TO lt_travelitem.

      ENDLOOP.

      out->write( |Step A2: Built { lines( lt_travelitem ) } travel item record(s) to insert.| ).

      IF lt_travelitem IS NOT INITIAL.
        INSERT zas_travelitem FROM TABLE @lt_travelitem.
        out->write( |Step A3: INSERT sy-subrc = { sy-subrc }| ).

        IF sy-subrc = 0.
          COMMIT WORK AND WAIT.
          out->write( |PART A SUCCESS: { lines( lt_travelitem ) } travel item(s) inserted.| ).
        ELSE.
          ROLLBACK WORK.
          out->write( 'PART A FAILED: Insert did not succeed (sy-subrc <> 0).' ).
        ENDIF.
      ELSE.
        out->write( 'PART A: Nothing to insert - lt_travelitem is empty.' ).
      ENDIF.

    ENDIF.

    "==========================================================
    " PART B: Specific - 5 travel items for Travel ID 00004147
    "==========================================================

    out->write( '========== PART B: 5 items for Travel 00004147 ==========' ).

    CLEAR lt_travelitem.

    CONSTANTS: lc_travel_id TYPE /dmo/travel_id VALUE '00004147',
               lc_agency_id TYPE /dmo/agency_id VALUE '070002'.

    CLEAR lv_travel_uuid_b.

    SELECT SINGLE travel_uuid FROM zas_travel
      WHERE travel_id = @lc_travel_id
      INTO @lv_travel_uuid_b.

    IF sy-subrc <> 0.
      out->write( |Travel ID { lc_travel_id } not found in ZAS_TRAVEL. Skipping Part B.| ).
    ELSE.

      out->write( |Travel ID { lc_travel_id } found. Creating 5 travel items...| ).

      DO 5 TIMES.
        TRY.
            lv_uuid = cl_system_uuid=>create_uuid_x16_static( ).
          CATCH cx_uuid_error.
            CONTINUE.
        ENDTRY.

        CLEAR ls_travelitem.
        ls_travelitem-item_uuid            = lv_uuid.
        ls_travelitem-travel_uuid          = lv_travel_uuid_b.
        ls_travelitem-agency_id            = lc_agency_id.
        ls_travelitem-travelid             = lc_travel_id.
        ls_travelitem-carrier_id           = 'LH'.
        ls_travelitem-connection_id        = |{ sy-index WIDTH = 4 ALIGN = RIGHT PAD = '0' }|.
        ls_travelitem-flight_date          = cl_abap_context_info=>get_system_date( ) + sy-index.
        ls_travelitem-booking_id           = |000{ sy-index }|.
        ls_travelitem-passenger_first_name = |Passenger{ sy-index }|.
        ls_travelitem-passenger_last_name  = |Traveler{ sy-index }|.
        ls_travelitem-lastchangedat        = cl_abap_context_info=>get_system_date( ).

        APPEND ls_travelitem TO lt_travelitem.
      ENDDO.

      out->write( |Built { lines( lt_travelitem ) } item record(s) for Travel { lc_travel_id }. Inserting...| ).

      INSERT zas_travelitem FROM TABLE @lt_travelitem.

      IF sy-subrc = 0.
        COMMIT WORK AND WAIT.
        out->write( |PART B SUCCESS: { lines( lt_travelitem ) } travel item(s) inserted for Travel { lc_travel_id }.| ).
      ELSE.
        ROLLBACK WORK.
        out->write( 'PART B FAILED: Insert did not succeed. Check for duplicate key or type mismatch.' ).
      ENDIF.

    ENDIF.

    "==========================================================
    " PART C: Backfill travel_uuid for any pre-existing rows
    "          that still have a blank travel_uuid
    "==========================================================

    out->write( '========== PART C: Backfill travel_uuid on old rows ==========' ).

    CLEAR: lt_fix, lv_initial_uuid.

    SELECT * FROM zas_travelitem
      WHERE travel_uuid = @lv_initial_uuid
      INTO TABLE @lt_fix.

    out->write( |Found { lines( lt_fix ) } row(s) with blank travel_uuid.| ).

    IF lt_fix IS NOT INITIAL.

      LOOP AT lt_fix ASSIGNING FIELD-SYMBOL(<fix_item>).
        SELECT SINGLE travel_uuid FROM zas_travel
          WHERE travel_id = @<fix_item>-travelid
          INTO @<fix_item>-travel_uuid.
      ENDLOOP.

      MODIFY zas_travelitem FROM TABLE @lt_fix.

      IF sy-subrc = 0.
        COMMIT WORK AND WAIT.
        out->write( |PART C SUCCESS: { lines( lt_fix ) } row(s) backfilled with travel_uuid.| ).
      ELSE.
        ROLLBACK WORK.
        out->write( 'PART C FAILED: Backfill update did not succeed.' ).
      ENDIF.

    ELSE.
      out->write( 'PART C: No rows needed backfilling.' ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
