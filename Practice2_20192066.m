%% =========================================
% Practice 2
% Pendulum Dynamic Simulation
% 20192066
% Jihan An
%  =========================================
clc; % 화면 지우기/ % Matlab에서 ;는 해당 라인의 결과를 안봄
clear all;      %이전 작업에서의 영향 삭제
close all;

global p p1         % 변수를 전역으로 선언함

%% 시뮬레이션 준비

% 0 ~ 10초 dt=0.001초로 설정
dt = 0.001;     % 시간증분
t = 0:dt:10;    % 시뮬레이션 시간
n = length(t);  % iteration 수

setha = zeros(1,n); % 0으로 채워진 1,n짜리 공간 % 상태 setha(위치) 초기화
d_setha = zeros(1,n);                          % 상태 d_setha(각속도) 초기화

m = 1;      % 질량, [kg]
l = 1;      % 선 길이, [m]
g = 9.81;   % 중력 가속도, [m/s^2]

% Initial condition
setha(1) = 30*pi/180;       % initial position
d_setha(1) = 0;             % initial ang_velocity


%% Iteration
for i=1:n-1

    tau = 0;    % 토크 [N*m]
   
%Step 1. 운동방정식으로부터 다음 시간의 가속도 구하기
    D2 = -g/(l^2)*setha(i) + 1/m/l/l*tau;

%Step 2. 가속도를 수치적분하여 속도구하기
    d_setha(i+1) = d_setha(i) + D2*dt;

%Step 3. 속도를 수치적분하여 위치구하기
    setha(i+1) = setha(i) + d_setha(i+1)*dt;
    
end

% 그래프 그리기
figure(7);
plot(t,setha*180/pi);
title('Angle of Pendulum');
xlabel('time(s)')
ylabel('angle(deg)')
grid on;


%% Draw Animation
figure(20)
axis([-1.5 1.5 -1.5 1.5])
Ax=[0,0];Ay=[0,0];
p=animatedline(Ax,Ay,'Color','b','LineWidth',1,'MaximumNumPoints',2);               %선을 그리는 함수
p1=animatedline(Ax,Ay,'Color','[0.4 0.5 0.2]','LineWidth',2,'MaximumNumPoints',5);  %다각형을 그리는 함수
grid on

video = VideoWriter('Practice2_20192066.mp4','MPEG-4');
open(video)

for i=1:10:n-1
    draw_animation(l*sin(setha(i)),-l*cos(setha(i)));                               %draw_animation(x값, y값)
    F=getframe(gcf);
    writeVideo(video,F);

end

close(video)















