CLASS zcl_as_read_internal_table1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.


    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_AS_READ_INTERNAL_TABLE1 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    TYPES : BEGIN OF ty_output,
              carrier_id    TYPE /dmo/flight-carrier_id,
              connection_id TYPE /dmo/flight-connection_id,
              fldate        TYPE /dmo/flight-flight_date,
              price         TYPE /dmo/flight-price,
              name          TYPE /dmo/carrier-name,
*              booking       TYPE /dmo/booking-booking_id,
*              booking_date  type /dmo/booking-flight_date,
*              booking_amount TYPE /dmo/booking-flight_price,
*              customer_id   TYPE /dmo/booking-customer_id,
*              customer_name type string,
            END OF ty_output.

    DATA: lt_output TYPE TABLE OF ty_output,
          ls_output TYPE ty_output.



     SELECT *
    FROM /dmo/flight AS a JOIN /dmo/carrier AS b ON a~carrier_id =  b~carrier_id
    INTO TABLE @DATA(lt_flight).



*    SELECT a~carrier_id, a~connection_id, a~flight_date,a~price,b~name
*    FROM /dmo/flight AS a JOIN /dmo/carrier AS b ON a~carrier_id =  b~carrier_id
*    INTO TABLE @DATA(lt_flight).






*    SELECT FROM /dmo/flight AS a
*      JOIN /dmo/carrier AS b ON a~carrier_id = b~carrier_id
*      FIELDS a~carrier_id,
*             a~connection_id,
*             a~flight_date AS fldate,
*             a~price,
*             b~name
*      INTO TABLE @DATA(lt_flight).

*    IF sy-subrc EQ 0.
*
*      SELECT
*      FROM /dmo/booking AS c JOIN /dmo/customer AS d ON c~customer_id = d~customer_id
*      FIELDS c~booking_id AS booking,
*             c~carrier_id,
*             c~flight_date as booking_Date,
*             c~flight_price as booking_amount,
*             d~customer_id,
*             d~first_name && d~last_name AS customer_name
*
*             INTO TABLE @DATA(lt_booking).


*
*   LOOP at lt_flight into data(ls_flight).
*
*   ls_output-carrier_id = ls_flight-a-carrier_id.
*   ls_output-connection_id = ls_flight-a-connection_id.
*   ls_output-fldate = ls_flight-a-flight_date.
*   ls_output-price = ls_flight-a-price.
*   ls_output-name = ls_flight-b-name.
*   APPEND ls_output to lt_output.
*
*
*   ENDLOOP.


      lt_output = CORRESPONDING #(  lt_flight ).

*      LOOP AT lt_booking into data(ls_booking).
*
*      ls_output-carrier_id = ls_booking-carrier_id.
*      ls_output-connection_id = value #( lt_flight[ a-carrier_id = ls_booking-carrier_id ]-a-connection_id optional ).
*
*
*
*      ENDLOOP.

*      sort lt_flight by carrier_id connection_id.
*      DELETE ADJACENT DUPLICATES FROM lt_flight.
*
*      lt_output = value #( for ls_booking in lt_booking
*
*                          (     booking = ls_booking-booking
*                            booking_amount = ls_booking-booking_amount
*                            booking_date   = ls_booking-booking_date
*                            customer_id = ls_booking-customer_id
*                            customer_name = ls_booking-customer_name
*                            carrier_id = ls_booking-carrier_id
*                            connection_id = lt_flight[  carrier_id = ls_booking-carrier_id ]-connection_id
*      ) ).
*
      out->write( lt_output ).



*    ENDIF.





  ENDMETHOD.
ENDCLASS.
