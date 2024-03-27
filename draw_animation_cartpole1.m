% for Mass-Spring Simulation
%
 
function draw_animation_cartpole1(x1,z1,a1)
global p p1

% Addpoints
addpoints(p,[a1 x1],[0 z1]); %선을 그음 cart and pole

addpoints(p1,[x1-0.02 x1+0.02 x1+0.02 x1-0.02 x1-0.02],...
             [z1-0.02 z1-0.02 z1+0.02 z1+0.02 z1-0.02]);
%진자를 그림


%hold on
drawnow
%hold on
pause(0.01);
end



