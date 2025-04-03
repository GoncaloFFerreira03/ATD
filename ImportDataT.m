function [dados, energia, t_amp_min, t_util] = ImportDataT()
pasta = "archive\data\01\";
ficheiros = dir(pasta);
n_ficheiros = length(ficheiros)-2;

energia = zeros(1,n_ficheiros);
t_amp_min = zeros(1,n_ficheiros);
t_util = zeros(1,n_ficheiros);

Lsinal_max = -1;

dados = cell(1,length(n_ficheiros));

for i = 3 : length(ficheiros)
    
    nome_ficheiro = strcat(pasta,ficheiros(i).name);
    

    [sinal,Freq] = audioread(nome_ficheiro);
    
    sinal_normalizado = sinal/max(abs(sinal));
    dados{i-2}.sinal_normal = sinal_normalizado;
    sinal_f = retiraSilencio(sinal_normalizado);

    if length(sinal_f) > Lsinal_max
        Lsinal_max = length(sinal_f);
    end
    dados{i-2}.dados_sinal = sinal_f;
    dados{i-2}.dados_Freq = Freq;

    %calcular a energia do digito
    Edigito = sum(sinal_f.^2);  %dividir pelo numero de amostras
    dados{i-2}.energia = Edigito;
    energia(i-2) = Edigito;
    %Tempo até atingir amp Min

    [t_amp_min,indice_minimo] = min(dados{i-2}.dados_sinal);
    tempo_amplitude_minimo = indice_minimo/Freq;

    dados{i-2}.dados_ampMin_tempo = tempo_amplitude_minimo;
    t_amp_min(i-2) = tempo_amplitude_minimo;

    %Tempo util de Audio
    dados{i-2}.dados_tempoUtil = length(sinal_f)/Freq;
    t_util(i-2) = length(sinal_f)/Freq;

    
end

for i = 1 : length(dados)
    dados{i}.dados_sinal = adicionaSilencio(dados{i}.dados_sinal, Lsinal_max);
end

