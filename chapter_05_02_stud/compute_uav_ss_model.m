% State-space UAV models

% Global variables used:
% x_trim is the trimmed state,
% u_trim is the trimmed input

% Continuous models
[A,B,C,D] = linmod(trim_sim_mdl,x_trim,u_trim);

E1 = [...
0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0;...
0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0;...
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1;...
0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0;...
0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0;...
];
E2 = [...
0, 1, 0, 0;...
0, 0, 1, 0;...
];
% x_lat = [v p r phi psi]'
A_lat = E1 * A * E1';
% u_lat = [delta_a delta_r]'
B_lat = E1 * B * E2';

E3 = NaN; %TODO
E4 = NaN; %TODO
% x_lon = [u w q theta h]'
A_lon = NaN; %TODO
% u_lon = [delta_e delta_t]'
B_lon = NaN; %TODO

% y_lat = beta
C_lat = [C(3,5) C(3,10) C(3,12) C(3,7) C(3,9)];
% y_lon = [Va alpha]'
C_lon = [C(1:2,4) C(1:2,6) C(1:2,11) C(1:2,8)  -C(1:2,3)];

