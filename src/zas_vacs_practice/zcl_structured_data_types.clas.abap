CLASS zcl_structured_data_types DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_STRUCTURED_DATA_TYPES IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*  example 1 : Motivation for Structured Variables

DATA connection_full TYPE /DMO/I_Connection.

SELECT SINGLE FROM /DMO/I_Connection
FIELDS
AirlineID,ConnectionID,DepartureAirport,DestinationAirport
WHERE AirlineID = 'LH' and ConnectionID = '0400'
INTO @connection_full.

out->write( |example 1 : cds view as structured type| ).
out->write( connection_full ).

*example 2 : global structured types

DATA message TYPE symsg.

out->write( |example 2 : global structured types| ).
out->write( message ).

*example 3 : local structured types

TYPES : BEGIN OF st_connection,

        airport_from_id type /dmo/airport_from_id,
        airport_to_id TYPE /dmo/airport_to_id,
        carrier_name TYPE /dmo/carrier_name,
        END OF st_connection.

  DATA connection TYPE st_connection.

  SELECT single from /DMO/I_Connection
  FIELDS
  DepartureAirport, DestinationAirport ,\_Airline-Name
  WHERE
  AirlineID = 'LH' and ConnectionID = '0400'
  INTO @connection.

  out->write( |example 3 : local structured types| ) .

  out->write( connection ).

*  example 4 : nested structure types

TYPES : BEGIN OF st_nested,
        airport_from_id type /dmo/airport_from_id,
        airport_to_id TYPE /dmo/airport_to_id,
        message TYPE symsg,
        carrier_name TYPE /dmo/carrier_name,
        END OF st_nested.

        data connection_nested type st_nested.

        out->write( ' example 4 : nested structure types' ).
        out->write( connection_nested ).






  ENDMETHOD.
ENDCLASS.
