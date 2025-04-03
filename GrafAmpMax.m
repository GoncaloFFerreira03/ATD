function GrafAmpMax(dados)
 % Inicializar uma matriz para armazenar os tempos até a amp min
    matriz = zeros(50, 10);
    
    % Iterar sobre os números de 0 a 9
    for numero = 1:10
        % Calcular os índices inicial e final para o número atual
        inicio = (numero - 1) * 50 + 1;
        fim = numero * 50;
        
        % Extrair o tempo ate amp min para o número atual e armazená-los na matriz
        for j = inicio:fim
            matriz(j - inicio + 1, numero) = dados{j}.dados_ampMin_tempo;
        end
    end

    % Mostrar os valores de energia em um gráfico de dispersão
    scatter(repelem(0:9, 50), matriz(:));
    
    % Atribuir o nome dos eixos e o título do gráfico
    xlabel('Número');
    ylabel('Tempo até Amp Min');
    title('Tempo Amp Min');
end