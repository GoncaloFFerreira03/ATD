function [plot_esp, centr, pmax, ipmax, ro, flat,ro_t, rolloff] = STFT(dadost,dados)
    %k = (j)*50 + 1;
    plot_esp = cell(1,10);
    centroide = zeros(50,10);
    idxPicoMax = zeros(50,10);
    picoMax = zeros(50,10);
    rolloff = zeros(50,10);
    flatness = zeros(50,10); % Adiciona uma matriz para armazenar os valores de flatness

    for num = 1 : 10
        % Extrair os valores de tempo util para o número atual e armazená-los na matriz
        inicio = (num - 1) * 50 + 1;
        fim = num * 50;
        for j = inicio:fim
            w_size = 256;
            novlap = 128; 
            nfft = 256;

            freq = dadost{j}.dados_Freq;
            sinal = dadost{j}.dados_sinal;

            window = hamming(w_size);

            [S, f, t] = spectrogram(sinal, window, novlap, nfft, freq);

            % Calcula o espectro de amplitude para frequências positivas
            A_hamming = abs(S(1:w_size/2+1,:));

            % Normalizar o espectro de amplitude pelo número de amostras
            A_hamming = A_hamming/w_size;

            % Calcula o centroide espectral
            r = sum(f.*abs(S))/sum(abs(S));
            centroide(j - inicio + 1, num) = r;

            % Encontra pico máximo e índice do pico
            [picoM, idxPicoM] = max(abs(S(:)));
            picoMax(j - inicio + 1, num) = picoM;
            idxPicoMax(j - inicio + 1, num) = idxPicoM;

            % Calcula o rolloff
            cumulative_energy = 0;
            threshold_energy = 0.85 * sum(A_hamming.^2);
            for m = 1:length(f)
                cumulative_energy = cumulative_energy + A_hamming(m,:).^2;
                if cumulative_energy >= threshold_energy
                    rolloff(j - inicio + 1, num) = f(m);
                    break;
                end
            end

            % Calcula a flatness
            geometric_mean = exp(mean(log(A_hamming + eps))); % Adiciona eps para evitar log(0)
            arithmetic_mean = mean(A_hamming);
            flatness(j - inicio + 1, num) = geometric_mean / arithmetic_mean;

            if j == inicio
                freq = dados{num}.dados_Freq;
                sinal = dados{num}.dados_sinal;
                [S, f, t] = spectrogram(sinal, window, novlap, nfft, freq);

                % Calcula o espectro de amplitude para frequências positivas
                A_hamming = abs(S(1:w_size/2+1,:));

                % Normaliza o espectro de amplitude pelo número de amostras
                A_hamming = A_hamming/w_size;
                subplot(5,2,num);
                plot_esp{num}.S = S;
                plot_esp{num}.f = f;
                plot_esp{num}.t = t;

                imagesc(t*1000, f/1000, 20*log10(abs(A_hamming)));
                axis xy;
                xlabel('Tempo (ms)');
                ylabel('Frequência (KHz)');
                title(num2str(num - 1))
                colorbar;
            end
        end
    end

    % Plotar os box plots das características calculadas
    figure;
    boxplot(centroide, 0:9)
    xlabel('Número de dados');
    ylabel('Centroide Espectral (Hz)');
    title('Box plot dos Centroides Espectrais');

    figure;
    boxplot(picoMax, 0:9)
    xlabel('Número de dados');
    ylabel('Pico Máximo (Amplitude)');
    title('Box plot dos Picos Máximos');

    figure;
    boxplot(idxPicoMax, 0:9)
    xlabel('Número de dados');
    ylabel('Pico Máximo (Índice)');
    title('Box plot dos Picos Máximos');

    figure;
    boxplot(rolloff, 0:9)
    xlabel('Número de dados');
    ylabel('Rolloff Espectral (Hz)');
    title('Box plot dos Rolloffs Espectrais');

    figure;
    boxplot(flatness, 0:9)
    xlabel('Número de dados');
    ylabel('Flatness Espectral');
    title('Box plot da Flatness Espectral');
    
    centr_t = centroide';
    centr = reshape(centr_t.',1,[]);
    pmax_t = picoMax';
    pmax = reshape(pmax_t.',1,[]);
    ipmax_t = idxPicoMax';
    ipmax = reshape(ipmax_t.',1,[]);
    ro_t = rolloff';
    ro = reshape(ro_t.',1,[]);
    flat_t = flatness';
    flat = reshape(flat_t.',1,[]);

    figure;
    hold on;
    for num = 1:10
        scatter3(centroide(:, num), flatness(:, num), rolloff(:, num), 'filled')
    end
    hold off;
    xlabel('Centroide Espectral');
    ylabel('Flatness Espectral');
    zlabel('');
    title('Gráfico 3D das características espectrais');
    legend(arrayfun(@(x) ['Dígito ', num2str(x)], 0:9, 'UniformOutput', false));
    grid on;
    view(3); 
end