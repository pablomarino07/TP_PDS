function m = cargar_en_matriz_caracterisitcas_ANOVA()

num_files = 15;
MHL=zeros(120,5);
sesiones = [1 2 4 5];
suma=0;
for j= 1: 4
 ses= sesiones(j);
% Bucle para cargar cada archivo
for i = 1:num_files
     ##-------------------------------------------------------------------------------------------------
  % Crear el nombre del archivo
    filename = sprintf('C:\\Users\\pablo\\Desktop\\Trabajo Señales\\TpFinal\\Base de Datos EEG\\Pruebas\\solo_sesion%d\\honest\\honest_subject%d_session%d_probe.txt', ses,i,ses);
    % Leer el archivo y almacenarlo en una variable
    data = load(filename);  % Cargar los números del archivo
    ##-------------------------------------------------------------------------------------------------
         N=length(data);
         fm=500;   #Es la frecuencia de muestreo que tiene la BD
         tf = N/500; #Tiempo final en segundo
         t= 0: 1/500 : tf - 1/500;
         caract = extraer_caractersiticas(data,fm,3);
         % Convertir la matriz en un vector columna
        caract_vector = caract(:);
        caracteristicas = caract_vector';
        length(caracteristicas);
        k=i+suma;
        MHL(k,:)=caracteristicas;
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
    filename = sprintf('C:\\Users\\pablo\\Desktop\\Trabajo Señales\\TpFinal\\Base de Datos EEG\\Pruebas\\solo_sesion%d\\lying\\lying_subject%d_session%d_probe.txt', ses,i,ses);
    % Leer el archivo y almacenarlo en una variable
    data = load(filename);  % Cargar los números del archivo
    ##-------------------------------------------------------------------------------------------------
         N=length(data);
         fm=500;   #Es la frecuencia de muestreo que tiene la BD
         tf = N/500; #Tiempo final en segundo
         t= 0: 1/500 : tf - 1/500;
         caract = extraer_caractersiticas(data,fm,3);
         % Convertir la matriz en un vector columna
        caract_vector = caract(:);
        caracteristicas = caract_vector';
        length(caracteristicas);
        k=i+suma;
        MHL(k,:)=caracteristicas;



end
  suma=suma+15;
endfor
m=MHL;

end

