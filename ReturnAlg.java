package Systems;

import java.io.FileWriter;
import java.io.IOException;

public class ReturnAlg {
// алгорит с возвратом
    public  static void main (String [] args){
        try {

            int time =20;
            int tau = 2; // время задержки
            double[] p = new double[11];  // вероятности ошобки в прямом канале
            for (int i = 0; i < p.length; i++) {
                p[i] =(double) i / 10;
            }

            int Tmax = 100; // максиальное время работы цикла в единицах времени
            int Nmax = 30; // максимальное кол-во сообщений передаваемых
            double[] nu = new double[p.length]; // практ. коэф. использ. канала
            double[] nu_teor = new double[p.length]; // теор.  коэф. использ. канала


            for (int i = 0; i < p.length; i++)
                nu_teor[i] =(double) (1 - p[i]) / (1 + tau * p[i]);

            for (int i = 0; i < p.length; i++) { // цикл по всем вероятностях ошибки в канале
//                FileWriter log = new FileWriter("log.txt", true);
//                log.write("________ p ="+i+" ___________\n");
//                log.close();
                int Ni = 0; // номер сообщения
                int T = 0; // время
                Message[] mes = new Message[tau+1]; // создание tau+1 потоков для передачи сообщений

                for(int j=0; j<tau+1; j++) { // отправка первых tau+1 сообщений
                    mes[j] = new Message(tau, Ni, p[i]);
//                    log = new FileWriter("log.txt", true);
//                    log.write("Mes " + Ni + " send\n");
//                    log.close();
                    mes[j].start();
                    mes[j].sleep(time); // имитация времени отправки сообщения
                    T++;
                    Ni++;
                }
                while ((Ni < Nmax) && (T < Tmax)) { // цикл пока не наступит условия остановки
                    for (int j = 0; j < tau + 1; j++) { // цикл по потокам
                        if (!mes[j].isAlive()) { // проверка на завершение работы потока, т.е доставку квитанции
                            if (!mes[j].getRecept()) { // если квитанция отрицательная
//                                log = new FileWriter("log.txt", true);
//                                log.write("        Mes "+mes[j].getNum()+" - recept: "+mes[j].getRecept()+"\n");
//                                log.close();
                                T++;
                                Ni = mes[j].getNum();
                                mes[j] = new Message(tau, Ni, p[i]); // повторная отправка сообщения с тем же номером
//                                log = new FileWriter("log.txt", true);
//                                log.write("Mes " + Ni + " send\n");
//                                log.close();
                                mes[j].start();
                                mes[j].sleep(time);
                                Ni++;
                                for(int n=0; n<tau; n++) { // цикл для повторной отправкии сообщений следующих за не успешно полученным сообщением
                                    mes[(j+n+1)%(tau+1)] = new Message(tau, Ni, p[i]);
//                                    log = new FileWriter("log.txt", true);
//                                    log.write("Mes " + Ni + " send\n");
//                                    log.close();
                                    //System.out.println("Mes " + Ni + " send");
                                    mes[(j+n+1)%(tau+1)].start();
                                    mes[(j+n+1)%(tau+1)].sleep(time);
                                    T++;
                                    Ni++;
                                }
                            }
                            else { // если пришла положительная квитанция
//                                log = new FileWriter("log.txt", true);
//                                log.write("        Mes "+mes[j].getNum()+" - recept: "+mes[j].getRecept()+"\n");
//                                log.close();
                                mes[j] = new Message(tau, Ni, p[i]); // отправляется следующее сообщение
//                                log = new FileWriter("log.txt", true);
//                                log.write("Mes " + Ni + " send\n");
//                                log.close();
                                mes[j].start();
                                mes[j].sleep(time);
                                T++;
                                Ni++;
                            }
                        }
                    }
                }
                for(int j=0; j<tau+1; j++)
                    mes[j].join();
                if(T>=Tmax){
                    Ni=mes[0].getNum();
                    T=Tmax;
                }
                nu[i] =(double) Ni / T; // практ. коэф. использ. канала
            }

            for (int i = 0; i < p.length; i++)
                System.out.print(nu_teor[i]+" ");
            System.out.println(" ");
            for (int i = 0; i < p.length; i++)
                System.out.print(nu[i]+" ");
            System.out.println(" ");


        }
        catch (InterruptedException e) {
            System.out.println(e.getMessage());
        }
//        catch (IOException e) {
//            System.out.println(e.getMessage());
//        }


    }
}
