CLASS zcl_strcutured_data_objects DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_STRCUTURED_DATA_OBJECTS IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    TYPES: BEGIN OF st_connection,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
             carrier_name    TYPE /dmo/carrier_name,
           END OF st_connection,
           BEGIN OF st_connection_short,
             DepatureAirport    TYPE /dmo/airport_from_id,
             DestinationAirport TYPE /dmo/airport_to_id,
           END OF st_connection_short.

    DATA: connection       TYPE st_connection,
          connection_short TYPE st_connection_short,
          connection_full  TYPE /DMO/I_Connection.

*  example 1 : Correspondence between Fields and into
    SELECT SINGLE FROM /dmo/i_connection
    FIELDS
    DepartureAirport,DestinationAirport,\_Airline-Name
    WHERE
    AirlineID = 'LH' AND ConnectionID = '0400'
    INTO @connection.

    out->write( |example 1 : field list and into| ) .
    out->write( connection ) .

*example 2 : Fields

    SELECT SINGLE FROM /DMO/I_Connection
    FIELDS *
    WHERE AirlineID = 'LH' AND ConnectionID = '0400'
    INTO @connection_full.

    out->write( |example 2 : fields * and into | ).
    out->write( connection_full ).

*example 3 : into corresponding fields

    SELECT SINGLE FROM /DMO/I_Connection
    FIELDS *
    WHERE
    AirlineID = 'LH' AND ConnectionID = '0400'
    INTO CORRESPONDING FIELDS OF @connection_short.

    out->write( |example 3 : fileds * and into corresponding fields| ).
    out->write( connection_short ).

*example 4 : Alias name for fields

    SELECT SINGLE FROM /DMO/I_Connection
    FIELDS
    DepartureAirport AS airport_from_id , \_Airline-Name AS carrier_name
    WHERE
    AirlineID = 'LH' AND ConnectionID = '0400'
    INTO CORRESPONDING FIELDS OF @connection.

    out->write( |example 4 : Aliases and corresponding fields of | ).
    out->write( connection ).

*example 5 : inline declaration

    SELECT SINGLE FROM /DMO/I_Connection
    FIELDS DepartureAirport, DestinationAirport AS ArrivalAirport,\_Airline-Name AS carrier_name
    WHERE
    AirlineID = 'LH ' AND ConnectionID = '0400'
    INTO @DATA(connection_inline).

    out->write( |example 5 : Aliases and inline declaration | ).
    out->write( connection_inline ).

*example 6 : joins

    SELECT SINGLE FROM ( /dmo/connection AS c
       LEFT OUTER JOIN /dmo/airport AS f
       ON c~airport_from_id = f~airport_id )
       LEFT OUTER JOIN /dmo/airport AS t
       ON c~airport_to_id = t~airport_id
       FIELDS c~airport_from_id , c~airport_to_id,f~name AS airport_from_name, t~name AS airport_to_name
       WHERE c~carrier_id = 'LH' AND c~connection_id = '0400'
       INTO @DATA(connection_join).

    out->write( |example 6 : join of cinnection and airports| ).
    out->write( connection_join ).






  ENDMETHOD.
ENDCLASS.
