function m = main_KNN()
  pkg load statistics;

  % Cargar los datos de entrenamiento
  X_train = cargar_en_matriz_caracterisitcas_6s_15();
  Y_train = zeros(1, 120);  % Vector de etiquetas de longitud 120 lleno de ceros
  Y_train(1:60) = 1;
  Y_train(61:end) = 0;
  sumav=0;
  sumam=0;

  k = 5;

 for j=1:15
    % Cargar datos de prueba
    filename = sprintf('C:\\Users\\pablo\\Desktop\\Trabajo Señales\\TpFinal\\Base de Datos EEG\\Pruebas\\solo_sesion3\\honest\\honest_subject%d_session1_probe_probe.txt',j,j);
    filename1 = sprintf('C:\\Users\\pablo\\Desktop\\Trabajo Señales\\TpFinal\\Base de Datos EEG\\Pruebas\\solo_sesion3\\lying\\lying_subject%d_session1_probe.txt',j,j);

    data = load(filename);
    data1 = load(filename);
    fm = 500;  % Frecuencia de muestreo
    caract = extraer_caractersiticas_NB(data, fm, 3);
    caract1 = extraer_caractersiticas_NB(data1, fm, 3);
    caract_vector = caract(:);
    X_test = caract_vector';
    caract_vector1 = caract1(:);
    X_test1 = caract_vector1';




    % Implementación manual de KNN
    y_pred = knn_predict(X_train, Y_train, X_test, k);
    if(y_pred == 0)
      disp('KNN : MENTIRA');

    else
      sumav++;
      disp('KNN : VERDAD');
    endif

       % Implementación manual de KNN
    y_pred1 = knn_predict(X_train, Y_train, X_test1, k);
    if(y_pred1 == 0)
      disp('KNN : MENTIRA');
      sumam++;
    else
      disp('KNN : VERDAD');
    endif
  endfor

  promv=(sumav/5)*100
  promm=(sumam/5)*100

  m=(promm+promv)/2


endfunction



