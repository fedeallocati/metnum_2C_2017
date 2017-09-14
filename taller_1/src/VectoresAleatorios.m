function respuesta = VectoresAleatorios(A, n)
    respuesta = true; % Simbolizando que hay confianza en que es SDP
    % Generar n vectores aleatorios y verificar condicion
    for i = 1:n
        vector_aleatorio = randn(size(A, 1), 1); % Completar con la dimension que debe tener
        sigma_2 = vector_aleatorio' * A * vector_aleatorio;
        if sigma_2 < 0 % Completar con la condicion
            respuesta = false;
        end
    end
end

