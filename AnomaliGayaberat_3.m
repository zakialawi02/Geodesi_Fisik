clc
clear all

g_rel = [5659.060 5659.043 5659.016 5659.009 5659.094 5659.322 5659.369 5659.057 5659.074 5659.148 5659.094 5659.122 5659.158];
std = [0.145 0.145 0.146 0.146 0.135 0.126 0.157 0.112 0.159 0.192 0.355 0.154 0.145];
t = [55020 55500 55800 56100 56400 56880 57120 57480 57780 58080 58380 58740 59040];
g_base = 979380.989
H=12.456;
lintang =[-32 0 11.2];
lat = dms2degrees(lintang);
a   = 6378137;
b   = 6356752.3142;
GM = ((3986004.418)*10^8);
GamaA  = 9.7803253359;
GamaB  = 9.8321849378;
%Gaya Berat Normal
gama= 10^5*((a*GamaA*cosd(lat)*cosd(lat))+(b*GamaB*sind(lat)*sind(lat)))/(sqrt((a*a*cosd(lat)*cosd(lat))+(b*b*sind(lat)*sind(lat))))

% koreksi drift
for i= 1:13
    drift (i) =((g_rel(1,13)-g_rel(1,1))/(t(1,13)-t(1,1)))*(t(1,(i))-t(1,1))
end

%g_obs
for i=1:12
    g_obs (i) = g_rel(1,i)-drift(1,i)
end

%Gaya Berat
for i=1:12
    g (i) = g_base+(g_obs(1,i)-g_obs(1,1))
end

%Anomali Bouger Sederhana
for i =1:12
    gb (i) = g(1,i)-gama+(0.3086*H)-(0.1119*H)
end
disp (['Nilai Anomali Bouger Sederhana pada Stasiun Base sebesar  : ' num2str(gb(1,1)) 'mGal'])
for i=1:11
    disp (['Nilai Anomali Bouger Sederhana pada Stasiun ' num2str(i) ' sebesar  : ' num2str(gb(1,(1+i))) 'mGal'])
end