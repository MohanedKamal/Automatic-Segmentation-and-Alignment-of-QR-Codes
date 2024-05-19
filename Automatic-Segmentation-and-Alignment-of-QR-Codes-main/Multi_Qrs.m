function R = Multi_Qrs( I_,x,y,VV )
QRs=size(x,1);

for i=1:QRs
%for in each point x in i
miny=10000000000000000000;
flag=0;
%check btween point 1 and point 2
for j=1:QRs
%for each point in x not eqaul in x in i 
if i~=j  &&  x(j)~=-1
p1=[x(i);y(i)];
p2=[x(j);y(j)];
s1 = sqrt(((p2(1)-p1(1))^2+(p2(2)-p1(2))^2));
%check btween point 2 and 3 
%check between points 1 and 3 
for ij=1:QRs
%check for point 3 not equal x1 and x2  in i  
if ij~=i  &&  x(ij)~=-1

p3=[x(ij);y(ij)];
s2 = sqrt(((p3(1)-p1(1))^2+(p3(2)-p1(2))^2));
% get distance between the first point and the third point 
s3 = sqrt(((p3(1)-p2(1))^2+(p3(2)-p2(2))^2));
% get distance between the second point and the third point 
if abs(s1-s2)<40 && abs((s1^2+s2^2)-s3^2)<500
% side + sdie sqrt = hypo
if s1<miny
P=[p1' ; p2'  ; p3' ];
% get the three points 
miny=s1;
I=i;
J=j;
IJ=ij;
flag=1;
end
end
end
end
end
end

if flag==1
% crop image then alignment 
R=Alignment(P(:,1),P(:,2),I_,VV(I));
x(I)=-1;
x(J)=-1;
x(IJ)=-1;
end

end

end



