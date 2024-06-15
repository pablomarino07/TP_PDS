function caract = extraer_caractersiticas(x, fm, n)
  pkg load signal;
  % Inicialización de la matriz de características
  caract = zeros(1, 5);
  % Cálculo de la Transformada de Fourier
  X = fft(x);
  N = length(X); % Obtención de la cantidad de muestras
  deltaf = fm / N;
  f = 0 : deltaf : fm - deltaf;
  % Definición de los límites de frecuencia para cada banda
  fGamma1 = 25; fGamma2 = 40;
  fHAlpha1 = 10; fHAlpha2 = 12;
  fBeta1 = 14; fBeta2 = 30;
  fHBeta1 = 25; fHBeta2 = 35;
  fTotal1 = 4; fTotal2 = 35;
  #Calculo de densidad espectral de potensia de la fft de x
  X_pds = (1/(fm*N) * abs(X).^2);

  function banda = calcula_banda(ff,f1,f2,Xf)
     [~, idx1] = min(abs(ff - f1));
     [~, idx2] = min(abs(ff - f2));
     banda = Xf(idx1:idx2);
     f_band = ff(idx1:idx2);
  endfunction

  Gamma = calcula_banda(f,fGamma1, fGamma2,X_pds);
  HAlpha = calcula_banda(f,fHAlpha1, fHAlpha2,X_pds);
  Beta = calcula_banda(f,fBeta1, fBeta2,X_pds);
  HBeta = calcula_banda(f,fHBeta1, fHBeta2,X_pds);
  Total = calcula_banda(f,fTotal1, fTotal2,X_pds);

  % Cálculo de las características y almacenamiento en la matriz 'caract'
  caract(5) = mean(Gamma);
  caract(2) = std(HAlpha);
  caract(3) = mean(Beta);
  caract(4) = max(HBeta);
  caract(1) = mean(Total);

endfunction

