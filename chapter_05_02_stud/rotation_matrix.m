function R = rotation_matrix(phi,theta,psi)
    
    cphi = cos(phi);
    sphi = sin(phi);
    R_roll = [...
          1,    0,      0;...
          0,    cphi,   sphi;...
          0,    -sphi,  cphi];

    ctheta = cos(theta);
    stheta = %TODO (do zrobienia)
    R_pitch = %TODO

    %TODO R_yaw

    R = R_roll * R_pitch * R_yaw;

end

