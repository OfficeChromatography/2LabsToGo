#!/usr/bin/env python3
#home-all.py

import serial
import time

def command(ser, command):
  ser.write(str.encode(command)) 
  time.sleep(1)

ser = serial.Serial('/dev/ttyAMA1', 115200)
time.sleep(2)
command(ser, "G96\r\n")
float humidity = 0;
humidity = dht.readHumidity(true);
print(humidity)

ser.close()
