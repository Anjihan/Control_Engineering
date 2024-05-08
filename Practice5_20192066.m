%% =========================================
% Practice 5
% Cart-Pole System Dynamic Simulation
% 20192066
% Jihan An
%  =========================================
clc; % 화면 지우기/ % Matlab에서 ;는 해당 라인의 결과를 안봄
clear all;      %이전 작업에서의 영향 삭제
close all;

global p p1         % 변수를 전역으로 선언함
global l

%% 시뮬레이션 준비

% 0 ~ 10초 dt=0.001초로 설정
dt = 0.001;     % 시간증분
t = 0:dt:10;    % 시뮬레이션 시간
n = length(t);  % iteration 수

x = zeros(1,n);    % Cart position 초기화
d_x = zeros(1,n);  % Cart velocity 초기화
th = zeros(1,n);   % Pole angle 초기화
d_th = zeros(1,n); % Pole angular velocity 초기화

m1 = 10;  % mass of cart [kg]
m2 = 1;   % mass of pole [kg]
l = 1;    % length of pole [m]
g = 9.81; % gravity acceleration [m/s^2]

% Initial condition
x(1) = 0;
d_x(1) = 0;
th(1) = 10*pi/180;
d_th(1) = 0;

% Finding controller
A = [0 1 0 0
     0 0 -m2*g/m1 0
     0 0 0 1
     0 0 (m1+m2)*g/m1/l 0]; %선형화한 행렬A

B = [0;1/m1;0;-1/m1/l]; %선형화한 행렬B

P=[-4;-4;-4;-4]; %원하는 특성방정식의 극점

K = Acker(A,B,P); %K를 찾는 과정

%% Iteration
for i=1:n-1

% Step 4. Control
%K = [-24.4648 -50.9684 -482.3748 -150.9684];
u = -K*[x(i);d_x(i);th(i);d_th(i)];


% Step 1. 운동방정식으로부터 다음 시간의 가속도 구하기
% D2 = inv(M)*(-C-G+T)  

M = [m1+m2 m2*l*cos(th(i)); m2*l*cos(th(i)) m2*l*l];
C = [-m2*l*sin(th(i))*d_th(i)*d_th(i) ; 0];
G = [0 ; -m2*g*l*sin(th(i))];
T = [u;0];

D2 = inv(M)*(-C-G+T);

d2_x = D2(1);
d2_th = D2(2);

% Step 2. 가속도를 수치적분하여 속도구하기
d_th(i+1) = d_th(i) + dt * d2_th;
d_x(i+1) = d_x(i) + dt * d2_x;

% Step 3. 속도를 수치적분하여 위치구하기
th(i+1) = th(i) + dt * d_th(i+1);
x(i+1) = x(i) + dt * d_x(i+1);

end

% 그래프 그리기
figure(1);
subplot(211);
plot(t,x);
ylabel('position of cart (m)')
grid on;
subplot(212);
plot(t,th*180/pi);
ylabel('angle of pole (deg)')
grid on;

%% Draw Animation
figure(2)
axis([-1 1 -1 1])
Ax=[0,0];Ay=[0,0];
p=animatedline(Ax,Ay,'Color','b','LineWidth',1,'MaximumNumPoints',2);               %선을 그리는 함수
p1=animatedline(Ax,Ay,'Color','[0.4 0.5 0.2]','LineWidth',2,'MaximumNumPoints',5);  %다각형을 그리는 함수
grid on

video = VideoWriter('Practice5_20192066.mp4','MPEG-4');
open(video)

for i=1:10:n-1
    draw_animation2(x(i),th(i));                               %draw_animation(x값, y값)
    F=getframe(gcf);
    writeVideo(video,F);

end

close(video)















