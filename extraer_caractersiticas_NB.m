function m = extraer_caractersiticas_NB(x,fm,n)
  pkg load signal;
  X = fft(x); #Saco la transformada de x
  N = length(X); #Obtengo cantidad de muestras
  deltaf = fm/N;
  f = 0 : deltaf : fm-deltaf;
  fGamma1 = 25;
  fGamma2 = 40;
  theta1=4;
  theta2=7;
  alpha1=8;
  alpha2=13;
  Lalpha1=8;
  Lalpha2=10;
  fHAlpha1 = 10;
  fHAlpha2 = 12;
  fBeta1 = 14;
  fBeta2 = 30;
  Lbeta1=14;
  Lbeta2=25;
  fHBeta1 = 25;
  fHBeta2 = 35;
  fTotal1 = 4;
  fTotal2 = 35;
  X_pds = (1/(fm*N) * abs(X).^2); #Calculo de densidad espectral de potensia de la fft de x


%%----------------------------------------------------------------------------------------------------------------------------
  fmeanaux = 0;
  sumpds = 0;
  H=0;
  for i=1 : length(f)
    fmeanaux = fmeanaux + (f(i) * X_pds(i));
    sumpds = sumpds + X_pds(i);
    H = H + X_pds(i) * log2((1/X_pds(i)));
  endfor
  fmean = (fmeanaux) / (sumpds);
  [fmax,~] = max(X_pds);



 %-----------------------------------------------------------------------------------------------------------------------------


  function banda = calcula_banda(ff,f1,f2,Xf)
     [~, idx1] = min(abs(ff - f1));
     [~, idx2] = min(abs(ff - f2));
     banda = Xf(idx1:idx2);
     f_band = ff(idx1:idx2);
  endfunction

 Gamma = calcula_banda(f,fGamma1, fGamma2,X_pds);
  Theta = calcula_banda(f,theta1, theta2,X_pds);
  Alpha = calcula_banda(f,alpha1, alpha2,X_pds);
  LAlpha = calcula_banda(f,Lalpha1, Lalpha2,X_pds);
  HAlpha = calcula_banda(f,fHAlpha1, fHAlpha2,X_pds);
  Beta = calcula_banda(f,fBeta1, fBeta2,X_pds);
  HBeta = calcula_banda(f,fHBeta1, fHBeta2,X_pds);
  Lbeta = calcula_banda(f,Lbeta1, Lbeta2,X_pds);
  Total = calcula_banda(f,fTotal1, fTotal2,X_pds);

 % Crear una matriz para almacenar las estadísticas
  caract = zeros(9, 4);

  % Definir una función auxiliar para calcular las estadísticas
  function stats = calculate_stats(vector)
      stats = [min(vector), max(vector), mean(vector), std(vector)];
  end

  % Calcular las estadísticas y almacenarlas en la matriz
  caract(1, :) = calculate_stats(Gamma);
  caract(2, :) = calculate_stats(Theta);
  caract(3, :) = calculate_stats(Alpha);
  caract(4, :) = calculate_stats(LAlpha);
  caract(5, :) = calculate_stats(HAlpha);
  caract(6, :) = calculate_stats(Beta);
  caract(7, :) = calculate_stats(Lbeta);
  caract(8, :) = calculate_stats(HBeta);
  caract(9, :) = calculate_stats(Total);


  c=reshape(caract,[1,36]);
  m=zeros(1,39);
  for i=1:36
    m(i)=c(i);
    endfor
  m(37)=fmean;
  m(38)=H;
  m(39)=fmax;

  endfunction
