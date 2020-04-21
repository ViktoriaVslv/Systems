clc, clear, close all

p = 0:0.1:0.9;

Nmax = 1000; %количество эксперементов
N = zeros(1,length(p));
N_teor = zeros(1,length(p));

for i=1:length(p)
    N_teor(i)= 1/(1-p(i));
end
disp(N_teor);

%2.1 алгоритм с ожиданием при  неограниченном числом повторных передач
%для определения среднего числа повторных передач
for count = 1:length(p)
    n_sum = 0; % сумма всех повторынх передач для Nmax эксперементов
    Ni =0;
    while Ni<Nmax %количество сообщений
        recept =0; %квитанция
        i = 0; % кол-во повторных передач
        a = 1;
        while(recept~=1)%пока не придет положительная квитанция  
            e = error(p(count)); % возникновение ошибки с вероятность р
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


function e = error(p) %генерация вектора ошибок
    e=0;
    tmp = rand(1);
    if tmp<p
        e=1;
    end 
end