clc
disp('-------------------------------------------------------------------')
disp('      Nama                   : Rosmalisa Dwiyaniek                 ')
disp('      NRP                    : 03311740000014                      ')
disp('      Mata Kuliah            : Geodesi Fisik-A                     ')
disp(' ')
disp('------------------PERHITUNGAN ANOMALI GAYABERAT--------------------')
disp(' ')
% diketahui
lintang = [-32 0 11.2];
tinggi  = 12.456;
gabsolut= 979380.989;
grel    = [5659.060 5659.043 5659.016 5656.009 5659.094 5659.322 5659.369 5659.057 5659.074 5659.148 5659.094 5659.122 5659.158];
sd      = [0.145 0.145 0.146 0.146 0.135 0.126 0.157 0.112 0.159 0.192 0.355 0.154 0.155];
t       = [55020 55500 55800 56100 56400 56880 57120 57480 57780 58080 58380 58740 59040];
% gayaberat normal dengan elipsoid referensi WGS84
gamma0  = 979484.4498; 

disp(' ')
disp('Diketahui :')
disp(['Nilai lintang            = ',num2str(lintang),''])
disp(['Nilai tinggi             = ',num2str(tinggi),' m'])
disp(['Nilai gayaberat normal pada lintang ',num2str(lintang),'  = ',num2str(gamma0),' mGal'])
disp(['Nilai gayaberat absolut di stasiun base  = ',num2str(gabsolut),' mGal'])
disp(['Nilai gayaberat relatif setiap titik     = ',num2str(grel),' mGal'])
disp(['Nilai standar deviasi setiap titik       = ',num2str(sd),''])
disp(['Waktu saat pengambilan data setiap titik = ',num2str(t),' s'])
disp(' ')
disp('Ditanya : ')
disp('1. Berapa nilai koreksi drif?')
disp('2. Berapa nilai gayaberat absolut ?')
disp('3. Berapa nilai anomali Bouguer sederhana pada setiap titik?')
disp(' ')
disp('Jawab :')
disp('Titik 1 = base, titik 2 = stn 1, titik 3 = stn 2, titik 3 = stn 4, dan seterusnya hingga titik 13 = base ')
disp(' ')

% hitung koreksi drif
for i=1:13
    dn (i) = ((t (1,i)-t (1,1))/ (t (1,13)- t (1,1))*(grel (1,13)- grel (1,1)));
end
for i=1:13
    disp(['Nilai koreksi drif pada titik',num2str(i),' = ',num2str(dn (1,i)),''])
end
disp(' ')

% hitung gaya berat relatif setelah koreksi drif
for i=1:13
    g_relk (i) = grel(1,i)-dn (1,i);
end

% hitung gayaberat observasi
for i=1:13
    g_obser (i) = gabsolut+(g_relk(1,i)-grel(1,1));
end
for i=1:13
    disp(['Nilai gayaberat absolut pada titik ',num2str(i),' = ',num2str(g_obser (1,i)),' mGal'])
end
disp(' ')
% hitung anomali bouger sederhana
for i=1:13
    delta_gb (i) = g_obser(1,i)-gamma0+(0.3086*tinggi)-(0.1119*tinggi);
end
for i=1:13
    disp(['Nilai anomali gayaberat bouguer sederhana pada titik ',num2str(i),' = ',num2str(delta_gb (1,i)),' mGal'])
end
