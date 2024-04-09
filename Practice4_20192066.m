%% =========================================
% Practice 4
% Mass-Spring with PD controller
% 20192066
% Jihan An
%  =========================================
clc; % 화면 지우기/ % Matlab에서 ;는 해당 라인의 결과를 안봄
clear all;      %이전 작업에서의 영향 삭제
close all;


global p p1         % 변수를 전역으로 선언함

%M = m;
%C = 0;
%G = k*x;
%tau = 0;
%D2 = inv(M)*(-C-G+tau);
%D2 = 1/M*(-C-G+tau);    % 가속도 계산

%% 시뮬레이션 준비

% 0 ~ 10초 dt=0.001초로 설정
dt = 0.001;     % 시간증분
t = 0:dt:0.5;    % 시뮬레이션 시간
n = length(t);  % iteration 수

x = zeros(1,n); % 0으로 채워진 1,n짜리 공간 % 상태 x(위치) 초기화
d_x = zeros(1,n);                           % 상태 d_x(속도) 초기화

m = 1;      % 질량, [kg]
k = 100;    % 스프링 계수, [N/m]

% Initial condition
x(1) = 0.0;     % initial position
d_x(1) = 0;     % initial velocity


%% Iteration
for i=1:n-1
% PD controller condition
    Kp = 2000;
    zeta = 0.7;

% PD Control
    r = 1;
    e = r - x(i);
    d_e = -d_x(i);
    Wn = sqrt((Kp+k)/m);
    Kd = 2 * zeta * Wn;
    u = Kp * e + Kd * d_e;

%Step 1. 운동방정식으로부터 다음 시간의 가속도 구하기
    D2 = ( -k*x(i) + u ) / m;

%Step 2. 가속도를 수치적분하여 속도구하기
    d_x(i+1) = d_x(i) + D2*dt;

%Step 3. 속도를 수치적분하여 위치구하기
    x(i+1) = x(i) + d_x(i+1)*dt;
    
    
end

% 그래프 그리기
figure(1);
plot(t,x);
title('Position of Mass-Spring System');
xlabel('time(s)')
ylabel('position(m)')
grid on;


% 그래프 그리기 2
figure(2);
plot(t,x,t,d_x)
title('Simulation of Mass-Spring System');
xlabel('time(s)')
grid on;
legend('pos', 'vel')


% 그래프 그리기 3
figure(3);
subplot(211) %2 by 1에 1번 자리
xlabel('time(s)')
ylabel('position(m)')
grid on;
plot(t,x)
subplot(212) %2 by 1에 2번 자리
plot(t,d_x)
xlabel('time(s)')
ylabel('velocity(m/s)')
grid on;


%% Draw Animation
figure(20)
axis([-0.2 1.2 -1 1])
Ax=[0,0];Ay=[0,0];
p=animatedline(Ax,Ay,'Color','b','LineWidth',1,'MaximumNumPoints',2);               %선을 그리는 함수
p1=animatedline(Ax,Ay,'Color','[0.4 0.5 0.2]','LineWidth',2,'MaximumNumPoints',5);  %다각형을 그리는 함수
grid on

video = VideoWriter('Practice4_20192066.mp4','MPEG-4');
open(video)

for i=1:1:n-1
    draw_animation(x(i),0);
    F=getframe(gcf);
    writeVideo(video,F);

end

close(video)















