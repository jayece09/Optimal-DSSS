% xD = 100*randn(1,1000);
% yD = 100*randn(1,1000);
% 
% [x,y] = meshgrid(-10:0.2:50);
% z_sum = 0*x;
% h = surf(x,y,z_sum,'linestyle','none');
% 
% for i=1:numel(xD);
% 
%       z=42 - 4.2*sqrt((x-xD(i)).^2+(y-yD(i)).^2);
%       z(z<0) = 0;
%       z_sum = z_sum + z;
%       set(h,'zdata',z_sum);
%       drawnow;
% 
% end

   while i<1000

    a_1 = G*M/sqrt(x_p1^2+y_p1^2).*direction_p1; %acceleration
    v0_1 = v0_1+h.*a_1; %velocity being updated with step_size h times acc.

    x_p1 = x_p1+dt*v0_1(1);  y_p1 = y_p1+dt*v0_1(2); % x- og y-position
    plot(x_p1,y_p1,'r.')

   end