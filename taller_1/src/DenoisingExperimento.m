%%

% Leo imagen de entrada
close all, clear all;
name = 'peppers';
I = imread(strcat('../Senales/256x256/', name, '.pgm'));
%figure,imshow(I),title('Imagen original');

tipo_de_ruido = 'speckle';% Opciones: 'salt&pepper', 'uniforme', 'gaussiano', 'speckle'

repeticiones = 1000;

for tipo_de_ruido = {'salt&pepper', 'uniforme', 'gaussiano', 'speckle'}
    for Lambda = 0.1:0.1:0.9
        acum_psnr = 0;
        acum_ecm = 0;
        acum_psnr_out = 0;
        acum_ecm_out = 0;
        for i = 1:repeticiones
            if strcmp(tipo_de_ruido{1},'salt&pepper')
                IR = imnoise(I,'salt & pepper');
            elseif strcmp(tipo_de_ruido{1},'uniforme')
                sr = 64; % a partir de 64 (aprox) el filtrado vale la pena
                IR = double(I) + randi([-sr,sr], size(I));
                IR = uint8(IR);
            elseif strcmp(tipo_de_ruido{1}, 'gaussiano')
                IR = imnoise(I,'gaussian');
                [p,m] = psnr(I(2:end-1,2:end-1), IR(2:end-1,2:end-1));
            elseif strcmp(tipo_de_ruido{1}, 'speckle')
                IR = imnoise(I,'speckle');
                [p,m] = psnr(I(2:end-1,2:end-1), IR(2:end-1,2:end-1));
            else
                IR = zeros(size(I));
            end
            [p,m] = psnr(I(2:end-1,2:end-1), IR(2:end-1,2:end-1));
            acum_psnr = acum_psnr + p;
            acum_ecm = acum_ecm + m;
            %figure,imshow(IR),title(['Imagen ruidosa.']);
            %imwrite(IR,strcat('../Resultados/', name, '-', tipo_de_ruido{1}, '.png'))



            % Armado del sistema
            Dim = size(IR);
            NInc = prod(Dim);
            % Armado del vector resultado
            Utilde = Lambda*double(IR(:));
            % Armado de la matriz a resolver
            B = -1*ones(NInc,5);
            B(:,3) = (Lambda+4)*ones(NInc,1);
            d = [-Dim(1) -1 0 1 Dim(1)];
            A = spdiags(B,d,NInc,NInc);
            % Resolucion directa
            Usol = A\Utilde;
            % Resolucion cholesky de matlab
            %L = chol(A,'lower');
            %Usol = L'\(L\Utilde);
            % Escalamiento y reshape para mostrar la imagen
            Usol = Usol - min(Usol);
            Usol = Usol / max(Usol);
            Usol = uint8(Usol*255);
            IFS = reshape(Usol,Dim);

            [p,m] = psnr(I(2:end-1,2:end-1), IFS(2:end-1,2:end-1));
            acum_psnr_out = acum_psnr_out + p;
            acum_ecm_out = acum_ecm_out + m;

            %figure,imshow([I,IR,IFS]),title(['Imagen filtrada, lambda=' num2str(Lambda)]);
            %imwrite(IFS,strcat('../Resultados/', name, '-out-', tipo_de_ruido{1}, '.png'))
        end

        %fprintf('Con ruido %s PSNR=%g, ECM=%g\n', tipo_de_ruido, acum_psnr/repeticiones, acum_ecm/repeticiones);
        fprintf('Lambda %g Denoised %s PSNR=%g, ECM=%g\n', Lambda, tipo_de_ruido{1}, acum_psnr_out/repeticiones, acum_ecm_out/repeticiones);
    end
end