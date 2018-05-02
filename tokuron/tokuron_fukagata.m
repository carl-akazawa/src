clear all
close all
format long e
%asdf
%coefficients
rammda = 0.1;
%boundary condition
Txs = 0;
Txe = 0;
Tys = 1;
Tye = 0;

%discritization condition
a = 25;
b = 3;
N = 10000;
Xend = 1;
Yend = 1;
Tend = 10;
dx = Xend/a;
dy = Yend/b;
dt = Tend/N;
x = [0-dx/2:dx:Xend+dx/2];
y = [0-dy/2:dy:Yend+dy/2];
Tend = [0:dt:Tend];

%initial condition
T(1:a+2,1:b+2,1) = 0;

%main section
for k = 1:N
  %boundary condition for y direction
  for i = 1:a+2
    %diricre condition
%     T(i,1,k) = 2*Txs - T(i,2,k);
%     T(i,b+2,k) = 2*Txe - T(i,b+1,k);
    %neumann condition
    T(i,1,k) = T(i,2,k) - dy*Txs;
    T(i,b+2,k) = T(i,b+1,k) + dy*Txe;
  end
  %boundary condition for x direction
  for j = 1:b+2
    %diricre condition
    T(1,j,k) = 2*Tys - T(2,j,k);
    T(a+2,j,k) = 2*Tye - T(a+1,j,k);
    %neumann condition
    %T(1,j,k) = T(2,j,k) - dx*Txs;
    %T(a+2,j,k) = T(a+1,j,k) +dx*Txe;
  end

  %main culcuration section
  for j = 2:b+1
    for i = 2:a+1
      T(i,j,k+1) = T(i,j,k) + ...
      dt*rammda*((T(i+1,j,k)-2*T(i,j,k)+T(i-1,j,k))/dx^2 + ...
      (T(i,j+1,k) - 2*T(i,j,k) + T(i,j-1,k))/dy^2);
    end
  end
  % figure(1)
   %plot(T(2:a+2,2,k))
   %ylim([0,1])
%   contour(T(:,:,k)',100)
%   colormap jet
%   colorbar
end

figure
colormap jet
contourf(T(1:a+2,1:b+2,N)',1000,'LineStyle','none')

colorbar
