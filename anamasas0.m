%Analiza si existen masas. Luego elige la guide a continuación, según sean
%0 masas o alguna presente. 

load ima6
load ima5
sizemprecf=size(mprecf);
%e=edge(ima,'Canny');
 sizemprecf=size(mprecf);
 for x=2:sizemprecf(1)-1
     for y=2:sizemprecf(2)-1
         e(x,y)=0;
         if (ima1(x,y)*9) == sum(sum(ima1(x-1:x+1,y-1:y+1)))
             e(x,y)=1;
         end
     end
 end
 sizee=size(e);
 e1=e(2:sizee(1)-1,2:sizee(2)-1);
%e=imresize(e,[sizemprecf(1) sizemprecf(2)]);
%%%Acá reemplazo por la función creada para los bordes con mejores
%%%resultados
% % sizemprecf=size(mprecf);
% % for x=2:sizemprecf(1)-1
% %     for y=2:sizemprecf(2)-1
% %         v(x,y)=0;
% %         if (ima1(x,y)*9) == sum(sum(ima1(x-1:x+1,y-1:y+1)))
% %             v(x,y)=1;
% %         end
% %     end
% % end
v=logical(e1);
%v=imresize(v,[sizemprecf(1) sizemprecf(2)]);
mprecf=mprecf(2:sizee(1)-1,2:sizee(2)-1);
mprecf2=double(mprecf);
%vi=imcomplement(v);
mprecfbw=im2bw(mprecf,1/256);
sup_mprecfbw=double(nnz(mprecfbw));
pcf=mprecfbw.*v;
lpcf=logical(pcf);
save lpcf lpcf
stats=regionprops('table',lpcf,'Centroid','MajorAxisLength','MinorAxisLength','Area','BoundingBox');
save stats stats
major=cat(1,stats.MajorAxisLength);
minor=cat(1,stats.MinorAxisLength);
Area=cat(1,stats.Area);
Boundingbox=cat(1,stats.BoundingBox');
save Boundingbox Boundingbox
centroid=cat(1,stats.Centroid);
relacion=major./minor;
n=[];

for i=2:length(relacion)
     if  relacion(i)>1  && Area(i)>1000           %Saqué relacion(i)<3
        n=[n,i];
    end
end
tot=length(n);
if tot == 0
    masascero;
end


save n n
% % set(handles.nummasas,'String',tot);
% j=n(1);
% bh=Boundingbox(4,j);                    %Afecta a y
% bb=Boundingbox(3,j);                    %Afecta a x
% bx=Boundingbox(1,j);
% by=Boundingbox(2,j);
% % axes(handles.ori)
% % imshow(mprecf),title 'Ubicación de la masa'
% % hold on
% % rectangle('Position',[bx by bb bh],'EdgeColor','r','LineWidth',3)
% % axes(handles.rec)
% % imshow(ima),title 'Agrupaciones'
% reg=mprecf(Boundingbox(2,j):(Boundingbox(2,j)+Boundingbox(4,j)),(Boundingbox(1,j):(Boundingbox(1,j)+Boundingbox(3,j))));
% % axes(handles.roigrises)
% % imshow(reg),title 'ROI'
% regbw=lpcf(Boundingbox(2,j):(Boundingbox(2,j)+Boundingbox(4,j)),(Boundingbox(1,j):(Boundingbox(1,j)+Boundingbox(3,j))));
% regbw1=bwareafilt(regbw,1);
% % axes(handles.binarizada)
% % imshow(regbw1),title 'Binarizada'
k=[];
for i=1:tot
    j=n(i);
    cx=round(centroid(j,1));
    cy=round(centroid(j,2));
    %Introducimos valores para que la región siempre quede comprendida
    %dentro de la imagen
    b1=round(Boundingbox(1,j));
    if b1<1
        b1=1;
    end
    b2=round(Boundingbox(2,j));
    if b2<1
        b2=1;
    end
     b3=round(Boundingbox(3,j));
    if b3>sizemprecf(2)
        b3=sizemprecf(2)-1;
    end
     b4=round(Boundingbox(4,j));
    if b4>sizemprecf(1)
        b4=sizemprecf(1)-1;
    end
    reg1=mprecf(b2:b2+b4-1,b1:b1+b3-1);                         %ver el error, estoycon mdb249 me pa o 239 o x ahi
    regbw=lpcf(b2:b2+b4-1,b1:b1+b3-1);
    regbw1a=(bwareafilt(regbw,1));
    %Introducimos la región inversa para calcular su media y después usarla
    %como comparativa para ver si se trata de un nódulo. 
    regbw1_inv=imcomplement(regbw1a);
    regbw1_inv_int=uint8(regbw1_inv);
    reg_inv_grises=regbw1_inv_int.*reg1;
    reg_inv_grises_vec=reg_inv_grises(reg_inv_grises~=0);
    media_reg_inv=mean(reg_inv_grises_vec);
    nz_reg_inv=nnz(regbw1_inv);
    %Luego realizamos las operaciones correspondientes a la ROI original
    regbw1=uint8(regbw1a);
    sreg=regbw1.*reg1;
    sreg1=sreg(sreg~=0);
    minreg=double(min(min(sreg1)));
    max_reg=double(max(max(sreg1)));
    media_reg=mean(sreg1);
%     dif_reg=max_reg-minreg;
    %     rg=regiongrowing(mprecf2,cy,cx,dif_reg);
    %     sup_rg=double(nnz(rg));
    %     rel_sup=sup_rg./sup_mprecfbw;
    mprecf3=imadjust(mprecf,[minreg/256 max_reg/256],[]);
    sreg1bw=im2bw(mprecf3,1/256);
    if sreg1bw(cy,cx)==0
        [cx,cy,sreg1bw]=NuevoCentroide(sreg1bw,cx,cy);
    end
    sreg1bwm=bwareafilt(sreg1bw,1);
    while sreg1bwm(cy,cx) == 0
        sreg1bw=sreg1bw-sreg1bwm;
        sreg1bw=logical(sreg1bw);
        sreg1bwm=bwareafilt(sreg1bw,1);
    end
   
    
    
    save imm sreg1bw
    sup_sreg=nnz(sreg1bwm);
    rel_sup=sup_sreg./sup_mprecfbw;
    rel_sup_inv=nz_reg_inv./sup_mprecfbw;
    rel_medias=media_reg/media_reg_inv;
    if rel_sup < 0.26
        if rel_sup_inv < 0.3
            if rel_medias > 1
                k=[k j];
            end
        end
    end
end
save k k
totk=length(k);

if totk == 0
    masascero;
else
    anamasas;
end

save totk totk

