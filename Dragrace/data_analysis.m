clear
clc
close all

%Vehicle parameters
MaxBremsmoment = 1000;
M_Brems=0;
v_L=0;
gamma=0;
m=2000;
F_Reib=0;
lambda=1;
c_R=0.015;
r=33.55;
v_0=0;
S_0=0;



%Simulation Settings
t_final=600;
t_step=0.001;

%run simulation & ectract data
out=sim('dragrace').get('S_v');
t=out.Time;
S=out.Data(:,1);
v=out.Data(:,2);
n=out.Data(:,3);
M=out.Data(:,4);
FW=out.Data(:,5);

%plotting S
t_Final=15;
subplot(2,1,1);
plot(t,S);
grid on
axis([0 t_Final 0 1]);
xlabel('t(s)');
ylabel('S(km)');
% l1=legend('S(km)');
% l1.FontSize = 12;

%plotting v
subplot(2,1,2); 
hold on;
plot(t,v);
grid on
axis([0 t_Final 0 150]);
xlabel('t(s)');
ylabel('v(kph)');

%Determining acceleration time
Tvar=[0 t_final];
V1=[50 50];
V2=[100 100];
V3=[130 130];
[t1,v1]=polyxpoly(t,v,Tvar,V1);

[t2,v2]=polyxpoly(t,v,Tvar,V2);

[t3,v3]=polyxpoly(t,v,Tvar,V3);

plot(t1,v1,'rx',t2,v2,'gx',t3,v3,'bx');

str1=['t=' num2str(t1) 's'];
str2=['t=' num2str(t2) 's'];
str3=['t=' num2str(t3) 's'];
text(t1+0.5,v1,[str1]);
text(t2+0.5,v2,[str2]);
text(t3+0.5,v3,[str3]);

% l2=legend('v(kph)');
% l2.FontSize = 12;
%printing fig
fig=gcf;
fig.PaperUnits='centimeters';
fig.PaperPosition=[0 0 16 16];
fig.PaperSize=[16 16];
saveas(fig, 'S(km) and v(kph)','pdf');
hold off;

%Plotting Z
figure();
n_tesla = [0 5000:1000:14000,20000,25000,25001];
M_tesla = [493,493,411,352.5,308.1,273.6,246.5,224.3,205.4,189.8,175.8,123.25,98.6,0];
plot(n_tesla*120*pi*r/900000,M_tesla*900/r,v,FW,max(v),mean(FW(v==max(v))),'rx');
grid on;
legend('Zugkraft','Gesamtfahrwiderstand');
axis([0 400 0 20000]);
xlabel('v(kph)');
ylabel('Kraft(N)');
str4=['v_{max}=' num2str(max(v)) 'kph'];
text(max(v)-40,mean(FW(v==max(v)))+500,[str4]);
fig=gcf;
fig.PaperUnits='centimeters';
fig.PaperPosition=[0 0 16 16];
fig.PaperSize=[16 16];
saveas(fig, 'Z and FW','pdf');
hold off;


