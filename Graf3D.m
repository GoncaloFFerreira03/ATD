function Graf3D(dados)
    % Inicializar uma matriz para armazenar as diferentes caracteristicas
    matrizE= zeros(50, 10);
    matrizT = zeros(50,10);
    matrizA = zeros(50,10);
    cores = lines(10);
    
    % Iterar sobre os números de 0 a 9
    for numero = 1:10
        % Calcular os índices inicial e final para o número atual
        inicio = (numero - 1) * 50 + 1;
        fim = numero * 50;
        
        % Extrair os valores das caracteristicas para o número atual e
        % armazená-los na matriz respetiva
        for j = inicio:fim
            matrizE(j - inicio + 1, numero) = dados{j}.energia;
            matrizT(j - inicio + 1, numero) = dados{j}.dados_tempoUtil;
            matrizA(j - inicio + 1, numero) = dados{j}.dados_ampMin_tempo;
        end
                
        scatter3(matrizA(:, numero), matrizE(:, numero), matrizT(:, numero), [], cores(numero, :), 'filled');
        hold on; 

    end

    % Mostrar as diferentes caracteristicas num Graf 3D
    scatter3(matrizA(:), matrizE(:),matrizT(:));
    
    % Atribuir o nome dos eixos e o título do gráfico
    xlabel('Tempo Amp Min');
    ylabel('Energia');
    zlabel('Tempo Util')
    title('Grafico 3D');

    clim([0 9]);
    colormap(cores); % Definir cores para a legenda
    colorbar; % Adicionar a legenda de cores

    hold off;
end