X=csvread('C:\Users\robotics admin\Desktop\X-r.csv');
Y=csvread('C:\Users\robotics admin\Desktop\Y-r.csv');
Z=csvread('C:\Users\robotics admin\Desktop\Z-r.csv');

 X(1,:)=[];
 Y(1,:)=[];
 Z(1,:)=[];

j=540;
 p1=[X(j,1),Y(j,1),Z(j,1)];
 p2=[X(j,2),Y(j,2),Z(j,2)];
 p3=[X(j,3),Y(j,3),Z(j,3)];
 p4=[X(j,4),Y(j,4),Z(j,4)];
 p5=[X(j,5),Y(j,5),Z(j,5)];
 p6=[X(j,6),Y(j,6),Z(j,6)];
%  p7=[X(j,7),Y(j,7),Z(j,7)];
%  p8=[X(j,8),Y(j,8),Z(j,8)];
%  p9=[X(j,9),Y(j,9),Z(j,9)];
%  p10=[X(j,10),Y(j,10),Z(j,10)];
%  p11=[X(j,11),Y(j,11),Z(j,11)];
%  p12=[X(j,12),Y(j,12),Z(j,12)];
%  p13=[X(j,13),Y(j,13),Z(j,13)];
%  p14=[X(j,14),Y(j,14),Z(j,14)];
%  p15=[X(j,15),Y(j,15),Z(j,15)];


  scatter3(p1(1),p1(2),p1(3),'r')
  hold on
  scatter3(p2(1),p2(2),p2(3),'b')
  hold on
  scatter3(p3(1),p3(2),p3(3),'g')
  hold on
  scatter3(p4(1),p4(2),p4(3),'k')
  hold on
  scatter3(p5(1),p5(2),p5(3),'r*')
  hold on
  scatter3(p6(1),p6(2),p6(3),'b*')
  hold on
%  scatter3(p7(1),p7(2),p7(3),'g*')
%  hold on
%  scatter3(p8(1),p8(2),p8(3),'k*')
%  hold on
%  axis equal
%  scatter3(p9(1),p9(2),p9(3),'rd')
%  hold on
%  scatter3(p10(1),p10(2),p10(3),'bd')
%  hold on
%  scatter3(p11(1),p11(2),p11(3),'cd')
%  hold on
%  scatter3(p12(1),p12(2),p12(3),'kd')
%  hold on
%  scatter3(p13(1),p13(2),p13(3),'r+')
%  hold on
%  scatter3(p14(1),p14(2),p14(3),'b+')
%  hold on
%  scatter3(p15(1),p15(2),p15(3),'c+')

 % left_final=p6;
 % right_final=p2;

 angle1_final=180-chicken_angle(p2,p1,p3);
 angle2_final=180-chicken_angle(p1,p3,p6);
 angle3_final=180-chicken_angle(p3,p6,p4);
% 
      angle1_move=abs(angle1_final-angle1_initial)
      angle2_move=abs(angle2_final-angle2_initial)
      angle3_move=abs(angle3_final-angle3_initial)
%    