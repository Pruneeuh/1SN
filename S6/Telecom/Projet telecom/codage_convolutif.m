function [symboles] = codage_convolutif(bits,g1,g2)
    symboles = zeros(2*length(bits),1);
    symboles(1) = g1(1)*bits(1);
    symboles(2) = g2(1)*bits(1);
    symboles(3) = g1(1)*bits(2);
    symboles(4) = g2(1)*bits(2);

    for i=3:length(bits)
        symboles(2*i-1)=g1(1)*bits(i)+g1(2)*bits(i-1)+g1(3)*bits(i-2);
        symboles(2*i)=g2(1)*bits(i)+g2(2)*bits(i-1)+g2(3)*bits(i-2);
    end
    symboles=mod(symboles,2);
end

