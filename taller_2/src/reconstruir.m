function X = reconstruir(arch_rayos)
    % Tomo los datos del archivo de rayos
    disp('Leyendo los datos de los rayos...');
    Datos = dlmread(arch_rayos);
    
    n = Datos(1,1);
    m = Datos(1,2);
    R = Datos(2:end, :);

    % resuelvo el sistema por CM
    disp('Resolviendo el sistema por cuadrados m�nimos...');
    X = resolver(R, n, m);
    
    % muestro las imagenes    
    mostrarImagen(X);
    title('Reconstrucci�n')
end

