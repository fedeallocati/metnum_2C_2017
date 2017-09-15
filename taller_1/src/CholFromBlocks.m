function L = CholFromBlocks(A)
    % Inicializo L con ceros y Achol como auxiliar
    N = size(A,1);
    L = zeros(N,N);
    Achol = A;

    if not(VectoresAleatorios(A, 1000))
        error('No tiene factorización de Cholesky')
    end

    % Calculo todos los subbloques de L y U
    for i = 1:N
        L11 = sqrt(Achol(i,i));
        L21 = Achol(i,i+1:N)/L11;
        L22xL22t = Achol(i+1:N,i+1:N) - (L21' * L21);

        L(i,i) = L11;
        L(i+1:N,i) = L21;
        Achol(i+1:N,i+1:N) = L22xL22t;
    end

    % Codigo para chequar que dio bien
    Acholesky = L * L';
    for i = N
        for j = N
            if abs(A(i,j)-Acholesky(i,j))>0.01
                error('no iguales')
            end
        end
    end
end