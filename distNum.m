function [numeros, array, percentagem_acerto] = distNum(dados, picos3, picosMax, idxpicosMAx, centr, picos1, picos2, ro, flat)
    naudios = length(dados);
    numeros = zeros(1, naudios);
    
    for i = 1:naudios
        picos3I = picos3(i);
        %t_utilI = t_util(i);
        centrI = centr(i);
        picos1I = picos1(i);
        picos2I = picos2(i);
        picosMaxI = picosMax(i);
        idxpicosMaxI = idxpicosMAx(i);
        roI = ro(i);
        flatI = flat(i);
        
        % Picos por Número (1500 a 2000 Hz) + Picos Máximos (Amplitude)
        %disp(roI);
        if roI >= 750 && roI <= 2250 && centrI >= 1043 && centrI <= 1418
            numeros(i) = 1; % Default para quando nenhuma condição é satisfeita
        elseif roI >= 3937 && roI <= 11250
            numeros(i) = 2;
        elseif idxpicosMaxI >= 7227 && idxpicosMaxI <= 18965
            numeros(i) = 3;
        elseif picos1I >= 74 && picos1I <= 97 && centrI >= 1231 && centrI <= 3078 && roI >= 11250 && 17437 <= roI
            numeros(i) = 4;
        elseif picos1I >= 46 && picos1I <= 80 && picos2I >= 155 && 353 <= picos2I && centrI >= 1555 && centrI <= 2861 && picosMaxI >= 28 && picosMaxI <= 44 && idxpicosMaxI >= 4648 && idxpicosMaxI <= 15223
            numeros(i) = 5;
        elseif centrI >= 3110 && centrI <= 5776 && flatI >= 0.16697 && flatI <= 0.32332
            numeros(i) = 6;
        elseif picos2I >= 112 && 177 <= picos2I && picos1I >= 43 && 74 <= picos1I
            numeros(i) = 7;
        elseif picos2I >= 269 && picos2I <= 389 && roI >= 4125 && roI <= 9562 && picos3I >= 64 && picos
            numeros(i) = 8;
        elseif centrI >= 1274 && centrI <= 1771 && roI >= 937 && roI <= 3937 
            numeros(i) = 9;
        else
            numeros(i) = 0;
        end
      
    end


    % Inicializar um array vazio
    array = [];
    
    % Adicionar cinquenta ocorrências de cada número de 0 a 9
    for num = 0:9
        array = [array repmat(num, 1, 50)];
    end
    
    % Calcular a percentagem de acerto para cada dígito
    a = 0;
    percentagem_acerto = zeros(1, 10);
    for num = 1:length(array)
        if array(num) == numeros(num)
            a = a + 1 ;
        end
    end
    
    a = (a/500) * 100;
    disp(a);
end