clc
clear all
format long g
%perhitungan nilai anomali gaya berat 

%mengubah soal menjadi matriks untuk mempermudah perhitungan
% nama     = ["Base" "1" "2" "3" "4" "5" "6" "7" "8" "9"...
%            "10" "11" "Base"];
g_rel     = [5659.06 5659.043 5659.016 5656.009 5659.094 5659.322...
           5659.369	5659.057 5659.074 5659.148 5659.094...
           5659.122	5659.158];
std_dev  = [0.145 0.145 0.146 0.146 0.135 0.126 0.157 0.112...
           0.159 0.192 0.355 0.154 0.155];
%waktu dikonversi dalam detik semua
waktu    = [55020 55500 55800 56100 56400 56880 57120 57480 57780 58080 58380 58740 59040];
g_abs    = 979380.989;
Height   = 12.456;
lintang  = [-32 00 11.2];
%Nilai gaya berat normal WGS 84
g_normal = 979484.4498342441;

%perhitungan nilai drift correction
for i = 1:13
    a(i)       = (waktu(1,i)  - waktu(1,1));
    b(i)       = (waktu(1,13) - waktu(1,1));
    c(i)       = (g_rel(1,13)  - g_rel(1,1));
    C_Drift(i) = -((a(i)/b(i))*c(i));
    g_Drift(i) = g_rel(1,i) + C_Drift(i);
end

%perhitungan nilai gayaberat absolut
for i = 1:13
   g_relatif_terkoreksi(i) = g_Drift(i) - g_Drift(1,1); 
end

for i = 1:12
   g_drift_abs(i) = g_abs + g_relatif_terkoreksi(i);
end

%perhitungan free air correction dan bouguer sederhana
dgf = 0.3086*Height;
dgb = 0.1119*Height;

%perhitungan nilai anomali bouguer sederhana
for i = 1:12
    delta_gb(i) = g_drift_abs(i) - g_normal + dgf - dgb;
end    
Anomali_Bouguer = [double(delta_gb');delta_gb(1,1)]
% Tabel_Hasil_Anomali_Bouguer = table(nama', Anomali_Bouguer, 'VariableNames',{'BM','Anomali_Bouguer_mGal'})



