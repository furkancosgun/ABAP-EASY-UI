*&---------------------------------------------------------------------*
*& Report zabap_easy_ui_demo1
*&---------------------------------------------------------------------*
*& Example of using zcl_easy_ui_col and zcl_easy_ui_row
*&---------------------------------------------------------------------*
REPORT zabap_easy_ui_demo1.

INITIALIZATION.
  DATA(lo_screen) = NEW zcl_easy_ui_screen(
    repid = sy-repid
    dynnr = '0100'
  ).

START-OF-SELECTION.
  DATA(lo_main_col) = NEW zcl_easy_ui_col( ).
  DATA(lo_row)      = NEW zcl_easy_ui_row( ).
  DATA(lo_sub_col)  = NEW zcl_easy_ui_col( ).

  " Add widgets to the main column
  lo_main_col->add_widget(
    io_widget = NEW zcl_easy_ui_label( 'Hello from COL' )
  ).

  " Add multiple widgets to the row
  lo_row->add_widget( io_widget = NEW zcl_easy_ui_label( 'Hello from ROW 1' ) ).
  lo_row->add_widget( io_widget = NEW zcl_easy_ui_label( 'Hello from ROW 2' ) ).
  lo_row->add_widget( io_widget = NEW zcl_easy_ui_label( 'Hello from ROW 3' ) ).

  " Add widgets to the sub-column
  lo_sub_col->add_widget( io_widget = NEW zcl_easy_ui_label( 'Hello From Other COL 1' ) ).
  lo_sub_col->add_widget( io_widget = NEW zcl_easy_ui_label( 'Hello From Other COL 2' ) ).
  lo_sub_col->add_widget( io_widget = NEW zcl_easy_ui_label( 'Hello From Other COL 3' ) ).

  " Nest layouts: Add sub-column to the row, and row to the main column
  lo_row->add_col( io_layout = lo_sub_col ).
  lo_main_col->add_row( io_layout = lo_row ).

  " Set the screen layout
  lo_screen->set_layout( io_layout = lo_main_col ).

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
