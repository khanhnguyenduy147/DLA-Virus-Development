%w=1.5 va p=1.5 va kich thuoc 200x200 va so virus = 5000
%Tha virus o giua, phia duoi cung
%
%
clear;
clc;

% so virus tong: 
n = 4000;
% so virus hien co:
nVirus = 1;

% mang bieu thi nong do thuc an:
C = zeros(202);

temp = zeros(202);

% tham so hieu chinh: 
w = 1.89;

% so mu p - trong c�ng thuc xac suat:
p = 2;

% mang grow d�nh dau vi tr� c�c virus d� xuat hien
grow = zeros(202);
grow(2, 100) = 1;

% Voi phuong ph�p lap SOR, khi t�nh tai buoc k+1 th� ta se c� gi� tri cua
% buoc k+1 tai vi tr� (i-1,j) v� (i,j-1)
for i = 2:201
  for j = 2:201
    C(i,j) = 1;
  end
end

% Dat virus dau ti�n o vi tr� tr�n c�ng tr�i
C(2, 100) = 0;

while 1
  candidate = zeros(202);
  sumOfChance = 0;
  
  % T�nh SOR 
  for i = 2:201
    for j = 2:201
      if C(i,j) ~= 0
        C(i,j) = (w/4)*(C(i+1,j)+C(i-1,j)+C(i,j+1)+C(i,j-1))+(1-w)*C(i,j);
      end
      if C(i,j) < 0
        temp(i,j) = 0;
      else
        temp(i,j) = C(i,j);
      end
    end
  end
  
  % C
  
  % T�m candidates 
  for i = 2:201
    for j = 2:201
        if grow(i,j) == 1
          C(i,j) = 0; %Set cho co virus thi nong do = 0
            if grow(i-1,j) == 0 && candidate(i-1,j) == 0
              candidate(i-1,j) = 1;
            end
            if grow(i+1,j) == 0 && candidate(i+1,j) == 0
              candidate(i+1,j) = 1;
            end
            if grow(i,j-1) == 0 && candidate(i,j-1) == 0
              candidate(i,j-1) = 1;
            end
            if grow(i,j+1) == 0 && candidate(i,j+1) == 0
              candidate(i,j+1) = 1;
            end 
        end
    end
  end
  
  % candidate
  
  % T�nh mau cua P 
  for i = 2:201
    for j = 2:201
      if candidate(i,j) == 1
        sumOfChance =sumOfChance + (C(i,j)).^(p);
      end
    end
  end
  
  % Random grow 
  for i = 2:201
    for j = 2:201
      if candidate(i,j) == 1
        randPos = rand()/10;
        curChance = ((C(i,j)).^p)/sumOfChance;
        if randPos < curChance
          grow(i,j) = 1;
          if nVirus < 4000
            nVirus = nVirus + 1;
          end
        end
      end
    end
  end
  
  if nVirus == 4000
    break
  end
  nVirus;
  
  x=1:202; y=1:202; 
  [X,Y]=meshgrid(x,y); 
  surf(X,Y,temp); 
  xlim([0 202]); 
  ylim([0 202]);
  zlim([0 1]); 
  colormap(jet);
  pause(0.01);
end


% Imagesc(C);
