%{
Performs post-processing of exact, estimated and commanded states, 
    together with airflow and delta, for feeding the main scope
x = true state
x_hat = estimated state
x_c = commanded state
af = airflow parameters
w_ned = wind in NED
delta = control vector
%}
function [  pn, pn_hat, ...
            pe, pe_hat, ...
            h, h_hat, h_c, ...
            Va, Va_hat, Va_c, ...
            alpha, alpha_hat, ...
            beta, beta_hat, ...
            phi, phi_hat, phi_c, ...
            theta, theta_hat, theta_c, ...
            psi, psi_hat, ...
            chi, chi_hat, chi_c, ...
            p, p_hat, ...
            q, q_hat, ...
            r, r_hat, ...
            Vg, Vg_hat, ...
            delta_e,delta_a,delta_r,delta_t] = ...
        xadec_postproc_ms(x,x_hat,x_c,af,w_ned,delta,wrap_angle,chi_prev)

        % process inputs to function
    pn          = x(1);             % North position (meters)
    pe          = NaN; % TODO             % East position (meters)
    h           = NaN; % TODO            % altitude (meters)
    u           = NaN; % TODO             % body velocity along x-axis (meters/s)
    v           = x(5);             % body velocity along y-axis (meters/s)
    w           = NaN; % TODO             % body velocity along z-axis (meters/s)
    phi         = 180/pi*x(7);      % roll angle (degrees)   
    theta       = NaN; % TODO      % pitch angle (degrees)
    psi         = x(9);             % yaw angle (radians)
    p           = 180/pi*x(10);     % body angular rate along x-axis (degrees/s)
    q           = NaN; % TODO     % body angular rate along y-axis (degrees/s)
    r           = NaN; % TODO     % body angular rate along z-axis (degrees/s)

    pn_hat      = x_hat(1);            % estimated North position (meters)
    pe_hat      = NaN; % TODO            % estimated East position (meters)
    h_hat       = NaN; % TODO            % estimated altitude (meters)
    Va_hat      =NaN; % TODO           % estimated airspeed (meters/s)
    alpha_hat   = 180/pi*x_hat(5);     % estimated angle of attack (degrees)
    beta_hat    = NaN; % TODO     % estimated side slip angle (degrees)
    phi_hat     = NaN; % TODO     % estimated roll angle (degrees)   
    theta_hat   = NaN; % TODO     % estimated pitch angle (degrees)
    chi_hat     = NaN; % TODO     % estimated course (degrees)
    p_hat       = NaN; % TODO     % estimated body angular rate along x-axis (degrees/s)
    q_hat       = NaN; % TODO     % estimated body angular rate along y-axis (degrees/s)
    r_hat       = NaN; % TODO     % estimated body angular rate along z-axis (degrees/s)
    Vg_hat      = x_hat(13);            % estimated groundspeed
    % wn_hat      = x_hat(14);            % estimated North wind
    % we_hat      = x_hat(15);            % estimated East wind
    psi_hat     = 180/pi*x_hat(16);     % estimated heading
    % bx_hat      = x_hat(17);            % estimated x-gyro bias
    % by_hat      = x_hat(18);            % estimated y-gyro bias
    % bz_hat      = x_hat(19);            % estimated z-gyro bias

    h_c         = x_c(3);            % commanded altitude (meters)
    Va_c        = NaN; % TODO            % commanded airspeed (meters/s)
    phi_c       = 180/pi*x_c(7);     % commanded roll angle (degrees)   
    theta_c     = NaN; % TODO     % commanded pitch angle (degrees)
    chi_c       = NaN; % TODO     % commanded course (degrees)

    Va          = af(1);            % airspeed (m/s)
    alpha       = 180/pi*af(2);     % angle of attack (degrees)
    beta        = NaN; % TODO;     % side slip angle (degrees)

    wn          = w_ned(1);            % wind in the North direction
    we          = NaN; % TODO;            % wind in the East direction
    % wd          = w_ned(3);            % wind in the Down direction

    delta_e     = NaN; % TODO;     % elevator angle (degrees)
    delta_a     = 180/pi*delta(2);     % aileron angle (degrees)
    delta_r     = NaN; % TODO;     % rudder angle (degrees)
    delta_t     = NaN; % TODO;            % throttle setting (unitless)

    Vg = NaN; % TODO

    chi = NaN; % TODO % course angle (radians)
    chi = NaN; % TODO   % course angle (degrees)
    psi  = NaN; % TODO % yaw angle (degrees)

    if wrap_angle
        phi  = wrapTo180(phi);
        % TODO for remaining angles
    else        
        chi = unwrap_angle_from_180(chi,chi_prev);
    end

end
