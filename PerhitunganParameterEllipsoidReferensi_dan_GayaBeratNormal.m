clear all
clc
format long g
disp('=== PROGRAM PERHITUNGAN PARAMETER ELLIPSOID REFERENSI DAN NILAI GAYA BERAT NORMAL ===');
disp('');

disp('Pilihan Ellipsoid Referensi : ');
disp('1) Geodetic Reference System 1967 (GRS 67)');
disp('2) Geodetic Reference System 1980 (GRS 80)');
disp('3) World Geodetic System 1984 (WGS 84)');
disp('4) Masukkan Konstanta Manual');
disp('=================================================================');
Referensi = input ('Pilih Ellipsoid Referensi (1/2/3/4): ');
disp(' ');

if Referensi == 1;
    %% konstanta dasar ellipsoid
    %% GRS 67
    disp('GRS 67');
    disp('========');
    a = 6378160;        %1/2 Sumbu Panjang
    b = 6356775;        %1/2 Sumbu Pendek
    Gamma_a = 9.780318;  %Gaya Berat Normal di Ekuator
    Gamma_b = 9.832177;  %Gaya berat Normal di Kutub
    W = ((7292115)*10^-11);    %kecepatan sudut
    GM = ((398603)*10^9);    %konstanta gravitasi

elseif Referensi == 2;
    %% GRS 80
    disp('GRS 80');
    disp('========');
    a = 6378137;
    b = 6356752.3141;
    Gamma_a = 9.7803267715;
    Gamma_b = 9.8321863685;
    W = ((7292115)*10^-11);
    GM = ((3986005)*10^8);

elseif Referensi == 3;
    %% WGS 84
    disp('WGS 84');
    disp('========');
    a = 6378137;
    b = 6356752.3142;
    Gamma_a = 9.7803253359;
    Gamma_b = 9.8321849378;
    W = ((7292115)*10^-11);
    GM = ((3986004.418)*10^8);

%% Custom
else
    disp('Masukkan nilai konstanta');
    a = input('a : ');
    b = input('b : ');
    Gamma_a = input('Gamma_a : ');
    Gamma_b = input('Gamma_b : ');
    W = input('W : ');
    GM = input('GM : ');
    
    disp (' ');
end

lintang = input('Input nilai lintang format [D M S] : ');
Lintang = dms2degrees(lintang);

disp(' ');
%% parameter ellipsoid
disp ('===Parameter Elipsoid===');
%Nilai Flattening
f = ((a-b)/a);      
disp (['flattening (f) = ' num2str(f)]);
%eksentrisitas linier
E = sqrt((a)^2-(b)^2);
disp (['eksentrisitas linier (E) = ' num2str(E)]);
%eksentrisitas pertama
e1 = sqrt(((a)^2-(b)^2)/(a)^2) ;
disp (['eksentrisitas pertama = ' num2str(e1)]);
%eksentrisitas kedua
e2 = sqrt(((a)^2-(b)^2)/(b)^2) ;
disp (['eksentrisitas kedua = ' num2str(e2)]);
%eksentrisitas kuadarat(e^2)
eak2 = ((a)^2-(b)^2)/(a)^2;     

%jari-jari lengkung meridian(p(rho))
JariJariMeridian = (a*(1-e1^2))/sqrt((1-e1^2*(sind(Lintang))^2)^3);  
disp(['jari-jari meridian (M) = ' num2str(JariJariMeridian)]);
%jari-jari lengkung utama(v)
LengkungUtama = a/(sqrt(1-e1^2*(sind(Lintang))^2));    
disp(['jari-jari lengkung utama (v) = ' num2str(LengkungUtama)]);
%parameter geodetik
m = (W^2*a^2*b)/GM;     
disp(['parameter geodetik (m) = ' num2str(m)]);


disp (' ');
%% Nilai gayaberat normal
disp ('===Nilai Gaya Berat Normal===');

Gamma = ((a*Gamma_a*cosd(Lintang)*cosd(Lintang))+(b*Gamma_b*sind(Lintang)*sind(Lintang)))/(sqrt((a*a*cosd(Lintang)*cosd(Lintang))+(b*b*sind(Lintang)*sind(Lintang))));
disp (['Nilai Gaya Berat Normal Pada Lintang [' num2str(lintang) '] = ' num2str(Gamma*100000) ' mGal']);
disp (' ');


%% Nilai gayaberat normal pada ketinggian h // Gamma(h)
PerluTinggi = input('Ingin menghitung pada ketinggian tertentu juga?? (1/0)[1=yes; 0=no]:');
disp (' ');

switch PerluTinggi
    case 1
h = input('Input nilai ketinggian (h) dalam meter = ');
disp (' ');

%m = (W^2*a^2*b)/GM;   %parameter geodetik
Gamma_h= Gamma*(1-2*(1+f+m-2*f*sind(Lintang)*sind(Lintang))*(h/a)+3*(h^2/a^2));
disp (['Nilai Gaya Berat Normal pada ketinggian ' num2str(h) ' m = ' num2str(Gamma_h*100000) ' mGal']);
disp ('==END==')

    case 0
%% END
disp ('==END==')
end




