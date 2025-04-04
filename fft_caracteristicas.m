function [picos1_a, picos2_a,picos3_a] = fft_caracteristicas(dados)
    casos = dados{1}.dados_Freq / 2;
    p_quartil = zeros(10, casos);
    u_quartil = zeros(10, casos);
    espetro_med = zeros(10, casos);

    freq_amostragem = ((0:casos - 1) * (dados{1}.dados_Freq / casos)); 
    picos1 = zeros(50,10);
    picos2 = zeros(50,10);
    
    media_espectral_digito = zeros(10,1);

    amplitude_maxima = zeros(10, 50); % Matriz para armazenar a amplitude máxima para cada dígito e segmento
    energia_total_digito = zeros(10, 1);  % Matriz para armazenar a energia total por dígito

    for numero = 1:10
        espetro = zeros(50, casos);
        inicio = (numero - 1) * 50 + 1;
        fim = numero * 50;
        index_local = 1; 

        for j = inicio:fim
            sinal = dados{j}.dados_sinal;
            transformada = fft(sinal, casos);
            atual = abs(transformada) / casos;
            espetro(index_local, :) = atual;
            [amplitude_pico, ~] = max(atual); % Encontra a amplitude máxima
            min_idx = find(freq_amostragem >= 1500, 1, 'first');
            max_idx = find(freq_amostragem <= 2000, 1, 'last');
            espect_interval = abs(transformada(min_idx:max_idx));
            [pks,~] = findpeaks(espect_interval); 
            picos1(j - inicio + 1, numero) = length(pks);
            min_idx = find(freq_amostragem >= 6000, 1, 'first');
            max_idx = find(freq_amostragem <= 8000, 1, 'last');
            espect_interval = abs(transformada(min_idx:max_idx));
            [pks,~] = findpeaks(espect_interval); 
            picos2(j - inicio + 1, numero) = length(pks);
            min_idx = find(freq_amostragem >= 4000, 1, 'first');
            max_idx = find(freq_amostragem <= 4500, 1, 'last');
            espect_interval = abs(transformada(min_idx:max_idx));
            [pks,~] = findpeaks(espect_interval); 
            picos3(j - inicio + 1, numero) = length(pks);
            amplitude_maxima(numero, index_local) = amplitude_pico; % Armazena a amplitude máxima
            energia_total_digito(numero) = energia_total_digito(numero) + sum(atual.^2);  % Acumula a energia total para o dígito
            index_local = index_local + 1; 
        end

        espetro = espetro(1:index_local-1, :);  
        p_quartil(numero, :) = quantile(espetro, 0.25);
        u_quartil(numero, :) = quantile(espetro, 0.75);
        espetro_med(numero, :) = median(espetro, 1);
        media_espectral_digito(numero) = mean(espetro(:));  % Calcula a média de todos os espectros para o dígito
        
        % Plotar a frequência em função da FFT
        subplot(5, 2, numero);
        hold on;
        plot(freq_amostragem, espetro_med(numero, :), 'LineWidth', 2, 'Color', [0 0 1]); % Azul para a mediana
        plot(freq_amostragem, p_quartil(numero, :), 'LineWidth', 1, 'Color', [1 0.5 0]); % Laranja para o primeiro quartil
        plot(freq_amostragem, u_quartil(numero, :), 'LineWidth', 1, 'Color', [1 0.8 0]); % Amarelo para o terceiro quartil
        xlim([0, 8000]);
        xlabel('f [Hz]');
        ylabel('DFT');
        title(sprintf('%d', numero - 1));
        legend('Median', 'Q25', 'Q75');
        hold off;
    end

    sgtitle('Analise de espectro ');

    % Criar um boxplot para os picos no intervalo 1500-2000 Hz
    figure;
    boxplot(picos1, 'Labels', arrayfun(@num2str, 0:9, 'UniformOutput', false));
    xlabel('Número');
    ylabel('Picos');
    title('Boxplot dos Picos por Número (1500 a 2000 Hz)');


    figure;
    boxplot(picos2, 'Labels', arrayfun(@num2str, 0:9, 'UniformOutput', false));
    xlabel('Número');
    ylabel('Picos');
    title('Boxplot dos Picos por Número (6000 a 8000 Hz)');


    figure;
    boxplot(picos3, 'Labels', arrayfun(@num2str, 0:9, 'UniformOutput', false));
    xlabel('Número');
    ylabel('Picos');
    title('Boxplot dos Picos por Número (6000 a 8000 Hz)');

    picos1_at = picos1';
    picos1_a = reshape(picos1_at.',1,[]);
    picos2_at = picos2';
    picos2_a = reshape(picos2_at.',1,[]);
    picos3_at = picos3';
    picos3_a = reshape(picos3_at.',1,[]);
end
