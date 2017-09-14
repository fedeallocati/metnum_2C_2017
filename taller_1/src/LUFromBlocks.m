function [L,U] = LUFromBlocks(A)
    % Inicializo L y U con ceros y Alu como auxiliar
    M = size(A,1)
    N = size(A,2)
    L = zeros(size(A,1),size(A,2));
    U = zeros(size(A,1),size(A,2));
    Alu = A;

    if not(CheckCondLU(A))
        error('No tiene LU')
    end
    
    % Calculo todos los subbloques de L y U
    for i = 1:size(A,1)
        L11 = 1;
        U11 = Alu(i, i);
        L21 = Alu(i+1:M, i) / U11; % M - i + 1
        U12 = Alu(i, i+1:N);  % 
        
        LU22 = Alu(i+1:M, i+1:N) - (L21 * U12); % Representa a L22*U22

        L(i,i) = L11;
        U(i,i) = U11;
        U(i,i+1:N) = U12;
        L(i+1:M,i) = L21;

        Alu(i+1:M,i+1:N) = LU22;
    end
    % Seteo del ultimo elemento en la diagonal de L
    L(size(A,1),size(A,2)) = 1;
    
    % Codigo para chequar que dio bien
    Alu = L*U;
    for i = size(A,1)
        for j = size(A,2)
            if abs(A(i,j)-Alu(i,j))>0.01
                error('no iguales')
            end
        end
    end
end

