% for Mass-Spring Simulation
%
 
function draw_animation_cartpole(x1,z1,a1)
global p

% Addpoints
addpoints(p,[a1 x1],[0 z1]);
% addpoints(p1,[x1-0.02 x1+0.02 x1+0.02 x1-0.02 x1-0.02],...
%              [z1-0.05 z1-0.05 z1+0.05 z1+0.05 z1-0.05]);

%hold on
drawnow
%hold on
pause(0.01);
end



