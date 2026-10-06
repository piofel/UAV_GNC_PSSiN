% specify initial conditions
x0g = [0; 0; -h0; Va0; 0; 0; 0; gamma_trim; 0; 0; 0; 0];
% specify which states to hold equal to the initial conditions
ix = [];

% specify initial inputs
u0g = [...
    0;... % 1 - delta_e
    0;... % 2 - delta_a
    0;... % 3 - delta_r
    1;... % 4 - delta_t
    ];
% specify which inputs to hold constant
iu = [];

% define constant outputs
y0g = [...
    Va0;...         % 1 - Va
    gamma_trim;...  % 2 - alpha
    0;...           % 3 - beta
    ];
% specify which outputs to hold constant
iy = [1,3];

% define constant derivatives
dx0g = [0; 0; -Va0*sin(gamma_trim); 0; 0; 0; 0; 0; 0; 0; 0; 0];
if R_trim ~= Inf
    dx0g(9) = Va0*cos(gamma_trim)/R_trim;  % 9 - psidot
end
% specify which derivaties to hold constant in trim algorithm
idx = (3:12)';

% compute trim conditions
[x_trim,u_trim,y_trim,dx_trim] = trim(trim_sim_mdl,x0g,u0g,y0g,ix,iu,iy,dx0g,idx);

% check to make sure that the linearization worked (should be small)
% norm(dx_trim(3:end)-dx0g(3:end))

clearvars dx0g idx x0g ix u0g iu y0g iy dx_trim
