function janelas(dados,window)
    casos = dados{1}.dados_Freq / 2;
    p_quartil = zeros(10, casos);
    u_quartil = zeros(10, casos);
    espetro_med = zeros(10, casos);
    
    freq_amostragem = ((0:casos - 1) * (dados{1}.dados_Freq / casos));

    for numero = 1:10
        espetro = zeros(50, casos);
        inicio = (numero - 1) * 50 + 1;
        fim = numero * 50;
        index_local = 1; 
        
        for j = inicio:fim
            sinal = dados{j}.dados_sinal;
            if strcmp(window, "hamming")
                janela = hamming(length(sinal));
            elseif strcmp(window, "hanning")
                janela = hann(length(sinal));
            elseif strcmp(window, "blackman")
                janela = blackman(length(sinal));
            end
            transformada = fft(sinal.*janela, casos);
            espetro(index_local, :) = abs(transformada) / casos;
            index_local = index_local + 1; 
            
        end


        espetro = espetro(1:index_local-1, :);
        p_quartil(numero, :) = quantile(espetro, 0.25);
        u_quartil(numero, :) = quantile(espetro, 0.75);
        espetro_med(numero, :) = median(espetro, 1); 

       % Plotar a frequência em função da FFT
        subplot(5, 2, numero);
        hold on;
        plot(freq_amostragem, espetro_med(numero, :), 'LineWidth', 2, 'Color', [0 0 1]); % Azul para a mediana
        plot(freq_amostragem, p_quartil(numero, :), 'LineWidth', 1, 'Color', [1 0.5 0]); % Laranja para o primeiro quartil
        plot(freq_amostragem, u_quartil(numero, :), 'LineWidth', 1, 'Color', [1 0.8 0]); % Amarelo para o terceiro quartil
        xlim([0, 8000]);
        xlabel('f [Hz]');
        ylabel('DFT');
        title(sprintf('%d', numero - 1))
        legend('Median', 'Q25', 'Q75');
        hold off;

    end
    sgtitle(sprintf('Análise de espectro (janela de %s)', window));
end



