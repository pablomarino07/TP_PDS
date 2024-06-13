function y_pred = knn_predict(X_train, Y_train, X_test, k)
  num_test = size(X_test, 1);
  y_pred = zeros(num_test, 1);

  for i = 1:num_test
    % Calcular distancias Euclidianas
    distances = sqrt(sum((X_train - X_test(i, :)).^2, 2));

    % Encontrar los k vecinos más cercanos
    [~, idx] = sort(distances);
    nearest_labels = Y_train(idx(1:k));

    % Predecir la etiqueta como la moda de los vecinos más cercanos
    y_pred(i) = mode(nearest_labels);
  end
end

