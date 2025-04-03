function criaGraf(dados,num)
duracao = length(dados.dados_sinal)/dados.dados_Freq; %Calcular duracao do ficheiro

tempo = linspace(0,duracao,length(dados.dados_sinal)); %criar um vetor de tempo com o mesmo numero de elementos que o vetor de amostras

subplot(5,2,num+1);
plot(tempo, dados.dados_sinal);
title(num2str(num));
xlabel('Tempo (s)');
ylabel('Amplitude');
end