% Global variables used:
% uav_param,
% x_trim is the trimmed state,
% u_trim is the trimmed input,
% y_trim is the trimmed output.

Gamma3 = uav_param(3);
Gamma4 = uav_param(4);
mass = NaN; %TODO
Jy = uav_param(12);
gravity = uav_param(15);
S_wing = uav_param(16);
b = uav_param(17);
c = uav_param(18);
S_prop = uav_param(19);
rho = NaN; %TODO
C_D_0 = uav_param(24);
C_D_alpha = uav_param(27);
C_m_alpha = uav_param(28);
C_m_q = uav_param(31);
C_D_delta_e = uav_param(33);
C_m_delta_e = NaN; %TODO
C_Y_beta = uav_param(42);
C_ell_p = uav_param(46);
C_n_p = uav_param(47);
C_ell_delta_a = uav_param(52);
C_n_delta_a = NaN; %TODO
C_Y_delta_r = uav_param(54);
C_prop = uav_param(57);
k_motor = uav_param(58);

theta_trim = x_trim(8);
psi_trim = NaN; %TODO
Va_trim = y_trim(1);
alpha_trim = NaN; %TODO
delta_e_trim = u_trim(1);
delta_t_trim = NaN; %TODO

twice_Va = 2*Va_trim;
aero_factor = 0.5 * rho * Va_trim^2 * S_wing;
C_p_p = NaN; %TODO
C_p_delta_a = Gamma3*C_ell_delta_a + Gamma4*C_n_delta_a;
a_phi1 = -aero_factor*b*C_p_p*b/twice_Va;
a_phi2 = NaN; %TODO
a_theta_com = rho*Va_trim^2*c*S_wing/(2*Jy);
a_theta1 = -a_theta_com*C_m_q*c/twice_Va;
a_theta2 = NaN; %TODO
a_theta3 = NaN; %TODO
a_V1 = NaN; %TODO
a_V2 = NaN; %TODO
a_V3 = gravity*cos(theta_trim-psi_trim);
a_beta_com = rho*Va_trim*S_wing/(2*mass);
a_beta1 = -a_beta_com*C_Y_beta;
a_beta2 = NaN; %TODO

% define transfer functions
T_phi_delta_a   = tf(a_phi2,[1,a_phi1,0]);
T_chi_phi       = tf(gravity/Va_trim,[1,0]);
T_theta_delta_e = NaN; %TODO
T_h_theta       = NaN; %TODO
T_h_Va          = NaN; %TODO
T_Va_delta_t    = NaN; %TODO
T_Va_theta      = NaN; %TODO
T_beta_delta_r  = tf(a_beta2,[1,a_beta1]);

