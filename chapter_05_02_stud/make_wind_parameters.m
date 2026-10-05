wind_ned_static = [-4;2.5;-1]; % zeros(3,1); % [20;-8;2]; % 

gusts_param(1:3) = [2.12 2.12 1.4]; % zeros(3,1); % gusts' sigma
gusts_param(4:6) = [200 200 50]';  % gusts' L

gusts_param(7:9) =  [1 2 3];  % gusts' seeds
gusts_param(10) = 0.1;  % gusts' noise power
gusts_param(11) = 2;  % gusts' noise correlation time
