CLASS zcl_as_travel_insert DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_AS_TRAVEL_INSERT IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*    DATA lt_travel TYPE STANDARD TABLE OF zas_travel.
*
*    SELECT travel_id, agency_id, customer_id, begin_date, end_date,
*           currency_code, booking_fee, total_price, description, status
*      FROM /dmo/travel
*      INTO CORRESPONDING FIELDS OF TABLE @lt_travel.   " no row limit - pulls all records
*
*    " Generate a unique technical key for every row
*    LOOP AT lt_travel ASSIGNING FIELD-SYMBOL(<ls_travel>).
*      TRY.
*          <ls_travel>-travel_uuid = cl_system_uuid=>create_uuid_x16_static( ).
*        CATCH cx_uuid_error.
*          "handle exception
*      ENDTRY.
*    ENDLOOP.
*
*    IF lt_travel IS NOT INITIAL.
*      INSERT zas_travel FROM TABLE @lt_travel.
*      IF sy-subrc = 0.
*        COMMIT WORK AND WAIT.
*        out->write( |{ lines( lt_travel ) } records inserted successfully| ).
*      ELSE.
*        out->write( 'Insert failed - check for duplicate keys' ).
*      ENDIF.
*    ELSE.
*      out->write( 'No data found in /dmo/travel' ).
*    ENDIF.

insert ZAP_travel from ( select
Travel_id,
Agency_id,
Customer_id,
Begin_date,
End_date,
Booking_fee,
Total_price,
Currency_code,
Description,
Status
from /dmo/travel
).

COMMIT work.
out->write( 'data insert item ' ).
  ENDMETHOD.
ENDCLASS.
