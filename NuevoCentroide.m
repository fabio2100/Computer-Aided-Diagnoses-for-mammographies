function [ new_cx,new_cy,sreg1bwm ] = NuevoCentroide( sreg1bwm,cx,cy )
%NuevoCentroide Busca un nuevo centroide si el valor en el pixel original
%es (0,0)
sreg1bwm_n=imfill(sreg1bwm,'holes');
if sreg1bwm_n(cy,cx) == 1
    new_cx=cx;
    new_cy=cy;
    sreg1bwm=sreg1bwm_n;
else

    m=[nan,nan,nan,nan];
    sizeim=size(sreg1bwm);
    for i=cx:-1:1
        if sreg1bwm(cy,i)==1
            m(1)=cx-i;
            break
        end
    end
    for i=cx:sizeim(2)
        if sreg1bwm(cy,i)==1
            m(2)=i-cx;
            break
        end
    end
    for i=cy:-1:1
        if sreg1bwm(i,cx)==1
            m(3)=cy-i;
            break
        end
    end
    for i=cy:sizeim(1)
        if sreg1bwm(i,cx)==1
            m(4)=i-cy;
            break
        end
    end
    if min(m)== m(1)
        new_cx=cx-m(1);
        new_cy=cy;
    end
    if min(m) ==m(2)
        new_cx=cx+m(2);
        new_cy=cy;
    end
    if min(m)==m(3)
        new_cx=cx;
        new_cy=cy-m(3);
    end
    if min(m)==m(4)
        new_cx=cx;
        new_cy=cy+m(4);
    end
end

