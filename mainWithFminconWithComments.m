%% This code used constrntEqns2.m and chicken_angle
clc; close all; clear all;
options=optimset('Display','off');
options2 = optimset('MaxFunEvals',2e4,'MaxIter',2e4);
%% all units and equations are in cm
%Angle between model.trl1 and model.trl2 made by implant. cannot be pi/6
% angle=(.75:0.05:1.4);
% %.876
% %Length of implant 
% model.trl3=(.85:.05:1.1); 
% model.factor=model.trl3;
angle=(1.4:0.05:1.4);
%.876
%Length of implant 
 
model.factor=1.1;


%% Sets parameters for triangle and tendon network. 
%All units are in centimeters 

% Spring Constant are (59700*CSArea)/org tendon length 
 model.k1=259.45;
% model.k2=134.5215;
model.k4=235.4126;
model.k3=201.5075;

model.k5=120.255;
model.k6=114.3765;

model.k7=117.3269;
% % p=59700/14706;
% p=1
% %Spring Constants scaled by 8.633
%  model.k1=259.45/p;
%  model.k2=134.5215/p;
% model.k4=235.4126/p;
% model.k3=201.5075/p;
% 
% model.k5=120.255/p;
% model.k6=114.3765/p;
% 
% model.k7=117.3269/p;

%Sets Coordinates of finger ends and tendon muscle end (Do not Change) 
model.p0=[0;-5];
model.p1=[-1;4];
model.p2=[1;4];
model.p3=[0;4];

%Length of the tendons ((Data from motion capture system
model.DtoA=2.01;
model.EtoA=1.89;
model.pl3=1.08; %make sure this is equal to the distance between the triangle top ends
model.pl4=1.26;

%Sets intial positions (Data from motion capture system) 
posD=[-.56;1.81];
posE=[.52;1.94];
posG=[0;2.91];

%Length of finger tendons
model.pl5=norm(model.p2-posE);
model.pl6=norm(model.p1-posD);
model.pl7=norm(model.p3-posG);

% Allocate memory for faster computing 
z_value=zeros(length(model.factor),length(angle));
height_graph=zeros(length(model.factor),length(angle));
length_graph=zeros(length(model.factor),length(angle));
angle_graph=zeros(length(model.factor),length(angle));

%%
%number of fingers that are immobilized
% type=input('Please enter the number of digits immobilized from 0 to 3: ');
type=2;
if type==0||type==1||type==2||type==3
else
    fprintf('You did not enter the one of the correct values. ')
end

if type==1
            model.k6=(model.k6*25)/(model.k6+25);%(CITE SOURCE FOR TENDON STRENGTH)
            model.k7=(model.k7*25)/(model.k7+25);
        elseif type == 2
            model.k6=(model.k6*25)/(model.k6+25);
        elseif type==0
            model.k5=(model.k5*25)/(model.k5+25);
            model.k6=(model.k6*25)/(model.k6+25);
            model.k7=(model.k7*25)/(model.k7+25);
end
%% For loop for computing the best height from the biforcation point and length of the implant 

for count1=1:length(model.factor)
    for count2=1:length(angle)
       %% Reset to initial conditions
        %Parameter for triangle 
        model.implant=model.factor(count1);
        model.alpha=angle(count2);
        %Implant to Biaforcation 
        height=((model.factor(count1)/2)/tan(model.alpha/2));
        model.trl1=height/cos(model.alpha/2);
        model.trl2=model.trl1;
        model.pl1=model.DtoA-model.trl1;
        model.pl2=model.EtoA-model.trl1;
        %Change in spring Constants for each implant parameter 
     
        model.AtoCk = (59700*.00426)/model.trl1;
        model.CtoEk = (59700*.00426)/model.pl1;
        
        model.AtoBk = (59700*.008735)/model.trl2;
        model.BtoDk = (59700*.008735)/model.pl2;
        
              
        
        %Was used to compute the implant length 
        %model.trl3=norm(model.trl1*[cos(pi/2+model.alpha/2);sin(pi/2+model.alpha/2)]-model.trl2*[cos(pi/2-model.alpha/2);sin(pi/2-model.alpha/2)]);
        
        %% Sets intial positions
        posD=[-.58;1.85];
        posE=[.58;1.85];
        posG=[0;2.86];
        %posA=[0;0];
        
      
        %Resets the length of the finger tendons 
        model.pl5=norm(model.p2-posE);
        model.pl6=norm(model.p1-posD);
        model.pl7=norm(model.p3-posG);
       
%         %Left side angle between model.trl1 and horz
%        thZ=-(pi-chicken_angle(posA,posB,posB+[1;0]));
%        %Right side angle between model.trl1 and horz
% 
%        thW=-chicken_angle(posA,posC,posC+[-1;0]);
      %Th1 calculates the angle between model.pl1 and the horizontal 
       th1=acos((posD(1)+model.factor(count1)/2)/model.pl1);
       posB=posD-model.pl1*[cos(th1);sin(th1)];
       posC=posB+[model.factor(count1);0];
       %Angle between model.trl1 and horz
       thc=-(180-model.alpha)/2;
       posA=posB+model.trl1*[cos(thc);sin(thc)];
       %Calculates the angle between muscle tendon and the horizontal
       tha=atan2(posA(2)-model.p0(2),posA(1)-model.p0(1));
       %Calculates the angle b/n horizonal and model.trl1
       thb=pi/2+model.alpha/2;
       %Calculates the angel b/n horizontal and model.pl2
       th2=pi-th1;
       %Calculates the angle between model.pl1 and model.pl3
       th3=atan2(posG(2)-posD(2),posG(1)-posD(1));
       %Resets the change in length of P1, P2, P3, and muscle tendon
       del0=0;
       del1=0;
       del2=0;
       del3=0;
       del4=0;
       del5=0;
       del6=0;
       del7=0;
       deltrl1=0;
       deltrl2=0;
       
       %Set the length of the muscle tendon 
       model.pl0=norm(posA-model.p0);
       % Used in fmincon solver 
       res1=[tha;thb;th1;th2;th3;del1;del2;del3;deltrl1;deltrl2;0];
        
        F0=res1(end); 
       
       %% Plots intial tendon conditions (Comment out to run faster)
                
%             hold off;
%             plot([model.p1(1);posD(1);posB(1);posA(1);model.p0(1)],[model.p1(2);posD(2);posB(2);posA(2);model.p0(2)]);
%             hold on;
%             plot([model.p2(1); posE(1); posC(1); posA(1)],[model.p2(2); posE(2); posC(2); posA(2)]);
%             plot([model.p3(1);posG(1); posD(1)],[model.p3(2);posG(2); posD(2)]);
%             plot([posG(1);posE(1)],[posG(2);posE(2)]);
%             plot([posB(1);posC(1)],[posB(2);posC(2)]);
%             axis([-5 5 -5 5]);
%             pause(0.15);
%             
        %%   For loop for calculating the end postion of the tendon network after it is pulled. (Find the the change in lenght of all the fingers) 
        A=[];
        b=[];
        Aeq=[];
        beq=[];
        lb=[0;0;0;0;0;0;0;0;0;0;-20000];
        ub=[2*pi;2*pi;2*pi;2*pi;2*pi;2;2;2;2;2;20000];
        
        for del0=.1:0.01:4
          F0
           F_Mxy=F0*((59700*.008735)/.001)*[-cos(tha);-sin(tha)];
           F_M=sqrt((F_Mxy(1))^2+(F_Mxy(2)^2))
           del0
        if F_M<= 30
               
         
         
            [res1,fval,exitflag, output]=fmincon(@(x) 0, res1, A, b, Aeq, beq, lb, ub, @(guess)constrntEqns2(model,del0,guess),options2);
            %fval
            if exitflag<=0
                
                break;
            end
        
        

            
            tha=res1(1);
            thb=res1(2);
            th1=res1(3);
            th2=res1(4);
            th3=res1(5);
            del1=res1(6);
            del2=res1(7);
            del3=res1(8);
            deltrl1=res1(9);
            deltrl2=res1(10);
            F0=res1(11);

            %% Compute all vars/posns here
	% Calculates all Pos, Tendon Length, and angle changes after simulation has run 
            posA=model.p0+(model.pl0-del0)*[cos(tha);sin(tha)];

            posB=posA+(model.trl1+deltrl1)*[cos(thb);sin(thb)];

            posC=posA+(model.trl2+deltrl2)*[cos(thb-model.alpha); sin(thb-model.alpha)];

            posD=posB+(model.pl1+del1)*[cos(th1);sin(th1)];

            posE=posC+(model.pl2+del2)*[cos(th2);sin(th2)];

            posG=posD+(model.pl3+del3)*[cos(th3);sin(th3)];
	
	% Change in pl5
            del5=norm(posD-model.p1)-model.pl5;
	% th5 is the angle that Pl5 makes with Horz
            th5=atan2(model.p1(2)-posD(2),model.p1(1)-posD(1));
    %Change in pl6
            del6=norm(posE-model.p2)-model.pl6;
	% th6 is the angle that pl6 makes with Horz
            th6=atan2(model.p2(2)-posE(2),model.p2(1)-posE(1));

    %Change in pl7
            del7=norm(posG-model.p3)-model.pl7;
    % th7 is the angle that pl7 makes with Horz
            th7=atan2(model.p3(2)-posG(2),model.p3(1)-posG(1));
	
            del4=norm(posG-posE)-model.pl4;

	%angle of pl4 with respect to horizontal, will be negative
            th4=atan2(posG(2)-posE(2),posG(1)-posE(1));

  %% Constraint equations
  thZ=-(pi-chicken_angle(posA,posB,posB+[1;0]));
thW=-chicken_angle(posA,posC,posC+[-1;0]);
FA=F0*((59700*.008735)/5)*[-cos(tha);-sin(tha)]+model.AtoBk*deltrl1*[cos(thb);sin(thb)]+model.AtoCk*deltrl2*[cos(thb-model.alpha);sin(thb-model.alpha)];


FimplantL=model.AtoBk*del1*[cos(th1);sin(th1)]+model.BtoDk*deltrl1*[cos(thZ);sin(thZ)];
FimplantR=model.AtoCk*del2*[cos(th2);sin(th2)]+model.CtoEk*deltrl2*[cos(thW);sin(thW)];

Fimplant=FimplantL+FimplantR;
side1=model.trl1*[cos(thb);sin(thb)];
side2=model.trl2*[cos(thb-model.alpha);sin(thb-model.alpha)];
Mimplant=cross(model.CtoEk*del2*[cos(th2); sin(th2);0],[model.implant;0;0])+cross(model.AtoCk*deltrl2*[cos(thW);sin(thW);0],[model.implant;0;0]);


Fint1=-model.BtoDk*del1*[cos(th1);sin(th1)]+model.k3*del3*[cos(th3);sin(th3)]+model.k5*del5*[cos(th5);sin(th5)];
Fint2=-model.CtoEk*del2*[cos(th2);sin(th2)]+model.k6*del6*[cos(th6);sin(th6)]+model.k4*del4*[cos(th4);sin(th4)];
Fint3=-model.k3*del3*[cos(th3);sin(th3)]-model.k4*del4*[cos(th4);sin(th4)]+model.k7*del7*[cos(th7);sin(th7)];

c=[FA;Fimplant;Mimplant;Fint1;Fint2;Fint3]
          %% Plots tendon network with change in lenght from pulling on the muscle tendon (comment out for code to run faster)
%             hold off;
%             plot([model.p1(1);posD(1);posB(1);posA(1);model.p0(1)],[model.p1(2);posD(2);posB(2);posA(2);model.p0(2)]);
%             hold on;
%             plot([model.p2(1); posE(1); posC(1); posA(1)],[model.p2(2); posE(2); posC(2); posA(2)]);
%             plot([model.p3(1);posG(1); posD(1)],[model.p3(2);posG(2); posD(2)]);
%             plot([posG(1);posE(1)],[posG(2);posE(2)]);
%             plot([posB(1);posC(1)],[posB(2);posC(2)]);
%             axis([-5 5 -5 5]);
%             pause(0.15);
           
          
      delta0(count1,count2)=del0;
%         delta2(count1,count2)=del2;
%         delta3(count1,count2)=del3;
%         delta5(count1,count2)=del5;
%         delta6(count1,count2)=del6;
%         delta7(count1,count2)=del7;
            
        else 
          
            break; 
        end 
%         
      
        end
        
        %% Calculates the differential action between fingers immobilized and not finger not immobilized 
         if type==1
            z_value(count1,count2)= ((del6+del7)/2-del5)/del0;
            
        elseif type == 2
           z_value(count1,count2)= (del6/(del0-.1));
           %z_value(count1,count2)= (del6-(del5+del7)/2)/del0;
        else
            z_value(count1,count2)= ((del5+del6+del7)/3)/del0; 
         % Store all the deltas    
        
   
         end 
   %Store Height and length value for graphing Values 
   height_graph(count1,count2)=height;
   length_graph(count1,count2)=model.factor(count1);
   angle_graph(count1,count2)=model.alpha;
      
    end
       
end
        
        
  
%% Graphing The results 



z_value2=z_value;

figure
surf(length_graph,angle_graph,z_value)
zlabel('Differential Action')
xlabel('length');
ylabel('angle');
colorbar('northoutside');


figure
surf(length_graph,height_graph,z_value2)
zlabel('Differential Action')
xlabel('length');
ylabel('height');
colorbar('northoutside');



