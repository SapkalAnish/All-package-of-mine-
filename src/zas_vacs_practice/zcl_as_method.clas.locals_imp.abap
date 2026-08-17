*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
 class lcl_connection definition .

        public section.

        DATA : carrier_id TYPE /dmo/carrier_id,
               connection_id type /dmo/connection_id .

        METHODS : set_attributes
                  IMPORTING
                  i_carrier_id type /dmo/carrier_id
                  i_connection_id type /dmo/connection_id
                  RAISING
                  cx_abap_invalid_value.
        protected section.
        private section.

      endclass.

      class lcl_connection implementation.

        method set_attributes.

        if i_carrier_id is INITIAL or i_connection_id is INITIAL.
        RAISE EXCEPTION TYPE cx_abap_invalid_value.
        ENDIF.

        carrier_id = i_carrier_id.
        connection_id = i_connection_id.

  endmethod.

endclass.
