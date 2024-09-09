CLASS zcl_easy_ui_col DEFINITION
  PUBLIC
  INHERITING FROM zcl_easy_ui_layout
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS add_widget REDEFINITION.
    METHODS:
      add_row
        IMPORTING
          io_layout TYPE REF TO zcl_easy_ui_row.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_EASY_UI_COL IMPLEMENTATION.


  METHOD add_row.
    DATA:lv_last_line TYPE i.

    lv_last_line = me->mv_last_line.

    LOOP AT io_layout->mt_widgets INTO DATA(lo_widget).
      lv_last_line = me->mv_last_line + CONV i( lo_widget->field-line ).
      lo_widget->set_line( line = lv_last_line ).
      APPEND lo_widget TO me->mt_widgets.
    ENDLOOP.

    me->mv_last_line = lv_last_line.
  ENDMETHOD.


  METHOD add_widget.
    IF io_widget->field-fnam IS INITIAL.
      io_widget->set_fieldname( fieldname = me->create_random_fieldname( ) ).
    ENDIF.

    me->mv_last_line = me->mv_last_line + mc_default_line_len.

    io_widget->set_coln( coln = me->mv_last_coln ).
    io_widget->set_line( line = me->mv_last_line ).

    APPEND io_widget TO me->mt_widgets.
  ENDMETHOD.
ENDCLASS.
