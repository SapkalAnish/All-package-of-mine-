CLASS zcl_sql DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SQL IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    SELECT  FROM /DMO/FLIGHT
    FIELDS
    carrier_id AS carrier,
    connection_id,
    flight_date,
    price,
    currency_code,
    CASE currency_code WHEN 'SGD' THEN 'SIGNAPORE DOLLAR'
                       WHEN 'USD' THEN 'US DOLLAR'
                       WHEN 'JPY' THEN 'JAPANESE YEN'
                       WHEN 'eur' THEN 'EURO'
                       ELSE 'OTHER'
                       END AS currency_description,

                       plane_type_id,
                       seats_max,
                       seats_occuPIed,
                       seats_max - seats_occuPIed AS SEAT_aVAILABLE,
                       ( CAST( SEATS_OCCUPIED AS FLTP ) * CAST( 100 AS FLTP ) / CAST( SEATS_MAX AS FLTP ) ) AS PERCENTAGE_FLTP
                       ORDER BY CARRIER_ID,FLIGHT_DATE
                       INTO TABLE @DATA(LT_FLIGHT)

    .

   OUT->write(
     EXPORTING
       data   = LT_FLIGHT
*
   ).



    ENDMETHOD.
ENDCLASS.
