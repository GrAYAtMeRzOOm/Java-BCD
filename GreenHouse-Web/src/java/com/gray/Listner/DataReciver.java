/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.gray.Listner;

import com.google.gson.Gson;
import com.gray.dao.SensorDataDao;
import com.gray.greenhouse.model.SensorData;
import com.oracle.wls.shaded.org.apache.bcel.generic.AALOAD;
import java.util.Timer;
import java.util.TimerTask;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.jms.Connection;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.MessageProducer;
import javax.jms.Queue;
import javax.jms.QueueConnection;
import javax.jms.QueueConnectionFactory;
import javax.jms.QueueReceiver;
import javax.jms.QueueSession;
import javax.jms.Session;
import javax.jms.TextMessage;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

/**
 *
 * @author grays
 */
@WebListener
public class DataReciver implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("--------[Web Listen in Background]------------");
        try {
            InitialContext context = new InitialContext();
            QueueConnectionFactory factory = (QueueConnectionFactory) context.lookup("GreenHouseInfo-Queue");
            Queue queue = (Queue) context.lookup("GreenHouseInfoDestination");
            QueueConnection connection = factory.createQueueConnection();
            connection.start();
            QueueSession session = connection.createQueueSession(false, Session.AUTO_ACKNOWLEDGE);
            run(factory, queue,session);
        } catch (NamingException ex) {
            Logger.getLogger(DataReciver.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JMSException ex) {
            Logger.getLogger(DataReciver.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    private void run(QueueConnectionFactory factory, Queue queue,QueueSession session) {
        Timer timer = new Timer();
        TimerTask task = new TimerTask() {
            @Override
            public void run() {
                try {
                    QueueReceiver receiver = session.createReceiver(queue);
                    receiver.setMessageListener(new MessageListener() {
                        @Override
                        public void onMessage(Message e) {
                            try {
                                System.out.println("------------[" + e.getBody(String.class) + "]-----------");
                                Gson gson = new Gson();
                                SensorData sd = gson.fromJson(e.getBody(String.class), SensorData.class);
                                SensorDataDao.addSensorData(sd);
                            } catch (JMSException ex) {
                                ex.printStackTrace();
                            }
                        }
                    });

                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        };
        timer.scheduleAtFixedRate(task, 0, 5000);
    }

}
