clear all
clc
format long g
disp('=== PROGRAM PERHITUNGAN TINGGI ORTHOMETRIK HELMERT ===');
disp(' ');

%% Diketahui 
    % WGS 84
    a = 6378137;
    b = 6356752.3142;
    Gamma_a = 9.7803253359;
    Gamma_b = 9.8321849378;
    W = ((7292115)*10^-11);
    GM = ((3986004.418)*10^8);
    Lintang= 45;
gama0 = (((a*Gamma_a*cosd(Lintang)*cosd(Lintang))+(b*Gamma_b*sind(Lintang)*sind(Lintang)))/(sqrt((a*a*cosd(Lintang)*cosd(Lintang))+(b*b*sind(Lintang)*sind(Lintang)))))*100000;
    
H0BM1 = 36.848;
H0BM10 = 904.507;
GBBM1 = 979627.797;
%gama0 = 980619.7769;

disp('DiKetahui: ');
disp(['Tinggi Ortometris pada BM1 = ',num2str(H0BM1),' m'])
disp(['Tinggi Ortometris pada BM10 = ',num2str(H0BM10),' m'])
disp(['Gaya Berat Absolut pada BM1 = ',num2str(GBBM1),' mGal'])
disp(['Gaya Berat Normal WGS 84 = ',num2str(gama0),' mGal'])

Grel1 = 0;      Grel6 = 143.49;
Grel2 = 23.39;  Grel7 = 176.78;
Grel3 = 55.66;  Grel8 = 203.90;
Grel4 = 89.71;  Grel9 = 234.49;
Grel5 = 113.56; Grel10 = 267.82;

dn12 = 75.787;  dn67 = 107.888;
dn23 = 104.560; dn78 = 87.886;
dn34 = 110.329; dn89 = 99.123;
dn45 = 77.295;  dn910 = 107.996;
dn56 = 96.998;
disp(' ');
%% Hitung tinggi orthometrik 
disp('== HITUNG TINGGI ORTHOMETRIK HELMRT ==')
disp('-----------------------------------------');
%disp(' ')
%disp('Step 1) Perhitungan Tinggi BM Sebelum Terkoreksi Orthometrik');
Hs1 = H0BM1;
Hs2 = Hs1+dn12;
Hs3 = Hs2+dn23;
Hs4 = Hs3+dn34;
Hs5 = Hs4+dn45;
Hs6 = Hs5+dn56;
Hs7 = Hs6+dn67;
Hs8 = Hs7+dn78;
Hs9 = Hs8+dn89;
Hs10 = Hs9+dn910;

%disp(' ');
%disp('Step 2) Perhitungan Nilai Gaya Berat Absolut pada Setiap Titik');
GBBM1 = GBBM1+Grel1;
GBBM2 = GBBM1+Grel2;
GBBM3 = GBBM2+Grel3;
GBBM4 = GBBM3+Grel4;
GBBM5 = GBBM4+Grel5;
GBBM6 = GBBM5+Grel6;
GBBM7 = GBBM6+Grel7;
GBBM8 = GBBM7+Grel8;
GBBM9 = GBBM8+Grel9;
GBBM10 = GBBM9+Grel10;

%disp(' ')
%disp('Step 3) Perhitungan Rata-Rata Gaya Berat Poincare-Prey Reduction');
GBM1 = GBBM1+(0.0424*Hs1);
GBM2 = GBBM2+(0.0424*Hs2);
GBM3 = GBBM3+(0.0424*Hs3);
GBM4 = GBBM4+(0.0424*Hs4);
GBM5 = GBBM5+(0.0424*Hs5);
GBM6 = GBBM6+(0.0424*Hs6);
GBM7 = GBBM7+(0.0424*Hs7);
GBM8 = GBBM8+(0.0424*Hs8);
GBM9 = GBBM9+(0.0424*Hs9);
GBM10 = GBBM10+(0.0424*Hs10);

%disp(' ')
%disp('Step 4) Perhitungan Gaya Berat Absolut Rata-Rata Antara 2 titik');
G12 = (GBBM1+GBBM2)/2;
G23 = (GBBM2+GBBM3)/2;
G34 = (GBBM3+GBBM4)/2;
G45 = (GBBM4+GBBM5)/2;
G56 = (GBBM5+GBBM6)/2;
G67 = (GBBM6+GBBM7)/2;
G78 = (GBBM7+GBBM8)/2;
G89 = (GBBM8+GBBM9)/2;
G910 = (GBBM9+GBBM10)/2;

%disp(' ')
%disp('Step 5) Perhitungan Koreksi Orthometrik untuk Setiap Beda Tinggi');
OC12 = (((G12-gama0)/gama0)*dn12)+(((GBM1-gama0)/gama0)*Hs1)-(((GBM2-gama0)/gama0)*Hs2);
OC23 = (((G23-gama0)/gama0)*dn23)+(((GBM2-gama0)/gama0)*Hs2)-(((GBM3-gama0)/gama0)*Hs3);
OC34 = (((G34-gama0)/gama0)*dn34)+(((GBM3-gama0)/gama0)*Hs3)-(((GBM4-gama0)/gama0)*Hs4);
OC45 = (((G45-gama0)/gama0)*dn45)+(((GBM4-gama0)/gama0)*Hs4)-(((GBM5-gama0)/gama0)*Hs5);
OC56 = (((G56-gama0)/gama0)*dn56)+(((GBM5-gama0)/gama0)*Hs5)-(((GBM6-gama0)/gama0)*Hs6);
OC67 = (((G67-gama0)/gama0)*dn67)+(((GBM6-gama0)/gama0)*Hs6)-(((GBM7-gama0)/gama0)*Hs7);
OC78 = (((G78-gama0)/gama0)*dn78)+(((GBM7-gama0)/gama0)*Hs7)-(((GBM8-gama0)/gama0)*Hs8);
OC89 = (((G89-gama0)/gama0)*dn89)+(((GBM8-gama0)/gama0)*Hs8)-(((GBM9-gama0)/gama0)*Hs9);
OC910 = (((G910-gama0)/gama0)*dn910)+(((GBM9-gama0)/gama0)*Hs9)-(((GBM10-gama0)/gama0)*Hs10);

%disp(' ')
%disp('Step 6) Perhitungan Tinggi Orthometrik Helmert untuk Setiap Titik')
disp(' ')
H2= Hs2+OC12;
H3 = Hs3+OC23;
H4 = Hs4+OC34;
H5 = Hs5+OC45;
H6 = Hs6+OC56;
H7 = Hs7+OC67;
H8 = Hs8+OC78;
H9 = Hs9+OC89;
H10 = Hs10+OC910;

disp('.. ')
disp('... ')
disp('.... ')
disp('..... ')
disp('------------------------------------------------------')
disp('Tinggi Orthometrik Helmert untuk setiap BM adalah:')
disp('------------------------------------------------------')
disp([' Tinggi Orthometrik BM1 = ',num2str(H0BM1),' m'])
disp([' Tinggi Orthometrik BM2 = ',num2str(H2),' m'])
disp([' Tinggi Orthometrik BM3 = ',num2str(H3),' m'])
disp([' Tinggi Orthometrik BM4 = ',num2str(H4),' m'])
disp([' Tinggi Orthometrik BM5 = ',num2str(H5),' m'])
disp([' Tinggi Orthometrik BM6 = ',num2str(H6),' m'])
disp([' Tinggi Orthometrik BM7 = ',num2str(H7),' m'])
disp([' Tinggi Orthometrik BM8 = ',num2str(H8),' m'])
disp([' Tinggi Orthometrik BM9 = ',num2str(H9),' m'])
disp([' Tinggi Orthometrik BM10 = ',num2str(H10),' m'])

%SELISIH
disp(' ');
disp('== SELISIH TERHADAP TINGGI ORTHOMETRIK DI BM10 ==')
disp('-----------------------------------------');
SBM10= H0BM10 - H10;
disp(['Selisih Terhadap Tinggi Orthometrik di BM10 = ',num2str(SBM10),'m'])
disp(' ');
