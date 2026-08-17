CLASS lhc__item DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS validateflightdate FOR VALIDATE ON SAVE
      IMPORTING keys FOR _item~validateflightdate.

    METHODS copyParentKeys FOR DETERMINE ON MODIFY
      IMPORTING keys FOR _item~copyParentKeys.

ENDCLASS.

CLASS lhc__item IMPLEMENTATION.

METHOD validateflightdate.

  CONSTANTS lc_area TYPE string VALUE 'FLIGHTDATE'.

  READ ENTITIES OF zr_as_i_travel IN LOCAL MODE
    ENTITY _item
      FIELDS ( FlightDate )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_items).

  READ ENTITIES OF zr_as_i_travel IN LOCAL MODE
    ENTITY _item BY \_travel
      FIELDS ( BeginDate )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_travels)
      LINK DATA(lt_links).

  LOOP AT lt_items ASSIGNING FIELD-SYMBOL(<item>).

    APPEND VALUE #(
      %tky        = <item>-%tky
      %state_area = lc_area ) TO reported-_item.

   DATA ls_begin LIKE LINE OF lt_travels.

    READ TABLE lt_links ASSIGNING FIELD-SYMBOL(<link>)
         WITH KEY source-%tky = <item>-%tky.

    IF sy-subrc = 0.
      READ TABLE lt_travels INTO ls_begin
           WITH KEY %tky = <link>-target-%tky.
    ENDIF.

    IF <item>-FlightDate IS INITIAL.

      APPEND VALUE #( %tky = <item>-%tky ) TO failed-_item.

      APPEND VALUE #(
          %tky                = <item>-%tky
          %msg                = NEW zcm_as_travel(
                                   textid = zcm_as_travel=>field_empty )
          %element-FlightDate = if_abap_behv=>mk-on
          %state_area         = lc_area )
      TO reported-_item.

    ELSEIF ls_begin-BeginDate IS NOT INITIAL
       AND <item>-FlightDate < ls_begin-BeginDate.

      APPEND VALUE #( %tky = <item>-%tky ) TO failed-_item.

      APPEND VALUE #(
          %tky                = <item>-%tky
          %msg                = NEW zcm_as_travel(
                                   textid = zcm_as_travel=>flight_before_begin )
          %element-FlightDate = if_abap_behv=>mk-on
          %state_area         = lc_area )
      TO reported-_item.

  ELSEIF <item>-FlightDate < cl_abap_context_info=>get_system_date( ).

  APPEND VALUE #( %tky = <item>-%tky ) TO failed-_item.

  DATA(lo_msg) = NEW zcm_as_travel(
                    textid      = zcm_as_travel=>flight_date_past
                    flight_date = <item>-FlightDate ).



  APPEND VALUE #(
      %tky                = <item>-%tky
      %msg                = lo_msg
      %element-FlightDate = if_abap_behv=>mk-on
      %state_area         = lc_area )
  TO reported-_item.



    ENDIF.

  ENDLOOP.

ENDMETHOD.
  METHOD copyParentKeys.
    " Read parent Travel entity data using association
    READ ENTITIES OF zr_as_i_travel IN LOCAL MODE
      ENTITY _item
        BY \_travel
        FIELDS ( TravelId AgencyId )
      WITH CORRESPONDING #( keys )
      RESULT DATA(travels)
      LINK DATA(links).

    CHECK links IS NOT INITIAL.

    " Update child item fields (this requires readonly:update in BDEF)
    MODIFY ENTITIES OF zr_as_i_travel IN LOCAL MODE
      ENTITY _item
      UPDATE FIELDS ( TravelId AgencyId )
      WITH VALUE #( FOR link IN links
                    LET travel = travels[ %tky = link-target-%tky ]
                    IN ( %tky     = link-source-%tky
                         TravelId = travel-TravelId
                         AgencyId = travel-AgencyId ) )
      REPORTED DATA(lt_reported).

    reported = CORRESPONDING #( DEEP lt_reported ).
  ENDMETHOD.
ENDCLASS.


CLASS lhc_ZR_AS_I_TRAVEL DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR travel RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR travel RESULT result.

    METHODS cancel_travel FOR MODIFY
      IMPORTING keys FOR ACTION travel~cancel_travel.

    METHODS issue_message FOR MODIFY
      IMPORTING keys FOR ACTION travel~issue_message.

    METHODS validatedescription FOR VALIDATE ON SAVE
      IMPORTING keys FOR travel~validatedescription.

    METHODS validatecustomer FOR VALIDATE ON SAVE
      IMPORTING keys FOR travel~validatecustomer.

    METHODS validatebegindate FOR VALIDATE ON SAVE
      IMPORTING keys FOR travel~validatebegindate.

    METHODS validatedatasequence FOR VALIDATE ON SAVE
      IMPORTING keys FOR travel~validatedatasequence.

    METHODS validateenddate FOR VALIDATE ON SAVE
      IMPORTING keys FOR travel~validateenddate.

    METHODS determinestatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR travel~determinestatus.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR travel RESULT result.

    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE travel.

ENDCLASS.


CLASS lhc_ZR_AS_I_TRAVEL IMPLEMENTATION.

  METHOD get_instance_authorizations.
    result = VALUE #( FOR key IN keys
                        ( %tky    = key-%tky
                          %update = if_abap_behv=>auth-allowed
                          %delete = if_abap_behv=>auth-allowed ) ).
  ENDMETHOD.

  METHOD get_global_authorizations.
    result-%create = if_abap_behv=>auth-allowed.
  ENDMETHOD.

  METHOD cancel_travel.

    READ ENTITIES OF zr_as_i_travel IN LOCAL MODE
      ENTITY travel
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_travel).

    LOOP AT lt_travel ASSIGNING FIELD-SYMBOL(<travel>).
      IF <travel>-Status <> 'C'.
        MODIFY ENTITIES OF zr_as_i_travel IN LOCAL MODE
          ENTITY travel
          UPDATE FIELDS ( status )
          WITH VALUE #( ( %tky   = <travel>-%tky
                          status = 'C' ) ).
      ELSE.
        APPEND VALUE #( %tky = <travel>-%tky ) TO failed-travel.
        APPEND VALUE #( %tky = <travel>-%tky
                         %msg = NEW zcm_as_travel( textid = zcm_as_travel=>already_canceled )
                       ) TO reported-travel.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD issue_message.
  ENDMETHOD.

  METHOD validateDescription.
    CONSTANTS c_area TYPE string VALUE 'DESC'.

    READ ENTITIES OF zr_as_i_travel IN LOCAL MODE
      ENTITY travel
      FIELDS ( Description )
      WITH CORRESPONDING #( keys )
      RESULT DATA(travels).

    LOOP AT travels ASSIGNING FIELD-SYMBOL(<travel>).

      APPEND VALUE #( %tky = <travel>-%tky
                       %state_area = c_area ) TO reported-travel.

      IF <travel>-Description IS INITIAL.
        APPEND VALUE #( %tky = <travel>-%tky ) TO failed-travel.
        APPEND VALUE #( %tky                = <travel>-%tky
                         %msg                = NEW zcm_as_travel( textid = zcm_as_travel=>field_empty )
                         %element-Description = if_abap_behv=>mk-on
                         %state_area         = c_area ) TO reported-travel.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD validateCustomer.
    CONSTANTS c_area TYPE string VALUE 'cust'.

    READ ENTITIES OF zr_as_i_travel IN LOCAL MODE
      ENTITY travel
      FIELDS ( CustomerID )
      WITH CORRESPONDING #( keys )
      RESULT DATA(travels).

    LOOP AT travels ASSIGNING FIELD-SYMBOL(<travel>).

      APPEND VALUE #( %tky = <travel>-%tky
                       %state_area = c_area ) TO reported-travel.

      IF <travel>-CustomerID IS INITIAL.
        APPEND VALUE #( %tky = <travel>-%tky ) TO failed-travel.
        APPEND VALUE #( %tky                = <travel>-%tky
                 %msg                = NEW zcm_as_travel(
                                         textid   = zcm_as_travel=>customer_not_exist
                                         customer = <travel>-CustomerID
                                         severity = if_abap_behv_message=>severity-error )
                 %element-CustomerID = if_abap_behv=>mk-on
                 %state_area         = c_area ) TO reported-travel.
      ELSE.
        SELECT SINGLE FROM /dmo/i_customer
          FIELDS CustomerID
          WHERE CustomerID = @<travel>-CustomerID
          INTO @DATA(dummy).

        IF sy-subrc <> 0.
          APPEND VALUE #( %tky = <travel>-%tky ) TO failed-travel.
          APPEND VALUE #( %tky                = <travel>-%tky
                           %msg                = NEW zcm_as_travel( textid = zcm_as_travel=>customer_not_exist
                                                                     customer = <travel>-CustomerID )
                           %element-CustomerID = if_abap_behv=>mk-on
                           %state_area         = c_area ) TO reported-travel.
        ENDIF.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD validateBeginDate.
    CONSTANTS c_area TYPE string VALUE 'BEGINDATE'.

    READ ENTITIES OF zr_as_i_travel IN LOCAL MODE
      ENTITY travel
      FIELDS ( BeginDate )
      WITH CORRESPONDING #( keys )
      RESULT DATA(travels).

    LOOP AT travels ASSIGNING FIELD-SYMBOL(<travel>).

      APPEND VALUE #( %tky = <travel>-%tky
                       %state_area = c_area ) TO reported-travel.

      IF <travel>-BeginDate IS INITIAL.
        APPEND VALUE #( %tky = <travel>-%tky ) TO failed-travel.
        APPEND VALUE #( %tky               = <travel>-%tky
                         %msg               = NEW zcm_as_travel( textid = zcm_as_travel=>field_empty )
                         %element-BeginDate = if_abap_behv=>mk-on
                         %state_area        = c_area ) TO reported-travel.

      ELSEIF <travel>-BeginDate < cl_abap_context_info=>get_system_date( ).
        APPEND VALUE #( %tky = <travel>-%tky ) TO failed-travel.
        APPEND VALUE #( %tky               = <travel>-%tky
                         %msg               = NEW zcm_as_travel( textid = zcm_as_travel=>begin_date_past )
                         %element-BeginDate = if_abap_behv=>mk-on
                         %state_area        = c_area ) TO reported-travel.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateDataSequence.
    CONSTANTS c_area TYPE string VALUE 'SEQUENCE'.

    READ ENTITIES OF zr_as_i_travel IN LOCAL MODE
      ENTITY travel
      FIELDS ( BeginDate EndDate )
      WITH CORRESPONDING #( keys )
      RESULT DATA(travels).

    LOOP AT travels ASSIGNING FIELD-SYMBOL(<travel>).

      APPEND VALUE #( %tky = <travel>-%tky
                       %state_area = c_area ) TO reported-travel.

      IF <travel>-EndDate < <travel>-BeginDate.
        APPEND VALUE #( %tky = <travel>-%tky ) TO failed-travel.
        APPEND VALUE #( %tky        = <travel>-%tky
                         %msg        = NEW zcm_as_travel( textid = zcm_as_travel=>dates_wrong_sequence )
                         %element    = VALUE #( BeginDate = if_abap_behv=>mk-on
                                                 EndDate   = if_abap_behv=>mk-on )
                         %state_area = c_area ) TO reported-travel.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateEndDate.
    CONSTANTS c_area TYPE string VALUE 'ENDDATE'.

    READ ENTITIES OF zr_as_i_travel IN LOCAL MODE
      ENTITY travel
      FIELDS ( EndDate )
      WITH CORRESPONDING #( keys )
      RESULT DATA(travels).

    LOOP AT travels ASSIGNING FIELD-SYMBOL(<travel>).

      APPEND VALUE #( %tky = <travel>-%tky
                       %state_area = c_area ) TO reported-travel.

      IF <travel>-EndDate IS INITIAL.
        APPEND VALUE #( %tky = <travel>-%tky ) TO failed-travel.
        APPEND VALUE #( %tky             = <travel>-%tky
                         %msg             = NEW zcm_as_travel( textid = zcm_as_travel=>field_empty )
                         %element-EndDate = if_abap_behv=>mk-on
                         %state_area      = c_area ) TO reported-travel.

      ELSEIF <travel>-EndDate < cl_abap_context_info=>get_system_date( ).
        APPEND VALUE #( %tky = <travel>-%tky ) TO failed-travel.
        APPEND VALUE #( %tky             = <travel>-%tky
                         %msg             = NEW zcm_as_travel( textid = zcm_as_travel=>end_date_past )
                         %element-EndDate = if_abap_behv=>mk-on
                         %state_area      = c_area ) TO reported-travel.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD earlynumbering_create.
    DATA: lv_max_travelid TYPE /dmo/travel_id.

    " 1. Retrieve the highest existing Active Travel ID
    SELECT SINGLE FROM zas_travel
      FIELDS MAX( travel_id )
      INTO @DATA(lv_max_active).

    " 2. Retrieve the highest existing Draft Travel ID
    SELECT SINGLE FROM zas_i_travel_d
      FIELDS MAX( travelid )
      INTO @DATA(lv_max_draft).

    lv_max_travelid = COND #( WHEN lv_max_draft > lv_max_active
                              THEN lv_max_draft ELSE lv_max_active ).

    " 3. Map keys explicitly to prevent %cid draft mismatches
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<entity>).
      " Generate the mapping and correlate draft status
      APPEND VALUE #( %cid      = <entity>-%cid
                      %is_draft = <entity>-%is_draft ) TO mapped-travel ASSIGNING FIELD-SYMBOL(<mapped_travel>).

      lv_max_travelid += 1.
      <mapped_travel>-TravelId = lv_max_travelid.

      TRY.
          " Corrected back to lowercase 'travel_uuid' to match your CDS View components
          <mapped_travel>-travel_uuid = cl_system_uuid=>create_uuid_x16_static( ).
        CATCH cx_uuid_error.
          CLEAR <mapped_travel>-travel_uuid.
      ENDTRY.
    ENDLOOP.
  ENDMETHOD.

  METHOD determineStatus.
    READ ENTITIES OF zr_as_i_travel IN LOCAL MODE
      ENTITY Travel
        FIELDS ( Status )
        WITH CORRESPONDING #( keys )
        RESULT DATA(travels).

    DELETE travels WHERE Status IS NOT INITIAL.
    CHECK travels IS NOT INITIAL.

    MODIFY ENTITIES OF zr_as_i_travel IN LOCAL MODE
      ENTITY Travel
        UPDATE FIELDS ( Status )
        WITH VALUE #( FOR key IN travels ( %tky   = key-%tky
                                           Status = 'N' ) )
      REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).
  ENDMETHOD.

  METHOD get_instance_features.

    READ ENTITIES OF zr_as_i_travel IN LOCAL MODE
      ENTITY Travel
        FIELDS ( Status BeginDate EndDate )
        WITH CORRESPONDING #( keys )
        RESULT DATA(travels).

    LOOP AT travels ASSIGNING FIELD-SYMBOL(<travel>).
      APPEND CORRESPONDING #( <travel> ) TO result
        ASSIGNING FIELD-SYMBOL(<result>).

      IF <travel>-%is_draft = if_abap_behv=>mk-on.

        READ ENTITIES OF zr_as_i_travel IN LOCAL MODE
          ENTITY Travel
            FIELDS ( BeginDate EndDate )
            WITH VALUE #( ( %key = <travel>-%key ) )
            RESULT DATA(travels_active).

        IF travels_active IS NOT INITIAL.
          <travel>-BeginDate = travels_active[ 1 ]-BeginDate.
          <travel>-EndDate   = travels_active[ 1 ]-EndDate.
        ELSE.
          CLEAR <travel>-BeginDate.
          CLEAR <travel>-EndDate.
        ENDIF.

      ENDIF.

      IF <travel>-status = 'C' OR
         ( <travel>-EndDate IS NOT INITIAL AND
           <travel>-EndDate < cl_abap_context_info=>get_system_date( ) ).
        <result>-%update               = if_abap_behv=>fc-o-disabled.
        <result>-%action-cancel_travel = if_abap_behv=>fc-o-disabled.
      ELSE. " Corrected syntax here from JS curly brackets to proper ABAP ELSE.
        <result>-%update               = if_abap_behv=>fc-o-enabled.
        <result>-%action-cancel_travel = if_abap_behv=>fc-o-enabled.
      ENDIF.

      IF <travel>-BeginDate IS NOT INITIAL AND
         <travel>-BeginDate < cl_abap_context_info=>get_system_date( ).
        <result>-%field-CustomerID = if_abap_behv=>fc-f-read_only.
        <result>-%field-BeginDate  = if_abap_behv=>fc-f-read_only.
      ELSE.
        <result>-%field-CustomerID = if_abap_behv=>fc-f-mandatory.
        <result>-%field-BeginDate  = if_abap_behv=>fc-f-mandatory.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
