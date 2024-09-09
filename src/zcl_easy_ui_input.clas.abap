CLASS zcl_easy_ui_input DEFINITION
  PUBLIC
  INHERITING FROM zcl_easy_ui_widget
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          fieldname TYPE clike  " Name of the field (e.g., database field)
          width     TYPE i OPTIONAL. " Optional width of the field

  PROTECTED SECTION.

  PRIVATE SECTION.
    METHODS:
      get_general_type
        IMPORTING
          VALUE(iv_abap_type) TYPE clike  " ABAP type
        RETURNING
          VALUE(r_dict_type)  TYPE string. " General type (e.g., CHAR, NUMC)
ENDCLASS.



CLASS ZCL_EASY_UI_INPUT IMPLEMENTATION.


  METHOD constructor.
    super->constructor( ).

    FIELD-SYMBOLS: <fs_value> TYPE any.
    DATA:
      lo_typedescr TYPE REF TO cl_abap_typedescr,
      lo_elemdescr TYPE REF TO cl_abap_elemdescr,
      lv_field     TYPE string.

    me->field-flg1 = '80'.
    me->field-flg3 = '80'.
    me->field-fnam = fieldname.

    " Retrieves the description of the field's data type
    cl_abap_elemdescr=>describe_by_name(
      EXPORTING
        p_name         = fieldname
      RECEIVING
        p_descr_ref    = lo_typedescr
      EXCEPTIONS
        OTHERS         = 1
    ).
    IF sy-subrc NE 0.
      " If description cannot be retrieved by name, tries to get the field dynamically
      lv_field = |({ sy-cprog }){ fieldname }|.
      ASSIGN (lv_field) TO <fs_value>.
      CHECK sy-subrc EQ 0.
      lo_typedescr = cl_abap_elemdescr=>describe_by_data( p_data = <fs_value> ).
    ENDIF.

    " Casts the type description reference to element description reference
    lo_elemdescr ?= lo_typedescr.

    " Gets the technical type of the value (e.g., c for CHAR, n for NUMC)
    me->field-ityp = lo_elemdescr->type_kind.

    " Determines the output length of the value
    me->field-leng = COND #( WHEN width IS NOT INITIAL THEN width ELSE lo_elemdescr->output_length ).

    " Converts the technical type to uppercase
    TRANSLATE me->field-ityp TO UPPER CASE.

    " Maps the technical type to a general type (e.g., C -> CHAR)
    me->field-type = me->get_general_type( me->field-ityp ).

    " Retrieves and cleans up the edit mask (removes '==' occurrences)
    DATA(lv_editmask) = lo_elemdescr->edit_mask.
    REPLACE ALL OCCURRENCES OF '==' IN lv_editmask WITH ''.
    me->field-ucnv = lv_editmask.

    " Sets the number of decimal places
    me->field-adez = lo_elemdescr->decimals.
  ENDMETHOD.


  METHOD get_general_type.
    " Maps the ABAP type to a general type
    CASE iv_abap_type.
      WHEN 'B'.
        r_dict_type = 'INT1'.  " 1-byte integer
      WHEN 'S'.
        r_dict_type = 'INT2'.  " 2-byte integer
      WHEN 'I'.
        r_dict_type = 'INT4'.  " 4-byte integer
      WHEN 'INT8'.
        r_dict_type = 'INT8'.  " 8-byte integer
      WHEN 'P'.
        r_dict_type = 'DEC'.   " Packed number
      WHEN 'DECFLOAT16'.
        r_dict_type = 'DF16_DEC'.  " Decimal floating point in BCD format
      WHEN 'DECFLOAT34'.
        r_dict_type = 'DF34_DEC'.  " Decimal floating point in BCD format
      WHEN 'F'.
        r_dict_type = 'FLTP'.  " Floating point number
      WHEN 'C'.
        r_dict_type = 'CHAR'.  " Character string
      WHEN 'STRING'.
        r_dict_type = 'SSTRING'.  " Character string
      WHEN 'X'.
        r_dict_type = 'RAW'.  " Byte string
      WHEN 'XSTRING'.
        r_dict_type = 'RAWSTRING'.  " Byte string (BLOB)
      WHEN 'D'.
        r_dict_type = 'DATS'.  " Date
      WHEN 'T'.
        r_dict_type = 'TIMS'.  " Time
      WHEN 'N'.
        r_dict_type = 'NUMC'.  " Numeric text
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
