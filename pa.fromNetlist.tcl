
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name elevathor -dir "/media/yeetman/DATA/stuff/classes/ICOM5206/elevathor/planAhead_run_2" -part xc3s500efg320-4
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "/media/yeetman/DATA/stuff/classes/ICOM5206/elevathor/floor_input_handler.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {/media/yeetman/DATA/stuff/classes/ICOM5206/elevathor} }
set_property target_constrs_file "floor_input_handler_test.ucf" [current_fileset -constrset]
add_files [list {floor_input_handler_test.ucf}] -fileset [get_property constrset [current_run]]
link_design
