*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class lcl_connection DEFINITION INHERITING FROM zcl_as_methods.

PUBLIC SECTION.

DATA : carrier_id TYPE /dmo/carrier_id,
       connection_id TYPE /dmo/connection_id.

METHODS : get_output
          RETURNING VALUE(r_output)  type string_table,
          set_attributes
          IMPORTING
          i_carrier_id TYPE /dmo/carrier_id
          i_connection_id type /dmo/connection_id
          RAISING cx_abap_invalid_value.

CLASS-DATA : conn_counter type i.

ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.

  METHOD get_output.

  append |carrier_id : { carrier_id  }| to r_output.
  APPEND |connection_id : { connection_id } | to r_output.

  ENDMETHOD.

  METHOD set_attributes.

  if i_carrier_id is  INITIAL or i_connection_id is INITIAL.
  RAISE EXCEPTION type cx_abap_invalid_value.

  ENDIF.
    carrier_id = i_carrier_id.
  connection_id = i_connection_id.

  ENDMETHOD.

ENDCLASS.

