clc
close all

%{  
    Dependencies:
        rotation_matrix.m
        draw_aircraft.m
        xadec_postproc_ms.m
        make_initial_state.m
        make_nominal_flight_parameters.m
        make_uav_parameters.m
        airflow_sfcn.mexw64
        forces_moments_sfcn.mexw64
        uav_dynamics_csfcn.mexw64
        wind_ned.m
        uav_trim.m
        make_wind_parameters.m
        compute_uav_tf_model.m
        compute_uav_ss_model.m
        unwrap_angle_from_180.m
%}

clearvars

enable_aircraft_view = 1;
trim_sim_mdl = 'uav_trim_02_sim';

make_initial_state
make_nominal_flight_parameters
uav_param = make_uav_parameters();
uav_trim
make_wind_parameters

compute_uav_tf_model
compute_uav_ss_model

