function Lch = CholFromLU(A)
    if not(VectoresAleatorios(A, 1000))
        error('No tiene factorización de Cholesky')
    end

    % Conseguir factorizacion LU de A
    [L,U] = LUFromBlocks(A);

    % Conseguir L de cholesky a partir de LU
    Lch = L * sqrt(U * inv(L'));

    % Codigo para chequar que dio bien
    Ach = Lch*Lch';
    for i = size(A,1)
        for j = size(A,2)
            if abs(A(i,j)-Ach(i,j)) > 1e-4
                error('no iguales')
            end
        end
    end
end
