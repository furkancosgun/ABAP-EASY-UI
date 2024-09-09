CLASS zcl_easy_ui_layout DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      add_widget ABSTRACT
        IMPORTING
          io_widget TYPE REF TO zcl_easy_ui_widget.

    METHODS:
      get_fields
        RETURNING
          VALUE(rt_widgets) TYPE zcl_easy_ui_widget=>ty_fields.

    CONSTANTS:mc_default_coln_len TYPE i VALUE 3,
              mc_default_line_len TYPE i VALUE 1.

    DATA:mt_widgets   TYPE zcl_easy_ui_widget=>ty_widgets READ-ONLY,
         mv_last_coln TYPE i READ-ONLY VALUE 3,
         mv_last_line TYPE i READ-ONLY.
  PROTECTED SECTION.
    METHODS:
      create_random_fieldname
        RETURNING VALUE(r_field) TYPE d021s-fnam.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_EASY_UI_LAYOUT IMPLEMENTATION.


  METHOD:create_random_fieldname.
    DATA(random_generator) = cl_abap_random=>create( seed = cl_abap_random=>seed( ) ).
    r_field = |FIELD{ CONV string( abs( random_generator->int( ) ) ) ALPHA = IN WIDTH = 5 }|.
  ENDMETHOD.


  METHOD:get_fields.
    LOOP AT mt_widgets INTO DATA(ls_widget).
      APPEND ls_widget->field TO rt_widgets.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
