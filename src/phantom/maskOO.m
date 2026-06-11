% >---------------------------------------------------------------------< %
% Mask Circles
% Esteban Denecken C.
% >---------------------------------------------------------------------< %
% Function that creates a set of 2D masks made of circles
% Input
%    dim : Dimension of the masks (square images)
% Output
%    Ms  : Set of 17 masks arranged in a 3D tensor
% >---------------------------------------------------------------------< %

% Masks
function Ms = maskOO(dim)
% Circles : circle(rad,Cx,Cy,dim)
Ms = zeros(dim,dim,17);
C = circle(0.45,0.5,0.5,dim);

dc = 0.07;
A = 0.15;
th = 2*pi/5;
co = 2; ox1  = circle(dc,0.5+A*cos(co*th),0.5+A*sin(co*th),dim);
co = 3; ox13 = circle(dc,0.5+A*cos(co*th),0.5+A*sin(co*th),dim);

co = 4; ox14 = circle(dc,0.5+A*cos(co*th),0.5+A*sin(co*th),dim);
co = 1; ox15 = circle(dc,0.5+A*cos(co*th),0.5+A*sin(co*th),dim);
co = 5; ox16 = circle(dc,0.5+A*cos(co*th),0.5+A*sin(co*th),dim);

dc = 0.07;
A = 0.34;
th = 2*pi/11;
co = 5; ox2  = circle(dc,0.5+A*cos(co*th),0.5+A*sin(co*th),dim);
co = 4; ox3  = circle(dc,0.5+A*cos(co*th),0.5+A*sin(co*th),dim);
co = 3; ox4  = circle(dc,0.5+A*cos(co*th),0.5+A*sin(co*th),dim);
co = 2; ox5  = circle(dc,0.5+A*cos(co*th),0.5+A*sin(co*th),dim);
co = 1; ox6  = circle(dc,0.5+A*cos(co*th),0.5+A*sin(co*th),dim);
co = 11; ox7 = circle(dc,0.5+A*cos(co*th),0.5+A*sin(co*th),dim);
co = 10; ox8 = circle(dc,0.5+A*cos(co*th),0.5+A*sin(co*th),dim);
co = 9; ox9  = circle(dc,0.5+A*cos(co*th),0.5+A*sin(co*th),dim);
co = 8; ox10 = circle(dc,0.5+A*cos(co*th),0.5+A*sin(co*th),dim);
co = 7; ox11 = circle(dc,0.5+A*cos(co*th),0.5+A*sin(co*th),dim);
co = 6; ox12 = circle(dc,0.5+A*cos(co*th),0.5+A*sin(co*th),dim);

CC = ox1+ox2+ox3+ox4+ox5+ox6+ox7+ox8+ ...
	ox9+ox10+ox11+ox12+ox13+ox14+ox15+ox16;

Ms(:,:,1) = ox1;   Ms(:,:,2) = ox2;   Ms(:,:,3) = ox3;
Ms(:,:,4) = ox4;   Ms(:,:,5) = ox5;   Ms(:,:,6) = ox6;
Ms(:,:,7) = ox7;   Ms(:,:,8) = ox8;   Ms(:,:,9) = ox9;
Ms(:,:,10) = ox10; Ms(:,:,11) = ox11; Ms(:,:,12) = ox12;
Ms(:,:,13) = ox13; Ms(:,:,14) = ox14; Ms(:,:,15) = ox15;
Ms(:,:,16) = ox16;
Ms(:,:,17) = C - CC;
end

% Circle
function Ox = circle(rad,Cx,Cy,dim)
Ox = zeros(dim);
rad = dim * rad;
Cx = dim * Cx;
Cy = dim * Cy;
for rd = 0:0.2:rad
    for th = 0:pi/1000:2*pi
        xu = round(rd * cos(th) + Cx);
        yu = round(rd * sin(th) + Cy);
        Ox(xu,yu) = 1;
    end
end
end


% >---------------------------------------------------------------------< %
