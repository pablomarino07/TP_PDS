function  [m,max_min] = cargar_en_matriz_caracterisitcas_personas()

num_files = 14;
MHL=zeros(140,39);
sesiones = [1 2 3 4 5];
personas = [1 2 4 5 6 7 8 9 10 11 12 13 14 15];
suma=0;
for j= 1: 5
 ses= sesiones(j);
% Bucle para cargar cada archivo
for z = 1:num_files
  i=personas(z);
     ##-------------------------------------------------------------------------------------------------
  % Crear el nombre del archivo
         filename = sprintf('C:\\Users\\Pablo\\Documents\\GitHub\\TP_PDS\\datos\\honest\\honest.subject%d.session%d.electrodofp1.txt',i,ses);
    % Leer el archivo y almacenarlo en una variable
    data = load(filename);  % Cargar los números del archivo
    ##-------------------------------------------------------------------------------------------------
         N=length(data);
         fm=500;   #Es la frecuencia de muestreo que tiene la BD
         tf = N/500; #Tiempo final en segundo
         t= 0: 1/500 : tf - 1/500;
         caract = extraer_caractersiticas_NB(data,fm,3);
         % Convertir la matriz en un vector columna

        k=i+suma;
        MHL(k,:)=caract;
end
    suma= suma + 14;
endfor
#----------------------------------------------------------------------------------------------------------------------------------------------------------
suma =70;
for j =1: 5
   ses= sesiones(j);
for z =1 :num_files
    i=personas(z);
     ##-------------------------------------------------------------------------------------------------
  % Crear el nombre del archivo
     filename = sprintf('C:\\Users\\Pablo\\Documents\\GitHub\\TP_PDS\\datos\\lying\\lying.subject%d.session%d.electrodofp1.txt',i,ses);
    % Leer el archivo y almacenarlo en una variable
    data = load(filename);  % Cargar los números del archivo
    ##-------------------------------------------------------------------------------------------------
         N=length(data);
         fm=500;   #Es la frecuencia de muestreo que tiene la BD
         tf = N/500; #Tiempo final en segundo
         t= 0: 1/500 : tf - 1/500;
         caract = extraer_caractersiticas_NB(data,fm,3);
         % Convertir la matriz en un vector columna

        k=i+suma;
        MHL(k,:)=caract;



end
  suma=suma+14;
endfor

max_min = zeros(2,39);
aux=0;
    for i=1:39
      maximo=max(MHL(:,i));
      max_min(1,i)=maximo;
      minimo=min(MHL(:,i));
      max_min(2,i)=minimo;
        for j=1:140
              aux=MHL(j,i);
              MHL(j,i)=(aux-minimo)/(maximo-minimo);
        endfor
      endfor



   m=MHL;



end
