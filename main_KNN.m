function m = main_KNN()
  pkg load statistics;

  % Cargar los datos de entrenamiento
  [X_train,max_min] = cargar_en_matriz_caracterisitcas();
  Y_train = zeros(1, 120);  % Vector de etiquetas de longitud 120 lleno de ceros
  Y_train(1:60) = 1;
  Y_train(61:end) = 0;
  sumav=0;
  sumam=0;

  k = 5;

 for j=1:15
    % Cargar datos de prueba
    filename = sprintf('C:\\Users\\pablo\\Desktop\\Trabajo Señales\\TpFinal\\Base de Datos EEG\\Pruebas\\solo_sesion1\\honest\\honest_subject%d_session1_probe.txt',j);
    filename1 = sprintf('C:\\Users\\pablo\\Desktop\\Trabajo Señales\\TpFinal\\Base de Datos EEG\\Pruebas\\solo_sesion1\\lying\\lying_subject%d_session1_probe.txt',j);

    data = load(filename);
    data1 = load(filename);
    fm = 500;  % Frecuencia de muestreo
    caract = extraer_caractersiticas_NB(data, fm, 3);
    caract1 = extraer_caractersiticas_NB(data1, fm, 3);
  for m=1:39

      maximo=max_min(1,m);
      minimo=max_min(2,m);
      caract(m)=(aux-minimo)/(maximo-minimo);
      caract1(m)=(aux-minimo)/(maximo-minimo);


  endfor

    X_test = caract;

    X_test1 = caract1;




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



