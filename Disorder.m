%%%%%%%%%%%%%%%%%%
for ggg =1:100
tic;
NameRef = RefindexGen_Grating(ggg);
%%%%%%%%%%%%%%%%%%%%
index = load(NameRef);
num = 5000; %length(index);
N1 = 4000;
numeig = 0; 
Neig = 25; 
ncl = index(num);
lam = 1; 
k0 = 2*pi/lam; 
kcl = ncl * k0; 
clight = 299792.458; 
a = 200; 
delta = a/N1;  
%T = zeros(num,num);
ii=1:5000;
T1a(ii) = -2 + delta^2 * ((index(ii)*k0).^2 - kcl^2);
T1 = diag(T1a,0);
T2a = ones(1,4999); 
T2 = diag(T2a,1); 
T3 = diag(T2a,-1);
T = T1 + T2 + T3;
%for ii=1:num-1
%		T(ii,ii) = -2 + delta^2 * ((index(ii)*k0)^2 - kcl^2);
%		T(ii,ii+1) = 1; 
%		T(ii+1,ii) = 1; 		
%end
%T(num,num) = -2 + delta^2 * ((index(num)*k0)^2 - kcl^2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[VecEig,ValEig] = eig(T); 
eigVal = diag(ValEig); 
ttt = 1;
numeig = 0; 
clear g; 
CC=1;
for iii=num:-1:1 
	if eigVal(iii)>0 
		g = VecEig(:,iii);
		Modes(:,CC)=g; 
		CC = CC +1;		
	end
end
eigsysVl = sort(eigVal,'descend');
clear Name;
Name = sprintf('%d',ggg);
Name = strcat('Modes',Name,'.dat');
save("-text",Name, "Modes");  
end
timeTT = toc;
