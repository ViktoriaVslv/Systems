clc, clear, close all

p = 0:0.1:0.9;

Nmax = 1000; %���������� �������������
N = zeros(1,length(p));
N_teor = zeros(1,length(p));

for i=1:length(p)
    N_teor(i)= 1/(1-p(i));
end
disp(N_teor);

%2.1 �������� � ��������� ���  �������������� ������ ��������� �������
%��� ����������� �������� ����� ��������� �������
for count = 1:length(p)
    n_sum = 0; % ����� ���� ��������� ������� ��� Nmax �������������
    Ni =0;
    while Ni<Nmax %���������� ���������
        recept =0; %���������
        i = 0; % ���-�� ��������� �������
        a = 1;
        while(recept~=1)%���� �� ������ ������������� ���������  
            e = error(p(count)); % ������������� ������ � ����������� �
            b = rem(a+e,2);
            if a==b
                recept = 1;
            end
            i=i+1;
        end
        n_sum = n_sum+i;
        Ni = Ni+1;
    end
    N(count) = n_sum/Nmax;
end

disp(N);
figure(1);
hold on;
plot(p, N, 'b');
plot(p, N_teor, 'r');
grid on;
xlabel('p');
ylabel('N');


function e = error(p) %��������� ������� ������
    e=0;
    tmp = rand(1);
    if tmp<p
        e=1;
    end 
end