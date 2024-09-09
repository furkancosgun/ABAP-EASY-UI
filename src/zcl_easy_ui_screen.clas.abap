CLASS zcl_easy_ui_screen DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          repid TYPE sy-repid
          dynnr TYPE sy-dynnr.

    METHODS:
      set_layout
        IMPORTING
          io_layout TYPE REF TO zcl_easy_ui_layout.

  PRIVATE SECTION.
    DATA: dynnr    TYPE sy-dynnr,
          repid    TYPE sy-repid,
          dynproid TYPE c LENGTH 44,
          header   TYPE d020s,
          fields   TYPE TABLE OF d021s,
          module   TYPE TABLE OF d022s,
          params   TYPE TABLE OF d023s.

ENDCLASS.
CLASS zcl_easy_ui_screen IMPLEMENTATION.
  METHOD:constructor.
    me->dynnr = dynnr.
    me->repid = repid.
    me->dynproid = |{ me->repid WIDTH = 40 }{ me->dynnr }|.
    IMPORT DYNPRO me->header me->fields me->module me->params ID me->dynproid.
    FREE:me->fields.
  ENDMETHOD.
  METHOD:set_layout.
    fields = io_layout->get_fields( ).

    DATA:mess(50),
         line(50),
         word(50).

    GENERATE DYNPRO header fields module params ID dynproid
             MESSAGE mess
             LINE    line
             WORD    word.
  ENDMETHOD.
ENDCLASS.
