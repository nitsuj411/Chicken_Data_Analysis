function [c,ceq]=constrntEqns(model, del0, guess)

% tha=pi/2;%guess(1);
% thb=pi/2+model.alpha/2;%guess(2);
% th1=pi/2;%guess(3);
% th2=pi/2;%guess(4);
% th3=pi/3;%guess(5);
% del1=0;%guess(6);
% del2=0;%guess(7);
% del3=0;%guess(8);
% F0=0;%guess(9);
tha=guess(1);
thb=guess(2);
th1=guess(3);
th2=guess(4);
th3=guess(5);
del1=guess(6);
del2=guess(7);
del3=guess(8);
deltrl1=guess(9);
deltrl2=guess(10);
F0=guess(11);

%% Compute all vars/posns here
posA=model.p0+(model.pl0-del0)*[cos(tha);sin(tha)];
posB=posA+(model.trl1+deltrl1)*[cos(thb);sin(thb)];
posC=posA+(model.trl2+deltrl2)*[cos(thb-model.alpha); sin(thb-model.alpha)];
posD=posB+(model.pl1+del1)*[cos(th1);sin(th1)];
posE=posC+(model.pl2+del2)*[cos(th2);sin(th2)];
posG=posD+(model.pl3+del3)*[cos(th3);sin(th3)];

del5=norm(posD-model.p1)-model.pl5;
th5=atan2(model.p1(2)-posD(2),model.p1(1)-posD(1));
del6=norm(posE-model.p2)-model.pl6;
th6=atan2(model.p2(2)-posE(2),model.p2(1)-posE(1));
del7=norm(posG-model.p3)-model.pl7;
th7=atan2(model.p3(2)-posG(2),model.p3(1)-posG(1));
del4=norm(posG-posE)-model.pl4;
th4=atan2(posG(2)-posE(2),posG(1)-posE(1));
thZ=-(pi-chicken_angle(posA,posB,posB+[1;0]));
thW=-chicken_angle(posA,posC,posC+[-1;0]);
% thb=pi/2+model.alpha/2;
%% Constraint equations
FA=F0*((59700*.008735)/.001)*[-cos(tha);-sin(tha)]+model.AtoBk*deltrl1*[cos(thb);sin(thb)]+model.AtoCk*deltrl2*[cos(thb-model.alpha);sin(thb-model.alpha)];


FimplantL=model.AtoBk*del1*[cos(th1);sin(th1)]+model.BtoDk*deltrl1*[cos(thZ);sin(thZ)];
FimplantR=model.AtoCk*del2*[cos(th2);sin(th2)]+model.CtoEk*deltrl2*[cos(thW);sin(thW)];

Fimplant=FimplantL+FimplantR;
side1=model.trl1*[cos(thb);sin(thb)];
side2=model.trl2*[cos(thb-model.alpha);sin(thb-model.alpha)];
Mimplant=cross(model.CtoEk*del2*[cos(th2); sin(th2);0],[model.implant;0;0])+cross(model.AtoCk*deltrl2*[cos(thW);sin(thW);0],[model.implant;0;0]);
%Mimplant=cross(model.k1*del1*[cos(th1);sin(th1);0],[side1;0])+cross(model.k2*del2*[cos(th2); sin(th2);0],[side2;0]);

% Fint1=-model.k1*max(0,del1)*[cos(th1);sin(th1)]+model.k3*max(0,del3)*[cos(th3);sin(th3)]+model.k5*max(0,del5)*[cos(th5);sin(th5)];
% Fint2=-model.k2*max(0,del2)*[cos(th2);sin(th2)]+model.k6*max(0,del6)*[cos(th6);sin(th6)]+model.k4*max(0,del4)*[cos(th4);sin(th4)];
% Fint3=-model.k3*max(0,del3)*[cos(th3);sin(th3)]-model.k4*max(0,del4)*[cos(th4);sin(th4)]+model.k7*max(0,del7)*[cos(th7);sin(th7)];
% 

Fint1=-model.BtoDk*del1*[cos(th1);sin(th1)]+model.k3*del3*[cos(th3);sin(th3)]+model.k5*del5*[cos(th5);sin(th5)];
Fint2=-model.CtoEk*del2*[cos(th2);sin(th2)]+model.k6*del6*[cos(th6);sin(th6)]+model.k4*del4*[cos(th4);sin(th4)];
Fint3=-model.k3*del3*[cos(th3);sin(th3)]-model.k4*del4*[cos(th4);sin(th4)]+model.k7*del7*[cos(th7);sin(th7)];

c=-[del4;del5;del6;del7];
ceq=[FA;Fimplant;Mimplant;Fint1;Fint2;Fint3];
