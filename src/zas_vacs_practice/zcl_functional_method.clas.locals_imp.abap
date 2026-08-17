*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class lcl_connection DEFINITION.

PUBLIC SECTION.

*attributes
DATA: carrier_id type /dmo/carrier_id,
     connection_id type /dmo/connection_id.

*methods
METHODS : set_attributes
          importing
          i_carrier_id type /dmo/carrier_id
          i_connection_id type /dmo/connection_id,
          "functional methods
          get_output
          RETURNING VALUE(r_output) type string_table .


ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.

  METHOD set_attributes.

  carrier_id = i_carrier_id.
  connection_id = i_connection_id.

  ENDMETHOD.

  METHOD get_output.

  APPEND |carrier : { carrier_id }| to r_output.
  APPEND |connection : { connection_id }| to r_output.

  ENDMETHOD.

ENDCLASS.
