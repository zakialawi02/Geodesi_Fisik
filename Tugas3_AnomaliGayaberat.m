clc
clear all
format long g
disp('================ PERHITUNGAN ANOMALI GAYABERAT REELATIF ================');
disp(' ');
%% Diketahui
disp('Diketahui:');
lintang = [-32 0 11.2]; 
Tinggi = 12.456;
GAbsolut = 979380.989;
Grell = [5659.060 5659.043 5659.016 5656.009 5659.094 5659.322 5659.369 5659.057 5659.074 5659.148 5659.094 5659.122 5659.158];
sd = [0.145 0.145 0.146 0.146 0.135 0.126 0.157 0.112 0.159 0.192 0.355 0.154 0.155]; %standar deviasi
t = [55020 55500 55800 56100 56400 56880 57120 57480 57780 58080 58380 58740 59040]; %time(dalam detik)
% mencari nilai diketahui
Lintang = dms2degrees(lintang);
 % WGS 84
    a = 6378137;
    b = 6356752.3142;
    Gamma_a = 9.7803253359;
    Gamma_b = 9.8321849378;
    W = ((7292115)*10^-11);
    GM = ((3986004.418)*10^8);
    f = ((a-b)/a);
    Gamma0 = ((a*Gamma_a*cosd(Lintang)*cosd(Lintang))+(b*Gamma_b*sind(Lintang)*sind(Lintang)))/(sqrt((a*a*cosd(Lintang)*cosd(Lintang))+(b*b*sind(Lintang)*sind(Lintang))));
%     m = (W^2*a^2*b)/GM;
%     Gamma0 = Gamma0*(1-2*(1+f+m-2*f*sind(Lintang)*sind(Lintang))*(Tinggi/a)+3*(Tinggi^2/a^2));
    Gamma0 = Gamma0 * 100000;

[C,R] = size(Grell);

disp(['Nilai Lintang = ',num2str(Lintang)])
disp(['Nilai Tinggi = ',num2str(Tinggi),' m'])
disp(['Nilai Gayaberat Normal pada lintang ',num2str(Lintang),' [WGS 84] = ',num2str(Gamma0),' mGal'])
disp(['Nilai Gayaberat Sbsolut di stasiun base = ',num2str(GAbsolut),' mGal'])
disp(['Nilai Gayaberat Relatif setiap titik = ',num2str(Grell),' mGal'])
disp(['Nilai Standar deviasi setiap titik = ',num2str(sd),''])
disp(['Waktu saat pengambilan data setiap titik (second) = ',num2str(t),' s'])
disp(' ');

%% Hitung koreksi drif
for i=1:R
    dn(i) = ((t(1,i) - t(1,1)) / (t(1,R) - t(1,1))*(Grell(1,R) - Grell(1,1)));
    Gdrift(i) = Grell(1,i) - dn(i); %nilai terkoreksi
end

%% Hitung gayaberat observasi
for i=1:R
    g_obs(i) = GAbsolut + (Gdrift(1,i) - Grell(1,1));
end

%% perhitungan nilai anomali bouger sederhana
% hitung anomali bouger sederhana
gF= (0.3086*Tinggi); %koreksi free-air
gB= (0.1119*Tinggi); % Koreksi boueger
for i=1:R
    Delta_gb(i) = g_obs(i) - Gamma0 + gF - gB;
end
disp('========================================');
disp('Nilai Anomali Gaya Berat (Anomali Bougher Sederhana) pada setiap titik adalah :');
for i=1:(R-1)
    disp(['Titik ',num2str(i-1),' = ',num2str(Delta_gb (1,i)),' mGal'])
end

%% Tabel
g_obs(:,R) = [];
Delta_gb(:,R) = [];
dn(:,R) = [];
Gdrift(:,R) = [];
AnomaliGayaberat=Delta_gb';
KoreksiDrift=dn';
DriftTerkoreksi=Gdrift';
STN=0:(R-2);STN=STN';
gObservasi=g_obs';
Hasil= table(STN,gObservasi,KoreksiDrift,DriftTerkoreksi,AnomaliGayaberat)


