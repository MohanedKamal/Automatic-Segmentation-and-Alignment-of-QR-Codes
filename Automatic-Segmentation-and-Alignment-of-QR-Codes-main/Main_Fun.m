function [R F]=Main_Fun(I)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

F=1;
R=0;
I_=I;
VV=[];
[H W L]=size(I);
% convert image to gray
I=rgb2gray(I);
%apply median filter 
I = medfilt2(I, [3 3]);
figure('Name','med filter'),imshow(I);
Sampel=20;
%Local therholding
for i = 1 : (H/Sampel)
for j = 1 : (W/Sampel)
%loop in each block of size 20
i1=i*Sampel;
j1=j*Sampel;
%x=block 
x=I(i1-Sampel+1:i1,j1-Sampel+1:j1);
min_=min(x(:));
x1=sort(x(:));
max_=max(x1(:));


%get value of thresholding 
Threshold=min_+(max_-min_)/1.5; 
% we used local thresholding because of the high illmunation 
% we divide the pic to blocks 
if max_-min_>50
%aplly thresholding    
Z=I(i1-Sampel+1:i1,j1-Sampel+1:j1)>Threshold;
I(i1-Sampel+1:i1,j1-Sampel+1:j1)=Z*255;
end

end

end
%convert image to binary
I=im2bw(I,0.5);

%figure('Name','Morpholgical '),imshow(I);
hold on;
%get connected comm
All_Conected = bwconncomp(I);
%maximum commponent
numPixels = cellfun(@numel,All_Conected.PixelIdxList);
%size of maximum component
N=size(numPixels,2);
x=[];
y=[];
%loop in mximum comm
for i=1:N
if numPixels(i)>50 
%get hight and width of conn comm
[X,Y] = ind2sub(size(I),All_Conected.PixelIdxList{i});

minx=min(X);
miny=min(Y);

maxx=max(X);
maxy=max(Y);

H=maxx-minx;
W=maxy-miny;

Z=I(minx:maxx,miny:maxy);
D2=Check_Black_Square_In_Center(Z,W,H);
if D2==1 
[v ,D3]=Check_Black_Border(I,Z,minx,maxx,miny,maxy,W,H);
if D3==1
plot(round((maxy+miny)/2),round((maxx+minx)/2),'r-o');
V=v;
VV=[VV ; V];
x=[x;round((maxy+miny)/2)];
y=[y;round((maxx+minx)/2)];
end

end
end
end


if size(x,1)<3
F=0;
elseif size(x,1)==3
R=Alignment(x,y,I_,V);

else
Multi_Qrs(I_,x,y,VV);
    
end