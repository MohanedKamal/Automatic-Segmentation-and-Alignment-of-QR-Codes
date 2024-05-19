function [v , D] = Check_Black_Border(I,Z,minx,maxx,miny,maxy,W,H)

D=0;
v=0;
% invet image 
Z=imcomplement(Z);
% get connected comm
C=bwconncomp(Z,8);
%check for maximum comm
numPixels1 = cellfun(@numel,C.PixelIdxList) ;

if size(numPixels1)==1
%imfill area around white border to white 
%make black border black
Temp= imfill(logical(I),[maxx maxy],8);
else
%numPixels1=sort(numPixels1);
[X ,Y ] = ind2sub(size(Z),C.PixelIdxList{2});
Temp= imfill(logical(I),[minx+X(1)-1 miny+Y(1)-1],8);
end
%subtract old border from new border to get only border
XY=imsubtract(Temp,I);
%get hight and width from border
Conected_for_Black_border = bwconncomp(XY,4);

numPixels1 = cellfun(@numel,Conected_for_Black_border.PixelIdxList);

[biggest,idx] = max(numPixels1);

if size(numPixels1,2)>0  && biggest >50

[X_for_corner,Y_for_corner] = ind2sub(size(XY),Conected_for_Black_border.PixelIdxList{idx});

minx_for_corner=min(X_for_corner);
miny_for_corner=min(Y_for_corner);

maxx_for_corner=max(X_for_corner);
maxy_for_corner=max(Y_for_corner);

H_for_corner=maxx_for_corner-minx_for_corner;
W_for_corner=maxy_for_corner-miny_for_corner;

%check for same center
dis_x=(W/2-W_for_corner/2)^2;
dis_y=(H/2-H_for_corner/2)^2;
dis=sqrt(dis_x+dis_y);
%check is square or not 
if dis<25
%return cnter of square 
v=H_for_corner/2;

if abs(H_for_corner-W_for_corner)<25
    D=1;
else
    D=0;
end
end

end

end
