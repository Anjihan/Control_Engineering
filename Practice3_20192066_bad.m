%% =========================================
% Practice 1
% Cartpole Dynamic Simulation
% 20192066
% Jihan An
%  =========================================
clc; % 화면 지우기/ % Matlab에서 ;는 해당 라인의 결과를 안봄
clear all;      %이전 작업에서의 영향 삭제
close all;


global p p1 p2         % 변수를 전역으로 선언함

%M = m;
%C = 0;
%G = k*x;
%tau = 0;
%D2 = inv(M)*(-C-G+tau);
%D2 = 1/M*(-C-G+tau);    % 가속도 계산

%% 시뮬레이션 준비

% 0 ~ 10초 dt=0.001초로 설정
dt = 0.001;     % 시간증분
t = 0:dt:10;    % 시뮬레이션 시간
n = length(t);  % iteration 수

x = zeros(1,n); % 0으로 채워진 1,n짜리 공간       % 상태 x(위치) 초기화
d_x = zeros(1,n);                                 % 상태 d_x(속도) 초기화
setha = zeros(1,n); % 0으로 채워진 1,n짜리 공간   % 상태 x(위치) 초기화
d_setha = zeros(1,n);                             % 상태 d_setha(각속도) 초기화

M = 1;      % 카트의 질량, [kg]
m = 1;      % 진자의 질량, [kg]
l = 1;      % 선 길이, [m]
g = 9.81;   % 중력 가속도, [m/s^2]

% Initial condition
x(1) = 0.0;     % initial position
d_x(1) = 0;     % initial velocity
setha(1) = 30*pi/180;       % initial position
d_setha(1) = 0;             % initial ang_velocity


%% Iteration
for i=1:n-1
F = 0 % 카트에 작용하는 힘   [N]
T = 0 % 진자에 작용하는 토크 [Nm]
    
    
    setha(i) = atan2(sin(setha(i)), cos(setha(i)));
%Step 1. 운동방정식으로부터 다음 시간의 가속도 구하기
    D2_x = (-m*g/M*setha(i) + 1/M*F);
    D2_setha = g/l*(1+m/M)*setha(i)-1/M/l*F;

%Step 2. 가속도를 수치적분하여 속도구하기
    d_x(i+1) = d_x(i) + D2_x*dt;
    d_setha(i+1) = d_setha(i) + D2_setha*dt;

%Step 3. 속도를 수치적분하여 위치구하기
    x(i+1) = x(i) + d_x(i+1)*dt;
    setha(i+1) = setha(i) + d_setha(i+1)*dt;

    
end

% 그래프 그리기
figure(7);
plot(t,x,t,setha*180/pi);
title('Position of Cartpole System');
xlabel('time(s)')
legend('pos', 'rad')
grid on;


%% Draw Animation
figure(20)
axis([-5 1 -3 3])
Ax=[0,0];Ay=[0,0];
Cx=[0,0];Cy=[0,0];
p1=animatedline(Ax,Ay,'Color','[0.4 0.5 0.2]','LineWidth',1,'MaximumNumPoints',5);   %다각형을 그리는 함수
p=animatedline(Cx,Cy,'Color','R','LineWidth',1,'MaximumNumPoints',2);               %선을 그리는 함수
p2=animatedline(Ax,Ay,'Color','[0.8 1.0 0.4]','LineWidth',3,'MaximumNumPoints',5);   %다각형을 그리는 함수

grid on

video = VideoWriter('why.mp4','MPEG-4');
open(video)

for i=1:5:n-1
    draw_animation_cartpole2(x(i),0); %cart를 그림
    F=getframe(gcf);
    writeVideo(video,F);
   
    draw_animation_cartpole1((x(i)+l*sin(setha(i))),l*cos(setha(i)),x(i));
    F=getframe(gcf);
    writeVideo(video,F);
end

close(video)















