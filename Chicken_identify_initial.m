
X=csvread('C:\Users\robotics admin\Desktop\X-r.csv');
Y=csvread('C:\Users\robotics admin\Desktop\Y-r.csv');
Z=csvread('C:\Users\robotics admin\Desktop\Z-r.csv');

 X(1,:)=[];
 Y(1,:)=[];
 Z(1,:)=[];

i=150;
 p1=[X(i,1),Y(i,1),Z(i,1)];
 p2=[X(i,2),Y(i,2),Z(i,2)];
 p3=[X(i,3),Y(i,3),Z(i,3)];
 p4=[X(i,4),Y(i,4),Z(i,4)];
  p5=[X(i,5),Y(i,5),Z(i,5)];
    p6=[X(i,6),Y(i,6),Z(i,6)];
%     p7=[X(i,7),Y(i,7),Z(i,7)];
%     p8=[X(i,8),Y(i,8),Z(i,8)];
%     p9=[X(i,9),Y(i,9),Z(i,9)];
%     p10=[X(i,10),Y(i,10),Z(i,10)];
%    p11=[X(i,11),Y(i,11),Z(i,11)];
%   p12=[X(i,12),Y(i,12),Z(i,12)];
%   p13=[X(i,13),Y(i,13),Z(i,13)];
% p14=[X(i,14),Y(i,14),Z(i,14)];
%  p15=[X(i,15),Y(i,15),Z(i,15)];



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
%     scatter3(p7(1),p7(2),p7(3),'g*')
%     hold on
%     scatter3(p8(1),p8(2),p8(3),'k*')
%     hold on
    
   axis equal
%     scatter3(p9(1),p9(2),p9(3),'r')
%   hold on
%    scatter3(p10(1),p10(2),p10(3),'k')
%    hold on
%   scatter3(p11(1),p11(2),p11(3),'k')
%   hold on
%   scatter3(p12(1),p12(2),p12(3),'r')
%   hold on
%  scatter3(p13(1),p13(2),p13(3),'g')
%  hold on
 %scatter3(p14(1),p14(2),p14(3),'b+')
 %hold on
%  scatter3(p15(1),p15(2),p15(3),'c+')

%    plot3([p1(1),p13(1)], [p1(2),p13(2)], [p1(3),p13(3)],'g--')
%      hold on
%   plot3([p2(1),p3(1)], [p2(2),p3(2)], [p2(3),p3(3)],'k')
%     hold on
%   plot3([p5(1),p7(1)], [p5(2),p7(2)], [p5(3),p7(3)],'r--')
%     hold on
%   plot3([p7(1),p9(1)], [p7(2),p9(2)], [p7(3),p9(3)],'r--')
%    hold on
%   plot3([p2(1),p4(1)], [p2(2),p4(2)], [p2(3),p4(3)],'k')
%     hold on
%   plot3([p3(1),p1(1)], [p3(2),p1(2)], [p3(3),p1(3)],'k')
%     hold on
%   plot3([p6(1),p12(1)], [p6(2),p12(2)], [p6(3),p12(3)],'k--')
%     hold on
%   plot3([p1(1),p8(1)], [p1(2),p8(2)], [p1(3),p8(3)],'k')
%     hold on
%   plot3([p10(1),p12(1)], [p10(2),p12(2)], [p10(3),p12(3)],'k--')
%     hold on
%   plot3([p11(1),p8(1)], [p11(2),p8(2)], [p11(3),p8(3)],'b--')
%     hold on
%   plot3([p10(1),p3(1)], [p10(2),p3(2)], [p10(3),p3(3)],'k')
%     hold on
%   plot3([p1(1),p2(1)], [p1(2),p2(2)], [p1(3),p2(3)],'g')
%     hold on
 
  
  %    left_initial=p2;
%    right_initial=p3;
% % 
      angle1_initial=180-chicken_angle(p2,p1,p3);
     angle2_initial=180-chicken_angle(p1,p3,p6);
     angle3_initial=180-chicken_angle(p3,p6,p4); 
%      