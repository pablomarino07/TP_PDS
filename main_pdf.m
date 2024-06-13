 filename = 'C:\\Users\\pablo\\Desktop\\Trabajo Señales\\TpFinal\\Base de Datos EEG\\Pruebas\\solo_sesion3\\lying\\lying_subject15_session3_probe.txt';
  data = load(filename);
  fm = 500;  % Frecuencia de muestreo
  caract = extraer_caractersiticas(data, fm, 3);
  caract_vector = caract(:);
  X_test = caract_vector;
  m=clasificador_pdf(X_test)


