clc; clearvars -except z_out roll_out pitch_out;

z = z_out;
roll = roll_out;
pitch = pitch_out;

n = length(z);

figure;
set(gcf,'Renderer','zbuffer');

v = VideoWriter('drone_simulation1.avi');
v.FrameRate = 20; 
open(v);

for i = 1:n
    
    clf;
    hold on;
    grid on;
    
    x = 0; y = 0;
    L = 1;
    R_roll = [1 0 0;
              0 cos(roll(i)) -sin(roll(i));
              0 sin(roll(i)) cos(roll(i))];
          
    R_pitch = [cos(pitch(i)) 0 sin(pitch(i));
               0 1 0;
              -sin(pitch(i)) 0 cos(pitch(i))];
          
    R = R_pitch * R_roll;
   
    arm1 = R * [-L 0 0; L 0 0]';
    arm2 = R * [0 -L 0; 0 L 0]';
    
    plot3(arm1(1,:), arm1(2,:), arm1(3,:) + z(i), 'r','LineWidth',3);
    plot3(arm2(1,:), arm2(2,:), arm2(3,:) + z(i), 'b','LineWidth',3);
    plot3(x, y, z(i), 'ko','MarkerSize',8,'MarkerFaceColor','k');
    
    view(45,30);
    xlim([-2 2]);
    ylim([-2 2]);
    zlim([0 max(z)+2]);
    
    xlabel('X'); ylabel('Y'); zlabel('Z');
    title('3D Drone Simulation');
    
    drawnow;
    frame = getframe(gca);
    writeVideo(v, frame);
    
end

close(v);