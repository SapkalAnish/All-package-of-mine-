*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class lcl_connection DEFINITION INHERITING FROM zcl_as_structure.

PUBLIC SECTION.



METHODS : get_output
          RETURNING VALUE(r_output)  type string_table,
*          set_attributes
*          IMPORTING
*          i_carrier_id TYPE /dmo/carrier_id
*          i_connection_id type /dmo/connection_id
*          RAISING cx_abap_invalid_value.
           constructor
           IMPORTING
           i_carrier_id TYPE /dmo/carrier_id
           i_connection_id type /dmo/connection_id
           RAISING cx_abap_invalid_value.


CLASS-DATA : conn_counter type i.

PRIVATE SECTION.
DATA : carrier_id TYPE /dmo/carrier_id,
       connection_id TYPE /dmo/connection_id.
*       airport_from_id TYPE /dmo/airport_from_id ,
*       airport_to_id TYPE /dmo/airport_to_id,
*       carrier_name TYPE /dmo/carrier_name.

 TYPES : BEGIN OF st_details,
         DepartureAirport TYPE /dmo/airport_from_id,
         DestinationAirport type /dmo/airport_to_id,
         AirlineName type /dmo/carrier_name,
         END OF st_details.


DATA details type st_details.

ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.

  METHOD get_output.

  append |carrier_id : { carrier_id  }| to r_output.
  APPEND |connection_id : { connection_id } | to r_output.
  APPEND |airport_from_id : { details-departureairport } | to r_output.
  APPEND |airport_to_id : { details-destinationairport } | to r_output.
 APPEND | carrier_name : { details-airlinename } | to r_output.
*APPEND |airport_from_id : { airport_from_id } | to r_output.
*  APPEND |airport_to_id : { airport_to_id } | to r_output.
*  APPEND | carrier_name : { carrier_name } | to r_output.

  ENDMETHOD.

*  METHOD set_attributes.
*
*  if i_carrier_id is  INITIAL or i_connection_id is INITIAL.
*  RAISE EXCEPTION type cx_abap_invalid_value.
*
*  ENDIF.
*    carrier_id = i_carrier_id.
*  connection_id = i_connection_id.
*
*  ENDMETHOD.

  METHOD constructor.

    super->constructor( ).

    if i_carrier_id is  INITIAL or i_connection_id is INITIAL.
    RAISE EXCEPTION type cx_abap_invalid_value.
    ENDIF.

       SELECT  SINGLE
     FROM /DMO/I_Connection
     FIELDS
      DepartureAirport ,DestinationAirport , \_Airline-Name as AirlineName
     where AirlineID = @i_carrier_id and ConnectionID = @i_connection_id
     into  CORRESPONDING FIELDS OF @details.
*     into ( @airport_from_id , @airport_to_id,@carrier_name ).

     if sy-subrc <> 0.
     RAISE EXCEPTION TYPE cx_abap_invalid_value.
     ENDIF.

     me->carrier_id = i_carrier_id.
     me->connection_id = i_connection_id.

     conn_counter = conn_counter + 1.


  ENDMETHOD.

ENDCLASS.

