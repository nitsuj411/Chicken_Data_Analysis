close all

  data=csvread('C:\Users\Robotic Admin\Desktop\chicken\Implant1\Zdata-r.csv');
Xc=csvread('C:\Users\Robotic Admin\Desktop\chicken\Implant1\X-r.csv');
Yc=csvread('C:\Users\Robotic Admin\Desktop\chicken\Implant1\Y-r.csv');
Zc=csvread('C:\Users\Robotic Admin\Desktop\chicken\Implant1\Z-r.csv');
 data(1,:)=[];
 Xc(1,:)=[];
 Yc(1,:)=[];
 Zc(1,:)=[];


Xr=csvread('C:\Users\Robotic Admin\Desktop\chicken\Implant1\X-c.csv');
Yr=csvread('C:\Users\Robotic Admin\Desktop\chicken\Implant1\Y-c.csv');
Zr=csvread('C:\Users\Robotic Admin\Desktop\chicken\Implant1\Z-c.csv');
 data(1,:)=[];
 Xr(1,:)=[];
 Yr(1,:)=[];
 Zr(1,:)=[];

Xl=csvread('C:\Users\Robotic Admin\Desktop\chicken\Implant1\X-l.csv');
Yl=csvread('C:\Users\Robotic Admin\Desktop\chicken\Implant1\Y-l.csv');
Zl=csvread('C:\Users\Robotic Admin\Desktop\chicken\Implant1\Z-l.csv');
 data(1,:)=[];
 Xl(1,:)=[];
 Yl(1,:)=[];
 Zl(1,:)=[];

for i=1:length(Xr)
   
   axis equal
    scatter3(Xc(i,:),Yc(i,:),Zc(i,:),'r')
     hold on
    scatter3(Xr(i,:),Yr(i,:),Zr(i,:),'r')
     hold on
    scatter3(Xl(i,:),Yl(i,:),Zl(i,:),'r')
   pause(.01)
end
