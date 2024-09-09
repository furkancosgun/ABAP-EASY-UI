
# ABAP Easy UI

ABAP Easy UI is a library designed to simplify the creation of user interfaces in ABAP. It provides a flexible and powerful way to create and manage screens, layouts, and widgets with minimal code. This project supports various UI components such as labels, inputs, radio buttons, checkboxes, and buttons, and offers easy integration with subscreens.

## License

This project is licensed under the [MIT License](LICENSE). See the LICENSE file for details.

## Contents

- [Row-Column Example](#row-column-example)
- [Label-Input Example](#label-input-example)
- [Radiobutton-Checkbox-Pushbutton Example](#radiobutton-checkbox-pushbutton-example)
- [Custom Container Example](#custom-container-example)
- [Subscreen Example](#subscreen-example)

### Row-Column Example

This example demonstrates how to use rows and columns to organize UI components.

```abap
INITIALIZATION.
  DATA(lo_screen) = NEW zcl_easy_ui_screen(
    repid = sy-repid
    dynnr = '0100'
  ).

START-OF-SELECTION.
  DATA(lo_main_col) = NEW zcl_easy_ui_col( ).
  DATA(lo_row)      = NEW zcl_easy_ui_row( ).
  DATA(lo_sub_col)  = NEW zcl_easy_ui_col( ).

  " Add widgets to the main column
  lo_main_col->add_widget(
    io_widget = NEW zcl_easy_ui_label( 'Hello from COL' )
  ).

  " Add multiple widgets to the row
  lo_row->add_widget( io_widget = NEW zcl_easy_ui_label( 'Hello from ROW 1' ) ).
  lo_row->add_widget( io_widget = NEW zcl_easy_ui_label( 'Hello from ROW 2' ) ).
  lo_row->add_widget( io_widget = NEW zcl_easy_ui_label( 'Hello from ROW 3' ) ).

  " Add widgets to the sub-column
  lo_sub_col->add_widget( io_widget = NEW zcl_easy_ui_label( 'Hello From Other COL 1' ) ).
  lo_sub_col->add_widget( io_widget = NEW zcl_easy_ui_label( 'Hello From Other COL 2' ) ).
  lo_sub_col->add_widget( io_widget = NEW zcl_easy_ui_label( 'Hello From Other COL 3' ) ).

  " Nest layouts: Add sub-column to the row, and row to the main column
  lo_row->add_col( io_layout = lo_sub_col ).
  lo_main_col->add_row( io_layout = lo_row ).

  " Set the screen layout
  lo_screen->set_layout( io_layout = lo_main_col ).

  " Call screen 0100
  CALL SCREEN 0100.
```

### Label-Input Example

This example shows how to create a UI with labels and input fields.

```abap
TABLES: scarr.

INITIALIZATION.
  DATA(lo_screen) = NEW zcl_easy_ui_screen(
    repid = sy-repid
    dynnr = '0100'
  ).

START-OF-SELECTION.
  DATA(lo_layout) = NEW zcl_easy_ui_col( ).

  " Add header label
  DATA(lo_title) = NEW zcl_easy_ui_label(
    label = 'Scarr Table Example'
  ).
  lo_layout->add_widget( io_widget = lo_title ).

  " First row: Label and input for Carrid
  DATA(lo_row1) = NEW zcl_easy_ui_row( ).
  lo_row1->add_widget(
    io_widget = NEW zcl_easy_ui_label(
      label  = 'Carrid:'
      width  = 10
    )
  ).
  lo_row1->add_widget(
    io_widget = NEW zcl_easy_ui_input(
      fieldname = 'SCARR-CARRID'
    )
  ).

  " Second row: Label and input for Carrname
  DATA(lo_row2) = NEW zcl_easy_ui_row( ).
  lo_row2->add_widget(
    io_widget = NEW zcl_easy_ui_label(
      label  = 'Carrname:'
      width  = 10
    )
  ).
  lo_row2->add_widget(
    io_widget = NEW zcl_easy_ui_input(
      fieldname = 'SCARR-CARRNAME'
    )
  ).

  " Add rows to the layout
  lo_layout->add_row( io_layout = lo_row1 ).
  lo_layout->add_row( io_layout = lo_row2 ).

  " Set the screen layout
  lo_screen->set_layout( io_layout = lo_layout ).

  " Call screen 0100
  CALL SCREEN 0100.
```

### Radiobutton-Checkbox-Pushbutton Example

This example demonstrates the integration of radio buttons, checkboxes, and push buttons into a screen.

```abap

DATA: BEGIN OF gs_context,
        BEGIN OF gender,
          man   TYPE boolean,
          woman TYPE boolean,
        END OF gender,
        chckbox TYPE boolean,
      END OF gs_context.

INITIALIZATION.
  DATA(lo_screen) = NEW zcl_easy_ui_screen(
    repid = sy-repid
    dynnr = '0100'
  ).

START-OF-SELECTION.
  DATA(lo_layout) = NEW zcl_easy_ui_col( ).

  " Radio button section
  DATA(lo_row1) = NEW zcl_easy_ui_row( ).
  lo_row1->add_widget(
    io_widget = NEW zcl_easy_ui_label( label = 'Choose your gender:' )
  ).

  lo_row1->add_widget(
    io_widget = NEW zcl_easy_ui_label( label = 'Man' )
  ).
  lo_row1->add_widget(
    io_widget = NEW zcl_easy_ui_radiobutton(
      fieldname = 'GS_CONTEXT-GENDER-MAN'
      group     = 'GENDER'
    )
  ).

  lo_row1->add_widget(
    io_widget = NEW zcl_easy_ui_label( label = 'Woman' )
  ).
  lo_row1->add_widget(
    io_widget = NEW zcl_easy_ui_radiobutton(
      fieldname = 'GS_CONTEXT-GENDER-WOMAN'
      group     = 'GENDER'
    )
  ).
  lo_layout->add_row( io_layout = lo_row1 ).

  " Checkbox section
  DATA(lo_row2) = NEW zcl_easy_ui_row( ).
  lo_row2->add_widget(
    io_widget = NEW zcl_easy_ui_label( label = 'Bla Bla Bla:' )
  ).
  lo_row2->add_widget(
    io_widget = NEW zcl_easy_ui_label( label = 'I agree' )
  ).
  lo_row2->add_widget(
    io_widget = NEW zcl_easy_ui_checkbox(
      fieldname = 'GS_CONTEXT-CHCKBOX'
    )
  ).
  lo_layout->add_row( io_layout = lo_row2 ).

  " Pushbutton section
  DATA(lo_row3) = NEW zcl_easy_ui_row( ).
  lo_row3->add_widget(
    io_widget = NEW zcl_easy_ui_button(
      label  = |{ icon_system_save } Save|
      fcode  = 'SAVE'
    )
  ).
  lo_layout->add_row( io_layout = lo_row3 ).

  " Set the screen layout
  lo_screen->set_layout( io_layout = lo_layout ).

  " Call screen 0100
  CALL SCREEN 0100.
```

### Custom Container Example

This example illustrates how to use custom containers to manage complex layouts and widget arrangements.

```abap
DATA: gt_scarr     TYPE TABLE OF scarr,
      go_salv      TYPE REF TO cl_salv_table,
      go_container TYPE REF TO cl_gui_custom_container.

CONSTANTS: gc_container_name TYPE char2 VALUE 'CC'. " Custom container name

INITIALIZATION.
  DATA(lo_screen) = NEW zcl_easy_ui_screen(
    repid = sy-repid
    dynnr = '0100'
  ).

START-OF-SELECTION.
  " Fetch SCARR data
  SELECT * FROM scarr INTO TABLE gt_scarr.

  " Create main layout
  DATA(lo_layout) = NEW zcl_easy_ui_col( ).

  " Add a custom container widget to the layout
  lo_layout->add_widget( io_widget = NEW zcl_easy_ui_container(
    fieldname = gc_container_name
    width     = 100
    height    = 20
  ) ).

  " Set the screen layout and call screen
  lo_screen->set_layout( io_layout = lo_layout ).
  CALL SCREEN 0100.

*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS '0100'.

  " Create the container and SALV table if not already created
  IF go_salv IS NOT BOUND.
    TRY.
        " Create the GUI container for the custom area
        CREATE OBJECT go_container
          EXPORTING
            container_name = gc_container_name.

        " Create the SALV table and bind it to the container
        cl_salv_table=>factory(
          EXPORTING
            r_container = go_container
          IMPORTING
            r_salv_table = go_salv
          CHANGING
            t_table = gt_scarr
        ).

        " Optimize columns and enable all functions
        go_salv->get_columns( )->set_optimize( ).
        go_salv->get_functions( )->set_all( ).
        go_salv->display( ).

      CATCH cx_salv_msg INTO DATA(lx_salv_error).
        MESSAGE lx_salv_error->get_text( ) TYPE 'E'.
    ENDTRY.
  ELSE.
    " Refresh the table if it already exists
    go_salv->refresh( ).
  ENDIF.
ENDMODULE.
```

### Subscreen Example

This example shows how to use subscreens to modularize and organize UI components effectively.

```abap

CONSTANTS: gc_subscreen_name1 TYPE fieldname VALUE 'SUBSCR1',
           gc_subscreen_name2 TYPE fieldname VALUE 'SUBSCR2'.

INITIALIZATION.
  DATA(lo_screen_0100)  = NEW zcl_easy_ui_screen( repid = sy-repid dynnr = '0100' ).
  DATA(lo_screen_0001)  = NEW zcl_easy_ui_screen( repid = sy-repid dynnr = '0001' ).
  DATA(lo_screen_0002)  = NEW zcl_easy_ui_screen( repid = sy-repid dynnr = '0002' ).

START-OF-SELECTION.
  " Create main layout
  DATA(lo_layout) = NEW zcl_easy_ui_row( ).

  " Add subscreens to main layout
  lo_layout->add_widget( io_widget = NEW zcl_easy_ui_subscreen(
    fieldname = gc_subscreen_name1
    width     = 30
    height    = 20
  ) ).

  lo_layout->add_widget( io_widget = NEW zcl_easy_ui_subscreen(
    fieldname = gc_subscreen_name2
    width     = 30
    height    = 20
  ) ).

  lo_screen_0100->set_layout( io_layout = lo_layout ).

  " Prepare subscreen 1 layout
  DATA(lo_layout1) = NEW zcl_easy_ui_col( ).
  lo_layout1->add_widget( io_widget = NEW zcl_easy_ui_label( label = 'Hello From 0001 Subscreen' ) ).
  lo_screen_0001->set_layout( io_layout = lo_layout1 ).

  " Prepare subscreen 2 layout
  DATA(lo_layout2) = NEW zcl_easy_ui_col( ).
  lo_layout2->add_widget( io_widget = NEW zcl_easy_ui_label( label = 'Hello From 0002 Subscreen' ) ).
  lo_screen_0002->set_layout( io_layout = lo_layout2 ).

  " Call main screen
  CALL SCREEN 0100.
```

## Usage

Refer to the examples provided in the `Contents` section to understand how to use various components and features of the ABAP Easy UI library.

Feel free to adjust these suggestions based on your specific needs or the context of your project!
