CLASS zarve_test_bo_usei_eml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
      data: lv_opr type c VALUE 'R'.
      INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zarve_test_bo_usei_eml IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    CASE lv_opr.
        when 'C'.
            data: it_so_create TYPE TABLE FOR CREATE ZARVE_RAP_CDS_SO.
            it_so_create = VALUE #(
                                    ( so_id = '0002' customer = 'Alberto Veliz' gross_amount = 3000
                                    currency_code = 'USD' order_status = 'N'
                                    %control = VALUE #( so_id = if_abap_behv=>mk-on
                                                        customer = if_abap_behv=>mk-on
                                                        gross_amount = if_abap_behv=>mk-on
                                                        currency_code = if_abap_behv=>mk-on
                                                        order_status = if_abap_behv=>mk-on
                                                      )
                                    )
                                  ).

            MODIFY ENTITIES OF ZARVE_RAP_CDS_SO
                ENTITY orders
                create FROM it_so_create
                FAILED data(lt_failed)
                REPORTED data(lt_report).

            if lt_failed is not initial.
                out->write(
                    EXPORTING
                        data  = lt_failed
                        name  = 'failed'
                ).

            endif.

    when 'U'.
        data: it_instance_u type table for update ZARVE_RAP_CDS_SO.
              it_instance_u = VALUE #( ( so_id = '0002' order_status = 'A'
                                       %control =  value #( order_status = if_abap_behv=>mk-on )
                                     )
                                   ).
         MODIFY ENTITIES OF ZARVE_RAP_CDS_SO
            ENTITY orders
            update FROM it_instance_u
            FAILED lt_failed
            REPORTED lt_report.

    when 'D'.
        data: it_instance_d type table for DELETE ZARVE_RAP_CDS_SO.
        it_instance_d = VALUE #( ( so_id = '0001' ) ).

        MODIFY ENTITIES OF ZARVE_RAP_CDS_SO
            ENTITY orders
            DELETE FROM it_instance_d
            FAILED lt_failed
            REPORTED lt_report.

            if ( 0 = 1 ).
            endif.

    when 'R'.
        read ENTITIES OF ZARVE_RAP_CDS_SO
        ENTITY orders
        from value #( ( so_id = '0002' %control = VALUE #( so_id = if_abap_behv=>mk-on
                                                        customer = if_abap_behv=>mk-on
                                                        gross_amount = if_abap_behv=>mk-on
                                                        currency_code = if_abap_behv=>mk-on
                                                        order_status = if_abap_behv=>mk-on ) ) )
        result data(lt_read)
        FAILED lt_failed
        REPORTED lt_report.

        out->write(
                    EXPORTING
                        data  = lt_read
                ).
    ENDCASE.

    COMMIT ENTITIES.

  ENDMETHOD.

ENDCLASS.
