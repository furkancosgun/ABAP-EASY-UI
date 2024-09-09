*&---------------------------------------------------------------------*
*& Report zabap_easy_ui_demo4
*&---------------------------------------------------------------------*
*& Example of using CL_SALV_TABLE in a custom container
*&---------------------------------------------------------------------*
REPORT zabap_easy_ui_demo4.

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

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'BACK'.
      SET SCREEN 0.
  ENDCASE.
ENDMODULE.
