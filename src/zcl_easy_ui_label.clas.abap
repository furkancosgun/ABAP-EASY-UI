CLASS zcl_easy_ui_label DEFINITION
  PUBLIC
  INHERITING FROM zcl_easy_ui_widget
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          label            TYPE clike
          fieldname        TYPE clike OPTIONAL
          width            TYPE i OPTIONAL
          as_label_on_left TYPE boolean DEFAULT 'X'.
ENDCLASS.



CLASS zcl_easy_ui_label IMPLEMENTATION.


  METHOD:constructor.
    super->constructor( ).
    me->field-fnam = fieldname.
    me->field-flg1 = '00'.
    me->field-flg3 = '30'.
    me->field-ityp = '0'.
    me->field-type = 'CHAR'.
    me->field-stxt = label.
    me->field-leng = COND #( WHEN width IS NOT INITIAL THEN width ELSE strlen( label ) ).
    me->field-res1+248(1) = as_label_on_left.
  ENDMETHOD.
ENDCLASS.
