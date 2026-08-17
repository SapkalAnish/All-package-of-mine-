class ltcl_ definition final for testing
  duration short
  risk level harmless.

  private section.
    methods:
      first_test for testing raising cx_static_check.
endclass.


class ltcl_ implementation.

  method first_test.

  DATA variable1 TYPE i VALUE '1234'.
  data variable2 type i value '1234'.
    cl_abap_unit_assert=>fail( 'Implement your first test here' ).
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = variable1
        exp                  = variable2
*        ignore_hash_sequence = abap_false
*        tol                  =
*        msg                  =
*        level                = if_abap_unit_constant=>severity-medium
*        quit                 = if_abap_unit_constant=>quit-test
*      RECEIVING
*        assertion_failed     =
    ).
  endmethod.

endclass.  "* use this source file for your ABAP unit test classes

