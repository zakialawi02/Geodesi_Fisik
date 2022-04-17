clc
clear all

%perhitungan nilai anomali gaya berat 

%mengubah soal menjadi matriks untuk mempermudah perhitungan
nama     = ["Base" "1" "2" "3" "4" "5" "6" "7" "8" "9"...
           "10" "11" "Base"];
grel     = [5659.06 5659.043	5659.016 5656.009 5659.094 5659.322...
           5659.369	5659.057 5659.074 5659.148 5659.094...
           5659.122	5659.158];
std_dev  = [0.145 0.145 0.146 0.146 0.135 0.126 0.157 0.112...
           0.159 0.192 0.355 0.154 0.155];
waktu    = [55020 55500 55800 56100 56400 56880 57120 57480 57780 58080 58380 58740 59040];
g_abs    = 979380.989;
Height   = 12.456;
lintang  = [-32 00 11.2];
g_normal = 979484.4498;
g_Height = 895584.8984;
%perhitungan gayaberat relatif terhadap base
for i = 1:12
   g_relatif(i) = grel(i)-grel(1,1) ;
end

%perhitungan nilai gayaberat absolut
for i = 1:12
   g_abs(i+1) =  g_abs(i) + g_relatif(1,i);
end

%perhitungan nilai drift correction

for i = 1:13
    a(i)       = (waktu(1,i)  - waktu(1,1));
    b(i)       = (waktu(1,13) - waktu(1,1));
    c(i)       = (g_abs(1,i)  - g_abs(1,1));
    C_Drift(i) = (a(i)/b(i))*c(i);
    g_Drift(i) = g_abs(1,i) - C_Drift(i);
end

%perhitungan free air correction dan bouger sederhana
dgf = 0.3086*Height;
dgb = 0.1119*Height;

%perhitungan nilai anomali bouger sederhana
for i = 1:12
    delta_gb(i) = g_Drift(i) - g_normal + dgf - dgb;
end
format short     
Anomali_Bouger = double(delta_gb');



