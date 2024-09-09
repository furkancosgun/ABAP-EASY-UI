*&---------------------------------------------------------------------*
*& Report zabap_easy_ui_demo2
*&---------------------------------------------------------------------*
*& Example of using zcl_easy_ui_label and zcl_easy_ui_input
*&---------------------------------------------------------------------*
REPORT zabap_easy_ui_demo2.

DATA:gs_scarr TYPE scarr.
TABLES: scarr.

INITIALIZATION.
  DATA(lo_screen) = NEW zcl_easy_ui_screen(
    repid = sy-repid
    dynnr = '0100'
  ).

START-OF-SELECTION.
  DATA(lo_layout) = NEW zcl_easy_ui_col( ).

  " Add header label
  DATA(lo_title) = NEW zcl_easy_ui_label(
    label = 'Scarr Table Example'
  ).
  lo_layout->add_widget( io_widget = lo_title ).

  " First row: Label and input for Carrid
  DATA(lo_row1) = NEW zcl_easy_ui_row( ).
  lo_row1->add_widget(
    io_widget = NEW zcl_easy_ui_label(
      label  = 'Carrid:'
      width  = 10
    )
  ).
  lo_row1->add_widget(
    io_widget = NEW zcl_easy_ui_input(
      fieldname = 'SCARR-CARRID'
    )
  ).

  " Second row: Label and input for Carrname
  DATA(lo_row2) = NEW zcl_easy_ui_row( ).
  lo_row2->add_widget(
    io_widget = NEW zcl_easy_ui_label(
      label  = 'Carrname:'
      width  = 10
    )
  ).
  lo_row2->add_widget(
    io_widget = NEW zcl_easy_ui_input(
      fieldname = 'GS_SCARR-CARRNAME'
    )
  ).

  " Add rows to the layout
  lo_layout->add_row( io_layout = lo_row1 ).
  lo_layout->add_row( io_layout = lo_row2 ).

  " Set the screen layout
  lo_screen->set_layout( io_layout = lo_layout ).

  " Call screen 0100
  CALL SCREEN 0100.

*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS '0100'.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'BACK'.
      SET SCREEN 0.
  ENDCASE.
ENDMODULE.
