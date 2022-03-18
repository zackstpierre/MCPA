function plane_no_Boxes(nx,ny, mode)


finalarray = zeros(nx,ny);
mapvector = zeros(nx*ny,1);
G = sparse(nx*ny, nx*ny);

for i = 1:nx
	for j = 1:ny
		n = j+(i-1)*ny;

		
		if i == 1
			mapvector(n) = 1;
			G(:,n) = 0;
			G(n,n) = 1;
		elseif i == nx
			if mode ~= 1
				mapvector(n) = 1;
			end
			G(:,n) = 0;
			G(n,n) = 1;
		elseif j == 1 

			if mode == 1 
				nxm = j+(i-2)*ny;
            	nxp = j+(i)*ny;

            	G(n,n) = -2;
            	G(n,nxm) = 1;
            	G(n,nxp) = 1;
			else 
				G(n,:) = 0;
				G(n,n) = 1;

			end

		elseif j == ny 

			if mode == 1 
				nxm = j+(i-2)*ny;
            	nxp = j+(i)*ny;

            	G(n,n) = -2;
            	G(n,nxm) = 1;
            	G(n,nxp) = 1;
			else 
				G(n,:) = 0;
				G(n,n) = 1;

			end
		else 
			nxm = j+(i-2)*ny;
            nxp = j+(i)*ny;
            nym = (j-1)+(i-1)*ny;
            nyp = (j+1)+(i-1)*ny;            
            
            G(n,n) = -4;
            G(n,nxm)= 1;
            G(n,nxp) = 1;
            G(n,nym) = 1;
            G(n,nyp) = 1;
		end
	end
end

mapvector = G\mapvector;

for i = 1:nx
	for j = 1:ny
		n= j+(i-1)*ny;
		finalarray(i,j) = mapvector(n);
	end
end
figure()
surf(finalarray, 'edgecolor', 'none')
rotate3d on;

if mode == 1 
	title("Solution to Laplace with Unbound Y Dimension");
elseif mode == 2
	title("Solution to Laplace with Grounded Y Dimension");
end
ylabel('L');
xlabel('W');
zlabel('V (Volts)');



