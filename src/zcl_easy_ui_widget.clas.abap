CLASS zcl_easy_ui_widget DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      set_group
        IMPORTING
          group1           TYPE clike OPTIONAL
          group2           TYPE clike OPTIONAL
          group3           TYPE clike OPTIONAL
          group4           TYPE clike OPTIONAL
        RETURNING
          VALUE(ro_widget) TYPE REF TO zcl_easy_ui_widget.
    METHODS:
      set_fieldname
        IMPORTING
          fieldname        TYPE clike
        RETURNING
          VALUE(ro_widget) TYPE REF TO zcl_easy_ui_widget.
    METHODS:
      set_width
        IMPORTING
          width            TYPE i
        RETURNING
          VALUE(ro_widget) TYPE REF TO zcl_easy_ui_widget.
    METHODS:
      set_height
        IMPORTING
          height           TYPE i
        RETURNING
          VALUE(ro_widget) TYPE REF TO zcl_easy_ui_widget.
    METHODS:
      set_size
        IMPORTING
          width            TYPE i
          height           TYPE i
        RETURNING
          VALUE(ro_widget) TYPE REF TO zcl_easy_ui_widget.
    METHODS:
      set_coln
        IMPORTING
          coln             TYPE i
        RETURNING
          VALUE(ro_widget) TYPE REF TO zcl_easy_ui_widget.
    METHODS:
      set_line
        IMPORTING
          line             TYPE i
        RETURNING
          VALUE(ro_widget) TYPE REF TO zcl_easy_ui_widget.


*define type d021s {
*  fnam : fnam_____4;        " Field name
*  didx : didx;              " Box height
*  flg1 : flg1_____4;        " Flag byte 1
*  flg2 : flg2_____4;        " Flag byte 2
*  flg3 : flg3_____4;        " Flag byte 3
*  fill : fill_____4;        " Padding character, leading zero
*  fmb1 : fmb1_____4;        " Format byte
*  fmb2 : fmb2_____4;        " Format byte extension
*  colr : colr_____4;        " Color
*  leng : leng_____7;        " Text length
*  line : line_____2;        " Line
*  coln : coln_____4;        " Column
*  ltyp : ltyp_____4;        " Loop type
*  lanf : lanf_____4;        " Loop start line
*  lblk : lblk_____4;        " Loop block size
*  lrep : lrep_____4;        " Loop repeat factor
*  fmky : fmky_____4;        " Function menu key
*  paid : memoryid;          " Set/Get parameter ID
*  ucnv : ucnv_____4;        " User conversion routine
*  type : type_____6;        " Field Format
*  auth : auth_____3;        " Authorization ID
*  wnam : scrpwschl;         " Currency key field
*  dmac : dmac_____4;        " Matchcode file name
*  grp1 : grp1_____4;        " Modification group 1
*  grp2 : grp2_____4;        " Modification group 2
*  grp3 : grp3_____4;        " Modification group 3
*  grp4 : grp4_____4;        " Modification group 4
*  ityp : ityp_____4;        " Internal Type from ABAP Dictionary
*  aglt : aglt_____4;        " Number of valid positions.
*  adez : adez_____4;        " No. of decimal places
*  stxt : stxt_____1;        " Text
*  res1 : dynrese;           " Screen source reserve field area without structure
*  res2 : dynrese;           " Screen source reserve field area without structure
*}
    TYPES:ty_widgets TYPE TABLE OF REF TO zcl_easy_ui_widget WITH EMPTY KEY.
    TYPES:ty_field TYPE d021s.
    TYPES:ty_fields TYPE STANDARD TABLE OF ty_field WITH EMPTY KEY.

    DATA:field TYPE ty_field READ-ONLY.
  PROTECTED SECTION.
ENDCLASS.



CLASS zcl_easy_ui_widget IMPLEMENTATION.
  METHOD:set_group.
    IF group1 IS SUPPLIED.
      me->field-grp1 = group1.
    ENDIF.
    IF group2 IS SUPPLIED.
      me->field-grp2 = group2.
    ENDIF.
    IF group3 IS SUPPLIED.
      me->field-grp3 = group3.
    ENDIF.
    IF group4 IS SUPPLIED.
      me->field-grp4 = group4.
    ENDIF.
    ro_widget = me.
  ENDMETHOD.
  METHOD:set_fieldname.
    me->field-fnam = fieldname.
    ro_widget = me.
  ENDMETHOD.
  METHOD:set_width.
    me->field-leng = width.
    ro_widget = me.
  ENDMETHOD.
  METHOD:set_height.
    me->field-didx = height.
    ro_widget = me.
  ENDMETHOD.
  METHOD:set_size.
    me->set_width( width = width ).
    me->set_height( height = height ).
    ro_widget = me.
  ENDMETHOD.
  METHOD:set_coln.
    me->field-coln = CONV #( coln ).
    ro_widget = me.
  ENDMETHOD.
  METHOD:set_line.
    me->field-line = CONV #( line ).
    ro_widget = me.
  ENDMETHOD.
ENDCLASS.
