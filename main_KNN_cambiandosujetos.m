function m = main_KNN()
  pkg load statistics;

  % Cargar los datos de entrenamiento
  X_train = cargar_en_matriz_caracterisitcas_6s_15();
  Y_train = zeros(1, 140);  % Vector de etiquetas de longitud 120 lleno de ceros
  Y_train(1:70) = 1;
  Y_train(71:end) = 0;
  sumav=0;
  sumam=0;
  k = 3;

  for i = 1:5
    % Cargar datos de prueba                                                                                                     #lying
    filename = sprintf('C:\\Ingenieria Informatica\\4to año\\Proc de Señales\\TpFinal\\Base de Datos EEG\\Pruebas\\solo_sesion%d\\honest\\honest_subject15_session%d_probe.txt',i,i);
    filename1 = sprintf('C:\\Ingenieria Informatica\\4to año\\Proc de Señales\\TpFinal\\Base de Datos EEG\\Pruebas\\solo_sesion%d\\lying\\lying_subject15_session%d_probe.txt', i,i);
    data = load(filename);
    data1 = load(filename1);
    fm = 500;  % Frecuencia de muestreo
    caract = extraer_caractersiticas_NB(data, fm, 3);
    caract1 = extraer_caractersiticas_NB(data1, fm, 3);
    caract_vector = caract(:);
    X_test = caract_vector';
    caract_vector1 = caract1(:);
    X_test1 = caract_vector1';
    % Implementación manual de KNN
    y_pred = knn_predict(X_train, Y_train, X_test, k);
    disp('Prediccion de sujetos que dicen la verdad:');
    if(y_pred == 0)
      disp('KNN : MENTIRA');
    else
      disp('KNN : VERDAD');
      sumav++;
    endif
    y_pred1 = knn_predict(X_train, Y_train, X_test1, k);
        disp('Prediccion de sujetos que dicen mentira:');
    if(y_pred1 == 0)
      disp('KNN : MENTIRA');
      sumam++;
    else
      disp('KNN : VERDAD');
    endif
    endfor
   disp('Promedio de prediccion de verdad');
   promv=(sumav/5)*100
   disp('Promedio de prediccion de mentira');
   promm=(sumam/5)*100
   disp('Promedio de prediccion');
   m =((promm + promv)/2)
endfunction



