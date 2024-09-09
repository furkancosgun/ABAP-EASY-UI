CLASS zcl_easy_ui_radiobutton DEFINITION
  PUBLIC
  INHERITING FROM zcl_easy_ui_widget
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          fieldname TYPE clike
          group     TYPE clike OPTIONAL.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_EASY_UI_RADIOBUTTON IMPLEMENTATION.


  METHOD:constructor.
    super->constructor( ).
    me->field-fnam = fieldname.
    me->field-flg1 = '80'.
    me->field-flg3 = '80'.
    me->field-fill = 'A'.
    me->field-leng = '01'.
    me->field-type = 'CHAR'.
    me->field-ityp = 'C'.
    me->field-grp1 = group.
  ENDMETHOD.
ENDCLASS.
