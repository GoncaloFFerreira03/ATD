function sinalS = adicionaSilencio( sinal,tamanho_max)
    tamanho_sinal = length(sinal);
    tamanho_silencio = tamanho_max - tamanho_sinal;
    silencio = zeros(tamanho_silencio,1);
    sinalS = [sinal;silencio];
end