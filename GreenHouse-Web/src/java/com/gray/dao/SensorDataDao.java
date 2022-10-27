/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.gray.dao;

import com.gray.greenhouse.model.SensorData;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author grays
 */
public class SensorDataDao {

    private static List<SensorData> sensordataLsit;

    static {
        sensordataLsit = new ArrayList<SensorData>();
    }

    public static List<SensorData> getSensordataLsit() {
        return sensordataLsit;
    }

    public static void addSensorData(SensorData data) {
        if (data != null) {
            sensordataLsit.add(data);
        }
    }
}
