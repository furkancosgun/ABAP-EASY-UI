CLASS zcl_easy_ui_button DEFINITION
  PUBLIC
  INHERITING FROM zcl_easy_ui_widget
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          label     TYPE clike
          fcode     TYPE sy-ucomm
          fieldname TYPE clike OPTIONAL
          width     TYPE i OPTIONAL.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_easy_ui_button IMPLEMENTATION.
  METHOD:constructor.
    super->constructor( ).
    me->field-fnam = fieldname.
    me->field-fill = 'P'.
    me->field-fmb1 = '30'.
    me->field-leng = COND #( WHEN width IS NOT INITIAL THEN width ELSE strlen( label ) ).
    me->field-type = 'CHAR'.
    me->field-ityp = 'C'.
    me->field-stxt = label.
    me->field-res1+168 = fcode.
  ENDMETHOD.
ENDCLASS.
