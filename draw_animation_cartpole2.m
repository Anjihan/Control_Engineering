% for Mass-Spring Simulation
%
 
function draw_animation_cartpole2(x1,z1)
global p2

% Addpoints

addpoints(p2,[x1-0.08 x1+0.08 x1+0.08 x1-0.08 x1-0.08],...
             [z1-0.06 z1-0.06 z1+0.06 z1+0.06 z1-0.06]);
% cart를 그림

%hold on
drawnow
%hold on
pause(0.01);
end



