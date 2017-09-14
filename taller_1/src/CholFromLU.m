function Lch = CholFromLU(A)
    if not(VectoresAleatorios(A, 1000))
        error('No tiene factorización de Cholesky')
    end

    % Conseguir factorizacion LU de A
    [L,U,P] = lu(A)
    % lu de Matlab hace permutaciones incluso 
    % si no es necesario por estabilidad
    % La siguiente multiplicación ajusta esto
    Aperm = P*A*P;

    % Conseguir L de cholesky a partir de LU
    D = diag(diag(U))
    Lch = L * sqrt(D)

    % Codigo para chequar que dio bien
    Ach = Lch*Lch'
    for i = size(Aperm,1)
        for j = size(Aperm,2)
            if Aperm(i, j) ~= Ach(i, j)
                error('no iguales')
            end
        end
    end
end

