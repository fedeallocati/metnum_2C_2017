function L = CholFromBlocks(A)
    % Inicializo L con ceros y Achol como auxiliar
    L = zeros(size(A,1),size(A,2));
    Achol = A;
    
    if not(VectoresAleatorios(A, 1000))
        error('No tiene factorización de Cholesky')
    end

    % Calculo todos los subbloques de L y U
    for i = 1:size(A,1)
        L11 = sqrt(Achol(i, i))
        L21 = ____
        L22xL22t = ____

        L(i,i) = L11;
        L(i+1:size(Achol,1),i) = L21;
        Achol(i+1:size(Achol,1),i+1:size(Achol,2)) = L22xL22t;
    end

    % Codigo para chequar que dio bien
    Acholesky = L*L';
    for i = size(A,1)
        for j = size(A,2)
            if abs(A(i,j)-Acholesky(i,j))>0.01
                error('no iguales')
            end
        end
    end
end