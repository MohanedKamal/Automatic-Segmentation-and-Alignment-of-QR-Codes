function R=Alignment(x,y,i,v)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here


%get 3 points for each corner 
p1=[x(1);y(1)];
p2=[x(2);y(2)];
p3=[x(3);y(3)];

%calculate the distance betwen each point
s1=sqrt(((p2(1)-p1(1))^2+(p2(2)-p1(2))^2));
s2=sqrt(((p2(1)-p3(1))^2+(p2(2)-p3(2))^2));
s3=sqrt(((p1(1)-p3(1))^2+(p1(2)-p3(2))^2));
S=sort([s1;s2;s3]);
%sort them ascendingly
th=S(2)-S(1)+10;
%calculate between new position and old one and then rotate image for
%specific angle
%th=100;


%figure('Name','Center corner'),imshow(i);
%hold on;

%locate each corner in specific location 
if abs(s1-s2)<th
%t=plot(p2(1),p2(2),'r-o');
pc=p2;
pnc1=p1;
pnc2=p3;
elseif abs(s1-s3)<th
pc=p1;
pnc1=p2;
pnc2=p3;
else
%t=plot(p3(1),p3(2),'r-o');
pc=p3;
pnc1=p1;
pnc2=p2;
end
%make a matrix for new picture which determines tfrom 
%new picture calculated from distance of old corners
new=[1 floor(S(3)) 1 ; 1 1 floor(S(3)) ;ones(1,3)];

%wraping image
old=[pc  , pnc1 ,  pnc2  ;ones(1,3)];

v=floor(v+4);
W = new * old' *(old * old')^-1;
%wrap new picture based on old one
R=imwarp(i , W , new,v);
%R = Warp(i,old,new,v);

figure('Name','final'),imshow(R);
end
