clc, clear, close all

%2.3

Nmax = 1000; %количество эксперементов

p = 0:0.1:1;
p_back = 0.9;
n =1:20; %максимальное количество повторных передач

N = zeros(1,length(p));
N_teor = zeros(1,length(p));

for i=1:length(p)
   N_teor(i)=sum((-p(i)*p_back+p(i)+p_back).^(n-1));
%   N_teor(i)=1/((1-p(i))*(1-p_back));
end
disp(N_teor);


for count = 1:length(p)
    n_sum = 0; % сумма всех повторынх передач для Nmax эксперементов
    Ni =0;
%    Ni_back =-1;
    while Ni<Nmax %количество сообщений
        recept =0; %квитанция
        i = 0; % кол-во повторных передач
        a = 1;
        while(recept~=1) &&(i<20) %пока не придет положительная квитанция   
            e = error(p(count)); % возникновение ошибки с вероятность р
            b = xor(a,e);
             if a==b 
%                 if Ni_back == Ni
%                     recept =1;
%                     continue;
%                 end
                 recept = 1-error(p_back);
%                 Ni_back = Ni;
             end
            i=i+1;
        end
        n_sum = n_sum+i;
        Ni = Ni+1;
    end
    N(count) = n_sum/Nmax;
end

disp(N);
figure(2);
hold on;
plot(p, N, 'b');
plot(p, N_teor, 'r');
grid on;
xlabel('p');
ylabel('N');

function e = error(p) %генерация вектора ошибок
    e=0;
    tmp = rand(1);
    if tmp<p
        e=1;
    end 
end
