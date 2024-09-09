*&---------------------------------------------------------------------*
*& Report zabap_easy_ui_demo5
*&---------------------------------------------------------------------*
*& Example of using multiple subscreens in a custom layout
*&---------------------------------------------------------------------*
REPORT zabap_easy_ui_demo5.

CONSTANTS: gc_subscreen_name1 TYPE fieldname VALUE 'SUBSCR1',
           gc_subscreen_name2 TYPE fieldname VALUE 'SUBSCR2'.

INITIALIZATION.
  DATA(lo_screen_0100)  = NEW zcl_easy_ui_screen( repid = sy-repid dynnr = '0100' ).
  DATA(lo_screen_0001)  = NEW zcl_easy_ui_screen( repid = sy-repid dynnr = '0001' ).
  DATA(lo_screen_0002)  = NEW zcl_easy_ui_screen( repid = sy-repid dynnr = '0002' ).

START-OF-SELECTION.
  " Create main layout
  DATA(lo_layout) = NEW zcl_easy_ui_row( ).

  " Add subscreens to main layout
  lo_layout->add_widget( io_widget = NEW zcl_easy_ui_subscreen(
    fieldname = gc_subscreen_name1
    width     = 30
    height    = 20
  ) ).

  lo_layout->add_widget( io_widget = NEW zcl_easy_ui_subscreen(
    fieldname = gc_subscreen_name2
    width     = 30
    height    = 20
  ) ).

  lo_screen_0100->set_layout( io_layout = lo_layout ).

  " Prepare subscreen 1 layout
  DATA(lo_layout1) = NEW zcl_easy_ui_col( ).
  lo_layout1->add_widget( io_widget = NEW zcl_easy_ui_label( label = 'Hello From 0001 Subscreen' ) ).
  lo_screen_0001->set_layout( io_layout = lo_layout1 ).

  " Prepare subscreen 2 layout
  DATA(lo_layout2) = NEW zcl_easy_ui_col( ).
  lo_layout2->add_widget( io_widget = NEW zcl_easy_ui_label( label = 'Hello From 0002 Subscreen' ) ).
  lo_screen_0002->set_layout( io_layout = lo_layout2 ).

  " Call main screen
  CALL SCREEN 0100.

*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS '0100'.
ENDMODULE.

*&---------------------------------------------------------------------*
*& Module USER_COMMAND_0100 INPUT
*&---------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'BACK'.
      SET SCREEN 0.
  ENDCASE.
ENDMODULE.
