% gusts: vector of gusts' velocity in UAV (body) coordinates
% w_ned_s: vector of steady wind velocity in NED (inertial) coordinates
% x: flight dynamics' state vector

function [w_ned] = wind_ned(w_ned_s, gusts, x)
    phi     = x(7); % roll angle
    theta   = NaN; %TODO % pitch angle
    psi     = NaN; %TODO % yaw angle

    R_b_i = rotation_matrix(phi,theta,psi); % NED to body rotation matrix
    R_i_b = NaN; %TODO % body to NED

    % compute wind velocity in NED frame
    w_ned = NaN; %TODO
end
