    function GrafEnergia(dados)
    % Inicializar uma matriz para armazenar as energias (50 linhas, 10
    % colunas)
    matriz_energia = zeros(50, 10);
    
    % Iterar sobre os números de 0 a 9
    for numero = 1:10
        % Calcular os índices inicial e final para o número atual
        inicio = (numero - 1) * 50 + 1;
        fim = numero * 50;
        
        % Extrair os valores de energia para o número atual e armazená-los na matriz
        for j = inicio:fim
            matriz_energia(j - inicio + 1, numero) = dados{j}.energia;
        end
    end

    % Mostrar os valores de energia em um gráfico de dispersão
    scatter(repelem(0:9, 50), matriz_energia(:));
    
    % Atribuir os nomes dos eixos e o título do gráfico
    xlabel('Número');
    ylabel('Energia');
    title('Energia por Numero');
end