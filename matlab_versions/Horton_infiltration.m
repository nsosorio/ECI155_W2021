%%%==========CHAPTER 1, sample problem 1: Infiltration================%%%
%%%========================Horton_infiltration========================%%%
%This code solves the example Horton infltration model in the class notes

%Begin by clearing the computer memory and closing all figures
clear all;close all;clc;


%Discretize time over the 5 hours of interest
t=0:0.001:5; %break the 5 hours into increments of 0.01 hrs


%We consider three different precipitation events, defined by a case number (1,2,3)
%setup=input('Which precipitation case do you want (1,2,3)? ')
setup = 3;

%Parameters associated with the Horton Infiltration Capacity Model
fo=120; %mm/hr
fc=10;  %mm/hr
k=1/2;  %hr^-1


%Calculate the Horton Infiltration Capacity over the time of interest
fp=fc+(fo-fc)*exp(-k*t);


%%Determine time when infiltration capacity is reduced by 10%
[~,ind]=min(abs(fp - fo*0.9));
sprintf('Time when fc is reduced by 10 percent occurs at t~%.2f hr.',t(ind))


%Plot the Horton Infiltration Capacity
plot(t,fp,'LineWidth',2);hold on;
set(gca,'FontSize',16);
xlabel('Time (hr)','FontSize',16);
ylabel('Infiltration (mm/hr)','FontSize',16);


%pause

%Now we will plot the precipitation on the same plot - different for each case
if setup==1             %Precipitation setup 1
    P(t<=5)=25;
elseif setup==2         %Precipitation setup 2
    P(t<=1)=25;
    P(t>1 & t<=3)=10;
    P(t>3 & t<=5)=50;
elseif setup==3         %Precipitation setup 3
    P(t<=1)=50;
    P(t>1 & t<=3)=25;
    P(t>3 & t<=5)=10;
end

plot(t,P,'LineWidth',2);

%pause


%Now find the minimum of Infiltration Capacity (fp) and Precipitation (P) at each point in time
ind=find(P<fp);	            %Find the elements in the vector where P<fp
Infiltration=fp;		    %Assume Infiltration rate is given by fp, the Horton Infiltration Capacity
Infiltration(ind)=P(ind);	%Now replace all elements with those of P, where P<fp


%Plot this minimum of fp and P to verify that it is indeed correct
HH=area(t,Infiltration,'FaceColor','y');
legend('Infiltation capacity','Precipitation rate','Actual infiltration');
title(sprintf('Precipitation setup %d',setup));


%Finally, get the total infiltration we have to integrate this over the whole time by numerical integration
dt=t(2)-t(1);		                %size of the time step
Total_I=sum(Infiltration*dt)		%mm, simple integration scheme

Area = 100*(1e3)^2;                 %m^2
Total_I = Total_I*1e-3;             %m
Vol_I = Total_I*Area                %m^3



