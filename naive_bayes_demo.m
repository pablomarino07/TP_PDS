% Naive Bayes Classifie

function naive_bayes_demo()

    % load data
    training_vectors=zeros(120,36);
    X_train = cargar_en_matriz_caracterisitcas()
    training_vectors((1:20),36)=X_train((1:20),36);
    training_vectors((21:40),36)=X_train((61:80),36);
    training_vectors((41:60),36)=X_train((21:40),36);
    training_vectors((61:80),36)=X_train((81:100),36);
    training_vectors((81:90),36)=X_train((41:50),36);
    training_vectors((91:100),36)=X_train((101:110),36);
    training_vectors((101:110),36)=X_train((51:60),36);
    training_vectors((111:120),36)=X_train((111:120),36);
    training_classes(1:20) = 1;
    training_classes(21:40) = 2;
    training_classes(41:60) = 1;
    training_classes(61:80) = 2;
    training_classes(81:90) = 1;
    training_classes(91:100) = 2;
    training_classes(101:110) = 1;
    training_classes(111:120) = 2;


    % laplacian smoothing factor to cope with 0-likelihoods
    number_of_classes = 2;

    % training
    trainingset_vectors = training_vectors(1:80,:);
    trainingset_classes = training_classes(1:80);
    testset_vectors = training_vectors(81:100,:);
    testset_classes = training_classes(81:100);
    crossvalset_vectors = training_vectors(101:120,:);
    crossvalset_classes = training_classes(101:120);

    % cross validation to determine good k
    likelihoods = zeros(number_of_classes, size(training_vectors, 2));
    priors = zeros(number_of_classes, 1);
    evidence = zeros(size(training_vectors,2), 1);
    accuracy = 0.0;
    k = 0.0;
    k_values = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];
    for i=1:length(k_values)
        % train with k
        [c_likelihoods, c_priors, c_evidence] = naive_bayes_train(trainingset_vectors, trainingset_classes, number_of_classes, k_values(i));
        % classify cross-val set
        [crossval_predicted_classes, crossval_posteriors] = naive_bayes_classify(crossvalset_vectors, c_priors, c_likelihoods, c_evidence);
        % check if k is better
        c_accuracy = sum(crossval_predicted_classes == crossvalset_classes)/length(crossvalset_classes)*100.0;
        if c_accuracy>accuracy
            accuracy = c_accuracy;
            k = k_values(i);
            likelihoods = c_likelihoods;
            priors = c_priors;
            evidence = c_evidence;
        endif;
    endfor;
    printf("Selected k=%2.2f with cross-validation accuracy=%2.2f%%.\n",k, accuracy);

    % trainingset accuray
    [trainingset_predicted_classes, trainingset_posteriors] = naive_bayes_classify(trainingset_vectors, priors, likelihoods, evidence);
    accuracy = sum(trainingset_predicted_classes == trainingset_classes)/length(trainingset_classes)*100.0;
    printf("Accuracy on training-set=%2.2f%%\n", accuracy);

    % test
    [test_predicted_classes, test_posteriors] = naive_bayes_classify(testset_vectors, priors, likelihoods, evidence);
    accuracy = sum(test_predicted_classes == testset_classes)/length(testset_classes)*100.0;
    printf("Accuracy on test-set=%2.2f%%\n", accuracy);

    % predict examples
##    example_vectors = zeros(2, 72);
##    example_vectors(1, [21,71,7,48,2,1]) = [1,1,1,1,1,1]; % 'i want to pay my bill'
##    example_vectors(2, [42,38,8,37,31,2,34,24]) = [1,1,1,1,1,1,1,1]; % 'i'm having a problem with my phone connection'
##    [examples_predicted_classes, examples_posteriors] = naive_bayes_classify(example_vectors, priors, likelihoods, evidence);
##    printf("Prediction for 'i want to pay my bill': %d\n", examples_predicted_classes(1));
##    printf("Prediction for 'i'm having a problem with my phone connection': %d\n", examples_predicted_classes(2));

     example_vectors = zeros(30,36);

    for i = 1:15
    % Cargar datos de prueba
    filename = sprintf('C:\\Users\\pablo\\Desktop\\Trabajo Señales\\TpFinal\\Base de Datos EEG\\Pruebas\\solo_sesion3\\honest\\honest_subject%d_session3_probe.txt', i);
    data = load(filename);
    fm = 500;  % Frecuencia de muestreo
    caract = extraer_caractersiticas_NB(data, fm, 3);
    caract_vector = caract(:);
    example_vectors(i, :) = caract_vector ;
  endfor
suma=15;
   for i = 1:15
    % Cargar datos de prueba
    filename = sprintf('C:\\Users\\pablo\\Desktop\\Trabajo Señales\\TpFinal\\Base de Datos EEG\\Pruebas\\solo_sesion3\\lying\\lying_subject%d_session3_probe.txt', i);
    data = load(filename);
    fm = 500;  % Frecuencia de muestreo
    caract = extraer_caractersiticas_NB(data, fm, 3);
    caract_vector = caract(:);
    suma=suma+i;
    example_vectors(suma, :) = caract_vector ;
  endfor




  [examples_predicted_classes, examples_posteriors] = naive_bayes_classify(example_vectors, priors, likelihoods, evidence);
   for i=1 :30
    printf("Prediccion si es 0 es mentira si es 1 es verdad': %d\n", examples_predicted_classes(i));
  endfor






endfunction
