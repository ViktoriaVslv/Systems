clc, clear, close all

%2.4 алгоритм с ожиданием для определения коэффициента
% использования канала
f1 = fopen('log.txt', 'wb'); %файл в который пишется лог

tau = 3;
p = 0:0.1:1;

Tmax = 1000; %максимальное время работы программы
Nmax=100;  % максимальное кол-во отправляемых сообщений

nu = zeros(1,length(p));

for count = 1:length(p)  
    fprintf(f1, "p = "+p(count)+"\n"); 
    Ni =0;
    T = 0;
    while (Ni<Nmax) && (T<Tmax) %количество сообщений
        recept =0; %квитанция
        a = 1; % сообщение
        
        while(recept~=1) && (T<Tmax)%пока не придет положительная квитанция или не истечет время работы
            fprintf(f1, "Time: "+T+" mes #" + (Ni+1) +" send \n");
            
            T=T+1;
            fprintf(f1,"Time: "+T+" mes #" +(Ni+1) +" receive \n");
            e = error(p(count)); % возникновение ошибки с вероятность р
            b = rem(a+e,2);
            if a==b 
                recept = 1;
            end
           
            T=T+tau;
            fprintf(f1,"Time: "+T+" mes #" + (Ni+1) +", recept - "+ recept +"\n");
        end
         Ni = Ni+1;
    end
    %disp(Ni);
    %disp(T);
    nu(count) = Ni/T;
end

nu_teor = zeros(1,length(p));
for i=1:length(p)
    nu_teor(i)= (1-p(i))/(1+tau); %
end

disp(nu);
figure(3);
hold on;
plot(p, nu, 'b');
plot(p, nu_teor, 'r');
grid on;
xlabel('p');
ylabel('nu');

fclose(f1);

function e = error(p) %генерация вектора ошибок
    e=0;
    tmp = rand(1);
    if tmp<p
        e=1;
    end 
end

