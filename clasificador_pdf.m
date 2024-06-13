function m = clasificador_pdf()
    filename = 'C:\\Users\\pablo\\Desktop\\Trabajo Señales\\TpFinal\\Base de Datos EEG\\Pruebas\\solo_sesion3\\lying\\lying_subject7_session3_probe.txt';
    data = load(filename);
    fm = 500;  % Frecuencia de muestreo
    caract = extraer_caractersiticas(data, fm, 3);
    caract_vector = caract(:);
    v = caract_vector

    %---------------------------------------------------------------------------------------
    param = [16.497, 21.145, 25.238;  % Total
             6.112, 6.529, 7.210;    % High Alpha
             15.201, 20.535, 25.807; % Beta
             26.685, 28.983, 36.108; % Mbeta
             8.070, 8.354, 9.196];   % Gamma

    datos = zeros(5, 3);   % Verdad, Posible Mentira, Mentira

    %------------------------------------------------------------------------------
    for i = 1:5
        %--------------------Verdad----------------------------------
        if (v(i) <= param(i, 1) && v(i) > 0)
            datos(i, 1) = 1;
        elseif (v(i) > param(i, 1) && v(i) <= param(i, 2))
            datos(i, 1) = (v(i) - param(i, 1)) / (param(i, 2) - param(i, 1));
        elseif (v(i) > param(i, 3))
            datos(i, 1) = 0;
        else
            datos(i, 1) = 0;
        end

        %--------------------Posible Mentira----------------------------
        if (v(i) <= param(i, 1))
            datos(i, 2) = 0;
        elseif (v(i) > param(i, 1) && v(i) <= param(i, 2))
            datos(i, 2) = (v(i) - param(i, 1)) / (param(i, 2) - param(i, 1));
        elseif (v(i) > param(i, 2) && v(i) <= param(i, 3))
            datos(i, 2) = (param(i, 3) - v(i)) / (param(i, 3) - param(i, 2));
        else
            datos(i, 2) = 0;
        end

        %--------------------Mentira-----------------------------------
        if (v(i) < param(i, 2))
            datos(i, 3) = 0;
        elseif (v(i) >= param(i, 2) && v(i) <= param(i, 3))
            datos(i, 3) = (v(i) - param(i, 2)) / (param(i, 3) - param(i, 2));
        elseif (v(i) > param(i, 3))
            datos(i, 3) = 1;
        else
            datos(i, 3) = 0;
        end
    end

    datos
    Promedio_verdad = sum(datos(:, 1)) / 5;
    Promedio_posible_mentira = sum(datos(:, 2)) / 5;
    Promedio_mentira = sum(datos(:, 3)) / 5;

    m = [Promedio_verdad, Promedio_posible_mentira, Promedio_mentira];
end

