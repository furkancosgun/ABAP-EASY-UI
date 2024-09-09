CLASS zcl_easy_ui_checkbox DEFINITION
  PUBLIC
  INHERITING FROM zcl_easy_ui_widget
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          fieldname TYPE clike.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_easy_ui_checkbox IMPLEMENTATION.
  METHOD:constructor.
    super->constructor( ).
    me->field-fnam = fieldname.
    me->field-flg1 = '80'.
    me->field-flg3 = '80'.
    me->field-fill = 'C'.
    me->field-leng = '01'.
    me->field-type = 'CHAR'.
    me->field-ityp = 'C'.
  ENDMETHOD.
ENDCLASS.
