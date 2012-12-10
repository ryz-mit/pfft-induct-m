clear
r = 1;
zp1 = 0;
zp2 = 30;
N = 200;

% Make the full matrices
z = linspace(zp1,zp2,N);
G = zeros(N);
T = zeros(N);
H = zeros(N);
for ii = 1:N
    [G(:,ii) T(:,ii) H(:,ii)] = makeTPH(r,z,z(ii));
end

% Extract the first and last rows
%ip = [1, 34, 67, 100];
ip = [1,round((N-1)/4)+1,round(2*(N-1)/4)+1,round(3*(N-1)/4)+1,N];
%ip=1:N;

% Split
[Tr Hr zt zh] = splitTPH(G(:,ip),ip);

corner = (length(zt)+1)/2;
Trmat = toeplitz(Tr);
Hrmat = hankel(Hr(1:corner),Hr(corner:end));
Grmat = Trmat + Hrmat;

% reconstruction error
er1 = max(max(abs((G-Grmat)./G)));
er1a = max(max(abs((G-Grmat))));
er2 = max(max(abs((T-Trmat)./T)));
er3 = max(max(abs((H-Hrmat)./H)));

% Display error
disp(['Max G recon error: ' mat2str(er1)]);
disp(['Max abs G recon error: ' mat2str(er1a)]);
disp(['T recon error: ' mat2str(er2)]);
disp(['H recon error: ' mat2str(er3)]);

%% Draw
figure(1);
idd = 50;
Gd = diag(G,idd);
Grd = diag(Grmat,idd);
Td = diag(T,idd);
Trd = diag(Trmat,idd);
Hd = diag(H,idd);
Hrd = diag(Hrmat,idd);
subplot(311);semilogy([Gd,Grd,abs((Gd-Grd)./Gd)])
subplot(312);semilogy([Td,Trd,abs((Td-Trd)./Td)])
subplot(313);semilogy([Hd,Hrd,abs((Hd-Hrd)./Hd)])

% figure(2)
% clf(2)
% subplot(411)
% plot(z,T1,z,Tr1,z,T2,z,Tr2);
% legend('T1','Tr1','T2','Tr2');
% subplot(412)
% %%
% 
% subplot(413)
% plot(z,H1,z,Hr1,z,H2,z,Hr2);
% legend('H1','Hr1','H2','Hr2');
% %end
% %%
% figure(3)
% zsh = z(dz+1:end);
% Tr1sh = Tr1(1:(end-dz));
% Tr2sh = Tr2(dz+1:(end));
% plot(zsh,Tr1sh,zsh,Tr2sh,zsh,Tr1sh-Tr2sh);
% legend('Tr1 shifted','Tr2');
% 