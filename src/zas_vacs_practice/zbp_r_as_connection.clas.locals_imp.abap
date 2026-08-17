CLASS LHC_ZAS_R_CONNECTION DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR Connection1
        RESULT result,
      CheckSemanticKey FOR VALIDATE ON SAVE
            IMPORTING keys FOR Connection1~CheckSemanticKey,
      CheckCarrierID FOR VALIDATE ON SAVE
            IMPORTING keys FOR Connection1~CheckCarrierID,
      CheckOriginDestination FOR VALIDATE ON SAVE
            IMPORTING keys FOR Connection1~CheckOriginDestination,
      getCities FOR DETERMINE ON SAVE
            IMPORTING keys FOR Connection1~getCities.
ENDCLASS.

CLASS LHC_ZAS_R_CONNECTION IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.
  METHOD CheckSemanticKey.

  READ ENTITIES OF ZAS_R_Connection IN LOCAL MODE
  ENTITY Connection1
  FIELDS ( CarrierID ConnectionID )
  WITH CORRESPONDING #( keys )
  RESULT DATA(connections).

  LOOP AT connections into data(connection).

  SELECT FROM zasaconn
  FIELDS uuid
  WHERE carrier_id = @Connection-carrierid
     and connection_id = @Connection-Connectionid
     and uuid <> @Connection-uuid

     UNION

     SELECT FROM zasdconn
     FIELDS uuid
     WHERE carrierid = @Connection-carrierid
     and connectionid = @Connection-ConnectionID
     and uuid <> @connection-uuid

     into TABLE @DATA(check_result).

     if check_result IS NOT INITIAL.
     DATA(message) = me->new_message(
                       id       = 'ZS4D400'
                       number   = '001'
                       severity = ms-error
                       v1       = connection-CarrierID
                       v2       = connection-ConnectionID
*                       v3       =
*                       v4       =
                     ).


       DATA reported_record LIKE LINE OF reported-connection1.

       reported_record-%tky = connection-%tky.
       reported_record-%msg = message.
       reported_record-%element-carrierid = if_abap_behv=>mk-on.
       reported_record-%element-connectionid = if_abap_behv=>mk-on.

       APPEND reported_record to reported-connection1.

       DATA failed_record LIKE LINE OF failed-connection1.

       failed_record-%tky = connection-%tky.

       APPEND  failed_record to failed-connection1.

       ENDIF.

     ENDLOOP.
  ENDMETHOD.

  METHOD CheckCarrierID.

  READ ENTITIES OF ZAS_R_Connection IN LOCAL MODE
  ENTITY Connection1
  FIELDS ( CarrierID )
  WITH CORRESPONDING #( keys )
  RESULT DATA(connections).

  LOOP AT connections INTO DATA(connection).

  SELECT SINGLE FROM /DMO/I_Carrier
  FIELDS @abap_true
  WHERE AirlineID = @connection-CarrierID
  INTO @DATA(exists).

  IF exists = abap_false.
  DATA(message) = me->new_message(
                    id       = 'ZS4D400'
                    number   = '002'
                    severity = ms-error
*                    v1       =
*                    v2       =
*                    v3       =
*                    v4       =
                  ).
     DATA reported_record LIKE LINE OF reported-connection1.
       reported_record-%tky = connection-%tky.
       reported_record-%msg = message.
       reported_record-%element-carrierid = if_abap_behv=>mk-on.

 APPEND reported_record to reported-connection1.


   DATA failed_record LIKE LINE OF failed-connection1.

       failed_record-%tky = connection-%tky.

       APPEND  failed_record to failed-connection1.

       ENDIF.
       ENDLOOP.

  ENDMETHOD.

  METHOD CheckOriginDestination.

  READ ENTITIES OF ZAS_R_Connection IN LOCAL MODE
  ENTITY Connection1
  FIELDS ( AirportFromID AirportToID )
  WITH CORRESPONDING #( keys )
  RESULT DATA(connections).

  LOOP AT connections into DATA(connection).

  IF connection-AirportFromID = connection-AirportToID.

  DATA(message) = me->new_message(
                    id       = 'ZS4D400'
                    number   = '003'
                    severity = ms-error
*                    v1       =
*                    v2       =
*                    v3       =
*                    v4       =
                  ).

   DATA reported_record LIKE LINE OF reported-connection1.

   reported_record-%tky = connection-%tky.
   reported_record-%msg = message.
    reported_record-%element-airportfromid = if_abap_behv=>mk-on.
    reported_record-%element-airporttoid = if_abap_behv=>mk-on.
   APPEND reported_record to reported-connection1.

  DATA failed_record LIKE LINE OF failed-connection1.
  failed_record-%tky = connection-%tky.
  APPEND failed_record to failed-connection1.
  ENDIF.
  ENDLOOP.
  ENDMETHOD.

  METHOD getCities.

  READ ENTITIES OF ZAS_R_Connection IN LOCAL MODE
  ENTITY Connection1
  FIELDS ( AirportFromID AirportToID )
  WITH CORRESPONDING #( keys )
  RESULT DATA(connections).

   LOOP AT connections into DATA(connection).

   SELECT SINGLE FROM /DMO/I_Airport
   FIELDS City , CountryCode
   WHERE AirportID = @connection-airportfromid
   INTO ( @connection-CityFrom, @connection-CountryFrom ).

   SELECT SINGLE FROM /DMO/I_Airport
   FIELDS city , CountryCode
   WHERE AirportID = @connection-AirportToID
   INTO ( @connection-CityTo , @connection-CountryTo ).

   MODIFY connections FROM connection.
   ENDLOOP.

   DATA connections_upd TYPE TABLE FOR UPDATE ZAS_R_Connection.

   connections_upd = CORRESPONDING #( connections ).

   MODIFY ENTITIES OF ZAS_R_Connection IN LOCAL MODE
   ENTITY Connection1
   UPDATE
   FIELDS (  CityFrom CityTo CountryFrom CountryTo )
   WITH connections_upd
   REPORTED DATA(reported_records).

   reported-connection1 = CORRESPONDING #( reported_records-connection1 ).



  ENDMETHOD.

ENDCLASS.
