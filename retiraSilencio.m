function sinalS = retiraSilencio(sinal)
    energia = (sinal.^2);
    limiar = 0.005 * max(energia);
    primeiro_t = find(energia > limiar,1, 'first'); 
    ulimo_t = find(energia > limiar,1, 'last');
    sinalS = sinal(primeiro_t:ulimo_t);

end