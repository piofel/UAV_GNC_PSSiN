function [] = draw_aircraft(x,view_prm)
    fig_no = 1;

    pn       = x(1);       % inertial North position     
    pe       = x(2);       % inertial East position
    pd       = x(3);       % inertial Down position
    phi      = x(7);       % roll angle         
    theta    = x(8);       % pitch angle     
    psi      = x(9);       % yaw angle
    p = x(1:3);

    view_size = view_prm(1);
    view_azimuth = view_prm(2);
    view_elevation = view_prm(2);
    view_enabled = view_prm(4);

    % define persistent variables
    persistent vertices
    persistent faces
    persistent face_colors
    persistent aircraft_handle;
    persistent ax; % plotting axes

    if view_enabled
        if isempty(vertices)
            fig = figure(fig_no);
            ax = axes(fig);
            [vertices, faces, face_colors] = define_aircraft_body;
            v = transform_vertices(vertices,pn,pe,pd,phi,theta,psi);
            aircraft_handle = patch('Vertices',v,'Faces',faces, ...
                'FaceVertexCData',face_colors,'FaceColor','flat');
            title('Aircraft')
            xlabel('East, m')
            ylabel('North, m')
            zlabel('Height, m')
            view(ax,view_azimuth,view_elevation)
            axis(ax,calv_view_limits(p,view_size));
            hold on
            grid on
        else
            v = transform_vertices(vertices,pn,pe,pd,phi,theta,psi);
            set(aircraft_handle,'Vertices',v,'Faces',faces);
            view(ax,view_azimuth,view_elevation)
            axis(ax,calv_view_limits(p,view_size));
            drawnow
        end
    end
end

function [v,f,c] = define_aircraft_body
    fuse_L1 = 1;
    fuse_L2 = 0.5;
    fuse_L3 = 2;
    fuse_H = 0.5;
    fuse_W = 0.5;
    wing_W = 3;
    wing_L = 0.5;
    tailwing_L = 0.25;
    tailwing_W = 0.75;
    tail_H = 0.75;
    % define the location of vertices
    v = ...
        [
                fuse_L1                 0               0;          % point 1
                fuse_L2                 fuse_W/2        -fuse_H/2;  % point 2
                fuse_L2                 -fuse_W/2       -fuse_H/2;  % point 3
                fuse_L2                 -fuse_W/2       fuse_H/2;   % point 4
                fuse_L2                 fuse_W/2        fuse_H/2;   % point 5
                -fuse_L3                0               0;          % point 6
                0                       wing_W/2        0;          % point 7
                -wing_L                 wing_W/2        0;          % point 8
                -wing_L                 -wing_W/2       0;          % point 9
                0                       -wing_W/2       0;          % point 10
                -fuse_L3+tailwing_L     tailwing_W/2    0;          % point 11
                -fuse_L3                tailwing_W/2    0;          % point 12
                -fuse_L3                -tailwing_W/2   0;          % point 13
                -fuse_L3+tailwing_L     -tailwing_W/2   0;          % point 14
                -fuse_L3+tailwing_L     0               0;          % point 15
                -fuse_L3                0               -tail_H;    % point 16
                -fuse_L3+tailwing_L/2   0               -tail_H;    % point 17
        ];
    % define the faces
    f = ...
        [
                1   2   3   1;
                1   3   4   1;
                1   4   5   1;
                1   2   5   1;
                2   6   3   2;
                3   6   4   3;
                5   6   4   5;
                2   6   5   2;
                7   8   9   10;
                11  12  13  14;
                6   15  17  16;
        ];
    % define colors for each face    
    myred = [1, 0, 0];
    mygreen = [0, 1, 0];
    myblue = [0, 0, 1];
    myyellow = [1, 1, 0];
    mycyan = [0, 1, 1];
    c = ...
        [
            myred;
            myred;
            myred;
            myred;
            myyellow;
            mycyan;
            myyellow;
            mycyan;
            mygreen;
            mygreen;
            myblue;
        ];
end

function vertices = transform_vertices(vertices,pn,pe,pd,phi,theta,psi)
    R = rotation_matrix(phi,theta,psi);
    vertices = R'*vertices';  % rotate
    vertices = translate(vertices, pn, pe, pd);  % translate
    R_to_ENU = [...
            0, 1, 0;...
            1, 0, 0;...
            0, 0, -1;...
        ];  % transform vertices from NED to ENU (for matlab rendering)
    vertices = R_to_ENU * vertices;
    vertices = vertices';
end

function v = translate(v,pn,pe,pd)
    v = v + repmat([pn;pe;pd],1,size(v,2));
end

function limits = calv_view_limits(position, view_size)
    x1 = position(1) - view_size;
    x2 = position(1) + view_size;
    y1 = position(2) - view_size;
    y2 = position(2) + view_size;
    z1 = -position(3) - view_size;
    z2 = -position(3) + view_size;
    limits = [y1,y2,x1,x2,z1,z2]; % ENU coordinates while position is in NED
end
