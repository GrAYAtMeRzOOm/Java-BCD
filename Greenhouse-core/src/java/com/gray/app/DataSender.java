/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.gray.app;

import com.google.gson.Gson;
import com.gray.greenhouse.model.SensorData;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.Resource;
import javax.jms.Connection;
import javax.jms.JMSException;
import javax.jms.MessageProducer;
import javax.jms.ObjectMessage;
import javax.jms.Queue;
import javax.jms.QueueConnection;
import javax.jms.QueueConnectionFactory;
import javax.jms.QueueSession;
import javax.jms.Session;
import javax.jms.TextMessage;
import javax.jms.Topic;
import javax.jms.TopicConnectionFactory;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author grays
 */
@WebServlet(name = "DataSender", urlPatterns = {"/data"})
public class DataSender extends HttpServlet {

    @Resource(lookup = "GreenHouseInfo-Queue")
    private QueueConnectionFactory connectionFactory;

    @Resource(mappedName = "GreenHouseInfoDestination")
    private Queue queue;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//      reciving parameters      (Temperature, Humidity, Moisture and Light)
        String temp = request.getParameter("Temperature");
        String moisture = request.getParameter("Moisture");
        String light = request.getParameter("Light");
        String humidity = request.getParameter("Humidity");
        
//      binding to model     (Temperature, Humidity, Moisture and Light)
        SensorData sensorData = new SensorData(temp, humidity, moisture, light);
        Gson gson = new Gson();
        System.out.println("Data Recived : "+gson.toJson(sensorData));
        try {
            QueueConnection connection = connectionFactory.createQueueConnection();
            QueueSession session = connection.createQueueSession(false, Session.AUTO_ACKNOWLEDGE);
            MessageProducer producer = session.createProducer(queue);
            
            TextMessage tm = session.createTextMessage();
//          binding to message as text messsage     (Temperature, Humidity, Moisture and Light)
            tm.setText(gson.toJson(sensorData));
            producer.send(tm);

        } catch (JMSException ex) {
            Logger.getLogger(DataSender.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
