CLASS zcl_easy_ui_row DEFINITION
  PUBLIC
  FINAL
  INHERITING FROM zcl_easy_ui_layout
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:add_widget REDEFINITION.

    METHODS
      add_col
        IMPORTING
          io_layout TYPE REF TO zcl_easy_ui_col.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_easy_ui_row IMPLEMENTATION.


  METHOD add_col.
    DATA:lv_max_leng TYPE i.

    LOOP AT io_layout->mt_widgets INTO DATA(lo_widget).
      IF lv_max_leng LT CONV i( lo_widget->field-leng ).
        lv_max_leng = CONV i( lo_widget->field-leng ).
      ENDIF.
      lo_widget->set_coln( coln = me->mv_last_coln ).
      APPEND lo_widget TO me->mt_widgets.
    ENDLOOP.

    ADD lv_max_leng TO me->mv_last_coln.
  ENDMETHOD.


  METHOD add_widget.
    IF io_widget->field-fnam IS INITIAL.
      io_widget->set_fieldname( fieldname = me->create_random_fieldname( ) ).
    ENDIF.

    IF me->mv_last_line IS INITIAL.
      me->mv_last_line = mc_default_line_len.
    ENDIF.

    io_widget->set_coln( coln = me->mv_last_coln ).
    io_widget->set_line( line = me->mv_last_line ).

    IF io_widget IS INSTANCE OF zcl_easy_ui_radiobutton
    OR io_widget IS INSTANCE OF zcl_easy_ui_checkbox.
      me->mv_last_coln = 5 + me->mv_last_coln.
    ELSE.
      me->mv_last_coln = CONV i( io_widget->field-leng ) + me->mv_last_coln.
    ENDIF.
    APPEND io_widget TO me->mt_widgets.
  ENDMETHOD.
ENDCLASS.
