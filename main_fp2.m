function m = main_fp2()
  pkg load statistics;

  % Cargar los datos de entrenamiento KNN
  [X_train,max_min] = cargar_en_matriz_caracterisitcas();
  Y_train = zeros(1, 120);  % Vector de etiquetas de longitud 120 lleno de ceros
  Y_train(1:60) = 1;
  Y_train(61:end) = 0;
  sumav=0;
  sumam=0;


  %-------------------------------------------------------------------
  %Entrenamiendo NAIVE BAYES
  PDF = 'gaussian'; % There are 2 types of options: 'gaussian' and 'exponential'
  mdl = NaiveBayes(PDF);
  mdl = mdl.fit(X_train,Y_train);
  sumavnb=0;
  sumamnb=0;

 k=7;


 for j=1:15
    % Cargar datos de prueba
    filename = sprintf('C:\\Users\\pablo\\Desktop\\Trabajo Señales\\TP_PDS\\datos\\honest\\honest.subject%d.session3.electrodofp2.txt',j);
    filename1 = sprintf('C:\\Users\\pablo\\Desktop\\Trabajo Señales\\TP_PDS\\datos\\lying\\lying.subject%d.session3.electrodofp2.txt',j);

    data = load(filename);
    data1 = load(filename1);
    fm = 500;  % Frecuencia de muestreo
    caract = extraer_caractersiticas_NB(data, fm, 3);
    caract1 = extraer_caractersiticas_NB(data1, fm, 3);
##  for m=1:39
##
##      maximo=max_min(1,m);
##      minimo=max_min(2,m);
##      aux=caract(m);
##      aux1=caract1(m);
##      caract(m)=(aux-minimo)/(maximo-minimo);
##      caract1(m)=(aux1-minimo)/(maximo-minimo);
##
##
##  endfor

    X_test = caract;
    X_test1 = caract1;



    % Implementación manual de KNN
    y_pred = knn_predict(X_train, Y_train, X_test, k);
    if(y_pred == 1)
      sumav++;
    endif

       % Implementación manual de KNN
    y_pred1 = knn_predict(X_train, Y_train, X_test1, k);
    if(y_pred1 == 0)
      sumam++;
    endif


  %NAIVE BAYES
  Ypred1= mdl.predict(caract);
  Ypred2 = mdl.predict(caract1);

    if(Ypred1 == 1)
      sumavnb++;
    endif

    if(Ypred2 == 0)
      sumamnb++;
    endif


 endfor

  promv=(sumav/15)*100;
  promm=(sumam/15)*100;
  m=(promm+promv)/2;

 printf('Con un K= %d, Promedio de verdad= %.2f, Promedio de mentira= %.2f\n', k, promv, promm);
  printf('Promedio de efectividad= %.2f\n', m);


    promvnb=(sumavnb/15)*100;
    prommnb=(sumamnb/15)*100;
    m2=(promvnb+prommnb)/2;

   printf('Promedio de verdad NB= %.2f, Promedio de mentira NB= %.2f\n', promv, promm);
  printf('Promedio de efectividad NB= %.2f\n', m2);


endfunction

