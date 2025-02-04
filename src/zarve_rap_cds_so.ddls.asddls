@AbapCatalog.sqlViewName: 'ZARVE_RAP_SO'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'View Sales Orders'
@Metadata.ignorePropagatedAnnotations: true
define root view ZARVE_RAP_CDS_SO as select from zarve_db_so
{
  key so_id,
  customer,
  gross_amount,
  currency_code,
  order_status
  
}
