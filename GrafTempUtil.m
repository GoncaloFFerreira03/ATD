function GrafTempUtil(dados)
    % Inicializar uma matriz para armazenar os tempos úteis
    matriz = zeros(50, 10);
    
    % Iterar sobre os números de 0 a 9
    for numero = 1:10
        % Calcular os índices inicial e final para o número atual
        inicio = (numero - 1) * 50 + 1;
        fim = numero * 50;
        
        % Extrair os valores de tempo util para o número atual e armazená-los na matriz
        for j = inicio:fim
            matriz(j - inicio + 1, numero) = dados{j}.dados_tempoUtil;
        end
    end

    % Mostrar os valores de energia em um gráfico de dispersão
    scatter(repelem(0:9, 50), matriz(:));
    
    % Atribuir o nome dos eixos e o título do gráfico
    xlabel('Número');
    ylabel('Tempo Útil');
    title('Tempo Util por Número');
end