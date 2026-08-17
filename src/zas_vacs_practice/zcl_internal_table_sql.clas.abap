CLASS zcl_internal_table_sql DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_INTERNAL_TABLE_SQL IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    TYPES : BEGIN OF st_airport,
              airportid TYPE /dmo/airport_id,
              name      TYPE /dmo/airport_name,
            END OF st_airport,
            tt_airports TYPE STANDARD TABLE OF st_airport WITH NON-UNIQUE KEY airportid.
    DATA : airports TYPE tt_airports.

*  example 1: Strcutured variables in select single ... into ..

    DATA airport_full TYPE /DMO/I_Airport.

    SELECT SINGLE FROM /DMO/I_Airport
    FIELDS AirportID , Name , City , CountryCode
    WHERE City = 'Zurich'
    INTO @airport_full.

    out->write( |example 1 : select single ..into..| ) .
    out->write(
      EXPORTING
        data   = airport_full
        name   = |one of  the airports in Zurich :|
*  RECEIVING
*    output =
    ).

*  example 2: internal tables in select .. into table ...

    DATA airports_full TYPE STANDARD TABLE OF /DMO/I_Airport WITH NON-UNIQUE KEY AirportID.

    SELECT FROM /DMO/I_Airport
    FIELDS
    AirportID , Name ,City , CountryCode
    WHERE City = 'London'
    INTO TABLE @airports_full.

    out->write( |  example 2: internal tables in select .. into table ...| )  .

    out->write( data = airports_full
                name = | all airports in London| ).


* example 3 : fields * and into corresponding fields of table

    SELECT FROM /DMO/I_Airport
    FIELDS *
    WHERE city = 'London'
    INTO CORRESPONDING FIELDS OF TABLE @airports.

    out->write( |example 3 : fields * and into corresponding fields of table | ) .

    out->write(
      EXPORTING
        data   = airports
        name   = 'internal table airports '
*  RECEIVING
*    output =
    ).

*     example 4 : inline declaration

    SELECT FROM /DMO/I_Airport
    FIELDS AirportID , Name AS Airportname
    WHERE city = 'London'
    INTO TABLE @DATA(airports_inline).

    out->write( |example 4 : inline declaration  after into table| ).
    out->write(
      EXPORTING
        data   = airports_inline
        name   = 'internal table airports_inline'
*  RECEIVING
*    output =
    ).

*example 4 : order by and distinct

    SELECT FROM
    /DMO/I_Airport
    FIELDS DISTINCT CountryCode
    ORDER BY CountryCode
    INTO TABLE @DATA(countrycode).

    out->write( countrycode ).

*example 5 : union all

    SELECT FROM /DMO/I_Carrier
    FIELDS 'Airlines' AS type , AirlineID AS id , Name
    WHERE CurrencyCode = 'GBP'

    UNION ALL

    SELECT FROM /DMO/I_Airport
    FIELDS 'Airport' AS type , airportid AS Id , name
    WHERE city = 'London'
    ORDER BY type, id
    INTO TABLE @DATA(names).

    out->write( 'example 5 : union all of airlines and airports' ).
    out->write(
      EXPORTING
        data   = names
        name   = |id and name of airlines and airports|
*  RECEIVING
*    output =
    ).







  ENDMETHOD.
ENDCLASS.
