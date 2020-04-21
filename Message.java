package Systems;

import java.io.FileWriter;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Message extends Thread {
    private int tau;
    private int num;
    private double p;
    private boolean recept;



    public Message(int tau, int num, double p){
        this.tau = tau;
        this.num = num;
        this.p = p;
        recept = false;
    }

    @Override
    public void run()  {
        try {
//            FileWriter log = new FileWriter("log.txt",true);
//            log.write("Mes "+num+" received\n");
//            log.close();
            int a = 1; //отправляемое сообщение
            int b= (a+error())%2; // полученое сообщение с вероятностью возникновения ошибки р
            if (a==b) // если не произошло ошибки отправляется положительная квитанция
                recept = true;
            this.sleep(tau*20+2);// имитация времени получения квитанции
        }
        catch (InterruptedException e) {
            System.out.println(e.getMessage());
        }
//        catch (IOException e) {
//            System.out.println(e.getMessage());
//        }
    }
    private int error(){ // функция возникновения ошибки с вероятностью р
        int e=0;
        double tmp =Math.random() ;
        if (tmp<p)
                e=1;
        return e;
    }
    public int getNum(){return  num;}
    public boolean getRecept(){return  recept;}

}
