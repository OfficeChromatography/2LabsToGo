#include "openValve.h"
#include "string.h"
#if (ARDUINO >= 100)
#include "Arduino.h"
#else
#include "WProgram.h"
#endif
#include "Wire.h"
#include "../gcode/gcode.h"

ValveOpen::ValveOpen(){
    maxFrequency = 1400;
    pin = 37;
    open = false;
    closingTime = 0;
    MaxOpenPeriod = 30000; // in ms
}

void ValveOpen::toggleValve(){
    if (open) {
        closeValve();
    } else {
        openValve();
    }
}

void ValveOpen::openValve(){
    open = true;
    extDigitalWrite(pin, 1);
    analogWrite(pin, 255);
    setClosingTime(millis());
    //extDigitalWrite(17, 1);
    //analogWrite(17, 255);
}

void ValveOpen::closeValve(){
    open = false;
    extDigitalWrite(pin, 0);
    analogWrite(pin, 0);
    //extDigitalWrite(17, 0);
    //analogWrite(17, 0);
}

bool ValveOpen::isOpen(){
    return open;
}

void ValveOpen::setClosingTime(millis_t ms){
    closingTime = ms + MaxOpenPeriod;
}

millis_t ValveOpen::getClosingTime(){
    return closingTime;
}

void ValveOpen::securityCheck(){
    if(open && ELAPSED(millis(), getClosingTime())){
        closeValve();
    }
}

// one complete cicle of valve open and close at a certain frequency
void ValveOpen::frequencyToggleValve(int frequency){
    openValve();
    delayFromFrequency(frequency);
    closeValve();
    delayFromFrequency(frequency);
}

void ValveOpen::delayFromFrequency(int frequency){
    if(frequency<500){
        delay(500/frequency);
    }
    else{
        delayMicroseconds(500000/frequency);
    }
}

int ValveOpen::getMaxFrequency(){
    return maxFrequency;
}