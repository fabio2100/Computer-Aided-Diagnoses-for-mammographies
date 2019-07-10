%De sobelmejoramientomedia, ahí se encuentran todos los códigos eliminados
close all
clear all

load ima5

%Imagen con filtro sobel horizontal y vertical
sh=imfilter(mprecf,fspecial('sobel'));
sv=imfilter(mprecf,(fspecial('sobel')'));
%Eliminamos los contornos
mprecf_bw=im2bw(mprecf,1/256);
mprecf_ero=imerode(mprecf_bw,strel('disk',2));
sh_bw=im2bw(sh,1/256);
sv_bw=im2bw(sv,1/256);
sh_ero=sh_bw.*mprecf_ero;
sv_ero=sv_bw.*mprecf_ero;
sh_fin=uint8(sh_ero).*sh;
sv_fin=uint8(sh_ero).*sv;
ima=(sh_fin+sv_fin)/2;

%sizeima=size(ima);

%Calculamos el mejoramiento de contraste por media.

sizemprecf=size(mprecf);
g=zeros(sizemprecf);
for y=2:sizemprecf(1)-1
    for x=2:sizemprecf(2)-1
        g(y,x)=(mprecf(y,x)-mean2(mprecf(y-1:y+1,x-1:x+1)))^2;
    end
end

%Producto entre dos imágenes de mejoramiento obtenidas
g1=double(ima).*g;
%*********************************************************************
%Invertimos la imagen para referenciar los máximos a 0 y desde ahí
%proceder a analizar los valores siguientes, hasta encontrar alguna mc o
%finalizar. Ver cuándo aparecen las mcs
max_g1=max(max(g1));
sizeg1=size(g1);
g2=zeros(sizeg1);
for y=1:sizeg1(1)
    for x=1:sizeg1(2)
        g2(y,x)=max_g1-g1(y,x);
    end
end
info=[];
for i=1:100:max_g1
    [y,x]=find(g2<i);
    if length(x)>100
        break
    end
end
% %Mostramos la imagen
% imshow(mprecf),title 'Posibles ucs,primera imagen'
% hold on
% for i=1:length(x)
%     plot(x(i),y(i),'xr')
% end
% pause
% close all
%***********************************************************************************
%Buscamos que no existan líneas horizontales ni verticales en la imagen que perjudiquen
%el análisis.ej mdb238
n_mode_y=length(find(y==mode(y)));
n_mode_x=length(find(x==mode(x)));

if n_mode_y > 20
    g2(mode(y)-1:mode(y)+1,:)=max_g1;
    y=[];
    x=[];
    for i=1:100:max_g1
        [y,x]=find(g2<i);
        if length(x)>100
            break
        end
    end
end

if n_mode_x > 20
    g2(:,mode(x)-1:mode(x)+1)=max_g1;
    y=[];
    x=[];
    for i=1:100:max_g1
        [y,x]=find(g2<i);
        if length(x)>100
            break
        end
    end
end
%********************************************************************
%Mostramos la imagen con los puntos candidatos a ser ucs
% imshow(mprecf),title 'Posibles ucs,segunda imagen'
% hold on
% for i=1:length(x)
%     plot(x(i),y(i),'xr')
% end
% pause
% close all


%Procesamiento punto por punto analizando la zona determinada
%Creamos la roi,determinamos si el punto corresponde con el máximo de la
%zona
info=[];
for i=1:length(x)
    ext_izq=y(i)-2;
    if ext_izq<1
        ext_izq=1;
    end
    ext_der=y(i)+2;
    if ext_der>sizemprecf(1)
        ext_der=sizemprecf(1);
    end
    ext_sup=x(i)-2;
    if ext_sup<1
        ext_sup=1;
    end
    ext_inf=x(i)+2;
    if ext_inf>sizemprecf(2)
        ext_inf=sizemprecf(2);
    end
    roi=mprecf(ext_izq:ext_der,ext_sup:ext_inf);
    if max(max(roi))==roi(2,3)||max(max(roi))==roi(4,3)||max(max(roi))==roi(3,2)||max(max(roi))==roi(3,4)||max(max(roi))==roi(3,3)
        info=[info;x(i),y(i)];
    end
end
% imshow(mprecf),title 'Posibles ucs,tercera imagen'
% hold on
 sizeinfo=size(info);
% for i=1:sizeinfo(1)
%     plot(info(i,1),info(i,2),'xr')
% end
% pause

%Creación de ventana a analizar,nuevo mejoramiento y uso de hmin
close all
info2=[];
for i=1:sizeinfo(1)
    ext_izq=info(i,2)-4;
    if ext_izq<1
        ext_izq=1;
    end
    ext_der=info(i,2)+4;
    if ext_der>sizemprecf(1)
        ext_der=sizemprecf(1);
    end
    ext_sup=info(i,1)-4;
    if ext_sup<1
        ext_sup=1;
    end
    ext_inf=info(i,1)+4;
    if ext_inf>sizemprecf(2)
        ext_inf=sizemprecf(2);
    end
    roi=mprecf(ext_izq:ext_der,ext_sup:ext_inf);
    min_roi=double(min(min(roi)));
    max_roi=double(max(max(roi)));
    roi2=imadjust(roi,[min_roi/256 max_roi/256],[]);
    sizeroi2=size(roi2);
    th=imtophat(roi2,strel('disk',5));
    tb=imbothat(roi2,strel('disk',5));
    img=roi2+th-tb;
    r=double(min([img(5,5),img(4,5),img(6,5),img(5,4),img(5,6)]));
    im_bin=im2bw(img,r/255);
    im_bin_a=bwareafilt(im_bin,1);
    sizeimbin=size(im_bin_a);
    fila_sup=im_bin_a(1,:);
    fila_inf=im_bin_a(sizeimbin(1),:);
    col_izq=im_bin_a(:,1);
    col_der=im_bin_a(:,sizeimbin(2));
    elementos_bordes=[im_bin_a(1,:),im_bin_a(:,1)',im_bin_a(sizeimbin(1),:),im_bin_a(:,sizeimbin(2))'];
    if sum(elementos_bordes)== 0
        info2=[info2;info(i,1),info(i,2)];
    end
end
close all
% imshow(mprecf),title 'Calcificaciones cuarta imagen'
% hold on
% sizeinfo2=size(info2);
% for i=1:sizeinfo2(1)
%     plot(info2(i,1),info2(i,2),'xr')
% end
%División según cantidad de calcificaciones encontradas
if isempty(info2)
    calc0;
else
    save info2 info2
    anacalc;
end

