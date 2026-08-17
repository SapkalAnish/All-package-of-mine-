*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class lcl_connection DEFINITION INHERITING FROM zcl_as_local_class.

PUBLIC SECTION.

DATA : carrier_id TYPE /dmo/carrier_id,
       connection_id TYPE /dmo/connection_id.

CLASS-DATA : conn_counter type i.

ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.

ENDCLASS.

