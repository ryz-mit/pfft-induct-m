function [O,L,W,H] = seg2fils(from, to, rad, pxrad)
%SEG2FILS Summary of this function goes here
%   Detailed explanation goes here
persistent pxrad2
persistent gi
persistent gj
persistent gw
persistent gh

ux = (to-from); % lengthwise along the path
ux = ux./norm(ux); 
uy = ux*[0 1 0; -1 0 0; 0 0 1]; 
uz = cross(ux,uy);

% Pixellate the cross section
if ~isequal(pxrad,pxrad2)
    pxrad2 = pxrad;
    tmp = sin(linspace(-pi/2,pi/2,2*pxrad-1));
    %tmp = 1-exp(-linspace(0,3,pxrad));
    %tmp = [-tmp(end:-1:2) tmp(2:end)];
    [gi, gj] = ndgrid(tmp(1:end-1)*rad);
    [gw, gh] = ndgrid(diff(tmp)*rad);
end

O = gi(:)*uy + gj(:)*uz;
O = bsxfun(@plus,from,O);
N = size(O,1);
L = repmat(to-from,N,1);
W = gw(:)*uy;
H = gh(:)*uz;

%showFils(O,L,W,H);
%size(O,1)

end

