/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.gray.greenhouse.model;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 *
 * @author grays
 */
public class SensorData implements Serializable {
//    (Temperature, Humidity, Moisture and Light)
    private Timestamp timestamp;
    private String temperature;
    private String humidity;
    private String moisture;
    private String light;

    public SensorData(String temperature, String humidity, String moisture, String light) {
        timestamp = new Timestamp(System.currentTimeMillis());
        this.temperature = temperature;
        this.humidity = humidity;
        this.moisture = moisture;
        this.light = light;
    }

    public SensorData() {
        timestamp = new Timestamp(System.currentTimeMillis());
    }

    public String getTemperature() {
        return temperature;
    }

    public void setTemperature(String temperature) {
        this.temperature = temperature;
    }

    public String getHumidity() {
        return humidity;
    }

    public void setHumidity(String humidity) {
        this.humidity = humidity;
    }

    public String getMoisture() {
        return moisture;
    }

    public void setMoisture(String moisture) {
        this.moisture = moisture;
    }

    public String getLight() {
        return light;
    }

    public void setLight(String light) {
        this.light = light;
    }

}
