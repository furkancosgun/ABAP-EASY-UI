CLASS zcl_easy_ui_subscreen DEFINITION
  PUBLIC
  INHERITING FROM zcl_easy_ui_widget
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          fieldname TYPE clike
          width     TYPE i
          height    TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_easy_ui_subscreen IMPLEMENTATION.
  METHOD:constructor.
    super->constructor( ).
    me->field-fnam = fieldname.
    me->field-didx = height.
    me->field-fill = 'B'.
    me->field-fmb1 = '30'.
    me->field-leng = width.
  ENDMETHOD.
ENDCLASS.
