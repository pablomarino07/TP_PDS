function [m,max_min] = cargar_en_matriz_caracterisitcas()

num_files = 15;
MHL=zeros(120,39);
sesiones = [1 2 4 5];
suma=0;
for j= 1: 4
 ses= sesiones(j);
% Bucle para cargar cada archivo

for i = 1:num_files
     ##-------------------------------------------------------------------------------------------------
  % Crear el nombre del archivo
   filename = sprintf('C:\\Users\\pablo\\Desktop\\Trabajo Señales\\TP_PDS\\datos\\honest\\honest.subject%d.session%d.electrodofp2.txt',i,ses);
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
    suma= suma + 15;
endfor
#----------------------------------------------------------------------------------------------------------------------------------------------------------
suma =60;
for j =1: 4
   ses= sesiones(j);
for i =1 :num_files
     ##-------------------------------------------------------------------------------------------------
  % Crear el nombre del archivo
   filename = sprintf('C:\\Users\\pablo\\Desktop\\Trabajo Señales\\TP_PDS\\datos\\lying\\lying.subject%d.session%d.electrodofp2.txt',i,ses);
    % Leer el archivo y almacenarlo en una variable
    data = load(filename);  % Cargar los números del archivo
    ##-------------------------------------------------------------------------------------------------
         N=length(data);
         fm=500;   #Es la frecuencia de muestreo que tiene la BD
         tf = N/500; #Tiempo final en segundo
         t= 0: 1/500 : tf - 1/500;
         caract = extraer_caractersiticas_NB(data,fm,3);
         % Convertir la matriz en un vector columna
       caract = extraer_caractersiticas_NB(data,fm,3);
         % Convertir la matriz en un vector columna
         k=i+suma;
        MHL(k,:)=caract;



end
  suma=suma+15;
endfor

max_min = zeros(2,39);
##aux=0;
##for i=1:39
##  maximo=max(MHL(:,i));
##  max_min(1,i)=maximo;
##  minimo=min(MHL(:,i));
##  max_min(2,i)=minimo;
##  for j=1:120
##        aux=MHL(j,i);
##        MHL(j,i)=(aux-minimo)/(maximo-minimo);
##    endfor
##  endfor
  m=MHL;
end

