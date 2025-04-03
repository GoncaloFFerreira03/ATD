%cirar graficos (Ponto 2)
[dados, energia, amp_min, t_util] = ImportDataT();
[dados10, dados10_s] = importData10(dados);

%figure();
%for num = 1 : 10
    %criaGraf(dados10{num},num-1) 
%end

%figure();
%GrafEnergia(dados)

%figure();
%GrafAmpMax(dados);

%figure();
%GrafTempUtil(dados);

%figure();
%Graf3D(dados);

figure();
[picos1, picos2,picos3] = fft_caracteristicas(dados);

%figure();
%janelas(dados, 'hamming');

%figure();
%janelas(dados,'hanning');

%figure();
%janelas(dados,'blackman');

figure();
[plot_esp, centr, pmax, ipmax, ro, flat,rollof,rolloff] = STFT(dados,dados10_s);



[numeros, indices] = distNum(dados, picos3, amp_min, t_util, centr, picos1, picos2 , ro, flat);

