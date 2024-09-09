*&---------------------------------------------------------------------*
*& Report zabap_easy_ui_demo3
*&---------------------------------------------------------------------*
*& Example of using radiobuttons, checkboxes, and pushbuttons
*&---------------------------------------------------------------------*
REPORT zabap_easy_ui_demo3.

DATA: BEGIN OF gs_context,
        BEGIN OF gender,
          man   TYPE boolean,
          woman TYPE boolean,
        END OF gender,
        chckbox TYPE boolean,
      END OF gs_context.

INITIALIZATION.
  DATA(lo_screen) = NEW zcl_easy_ui_screen(
    repid = sy-repid
    dynnr = '0100'
  ).

START-OF-SELECTION.
  DATA(lo_layout) = NEW zcl_easy_ui_col( ).

  " Radio button section
  DATA(lo_row1) = NEW zcl_easy_ui_row( ).
  lo_row1->add_widget(
    io_widget = NEW zcl_easy_ui_label( label = 'Choose your gender:' )
  ).

  lo_row1->add_widget(
    io_widget = NEW zcl_easy_ui_label( label = 'Man' )
  ).
  lo_row1->add_widget(
    io_widget = NEW zcl_easy_ui_radiobutton(
      fieldname = 'GS_CONTEXT-GENDER-MAN'
      group     = 'GENDER'
    )
  ).

  lo_row1->add_widget(
    io_widget = NEW zcl_easy_ui_label( label = 'Woman' )
  ).
  lo_row1->add_widget(
    io_widget = NEW zcl_easy_ui_radiobutton(
      fieldname = 'GS_CONTEXT-GENDER-WOMAN'
      group     = 'GENDER'
    )
  ).
  lo_layout->add_row( io_layout = lo_row1 ).

  " Checkbox section
  DATA(lo_row2) = NEW zcl_easy_ui_row( ).
  lo_row2->add_widget(
    io_widget = NEW zcl_easy_ui_label( label = 'Bla Bla Bla:' )
  ).
  lo_row2->add_widget(
    io_widget = NEW zcl_easy_ui_label( label = 'I agree' )
  ).
  lo_row2->add_widget(
    io_widget = NEW zcl_easy_ui_checkbox(
      fieldname = 'GS_CONTEXT-CHCKBOX'
    )
  ).
  lo_layout->add_row( io_layout = lo_row2 ).

  " Pushbutton section
  DATA(lo_row3) = NEW zcl_easy_ui_row( ).
  lo_row3->add_widget(
    io_widget = NEW zcl_easy_ui_button(
      label  = |{ icon_system_save } Save|
      fcode  = 'SAVE'
    )
  ).
  lo_layout->add_row( io_layout = lo_row3 ).

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
    WHEN 'SAVE'.
      MESSAGE 'Save button pressed' TYPE 'S'.
  ENDCASE.
ENDMODULE.
