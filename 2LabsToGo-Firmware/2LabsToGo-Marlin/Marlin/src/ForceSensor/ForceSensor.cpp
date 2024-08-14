/*!
 * @file Adafruit_MPRLS.cpp
 *
 * @mainpage Adafruit MPRLS Pressure sensor
 *
 * @section intro_sec Introduction
 *
 * Designed specifically to work with the MPRLS sensor from Adafruit
 * ----> https://www.adafruit.com/products/3965
 *
 * These sensors use I2C to communicate, 2 pins (SCL+SDA) are required
 * to interface with the breakout.
 *
 * Adafruit invests time and resources providing this open source code,
 * please support Adafruit and open-source hardware by purchasing
 * products from Adafruit!
 *
 * @section dependencies Dependencies
 *
 *
 * @section author Author
 *
 * Written by Limor Fried/Ladyada for Adafruit Industries.
 *
 * @section license License
 *
 * MIT license, all text here must be included in any redistribution.
 *
 */
#include "string.h"
#if (ARDUINO >= 100)
#include "Arduino.h"
#else
#include "WProgram.h"
#endif
#include "Wire.h"
#include "../gcode/gcode.h"
#include "ForceSensor.h"
#include "../module/motion.h"
#include "../module/endstops.h"
#include "src/MarlinCore.h"


/**************************************************************************/
/*!
    @brief constructor initializes default configuration value
   skip
    @param PSI_min The minimum PSI measurement range of the sensor, default 0
    @param PSI_max The maximum PSI measurement range of the sensor, default 25
*/
/**************************************************************************/
ForceSensor::ForceSensor(uint16_t PSI_min, uint16_t PSI_max, uint16_t zero_offset) {
  _PSI_min = PSI_min;
  _PSI_max = PSI_max;
  _zero_offset = zero_offset;
  // getZero();
}

/**************************************************************************/
/*!
    @brief  setup and initialize communication with the hardware
    @param i2c_addr The I2C address for the sensor (default is 0x18)
    @param twoWire Optional pointer to the desired TwoWire I2C object. Defaults
   to &Wire
    @returns True on success, False if sensor not found
*/
/**************************************************************************/
void ForceSensor::begin(uint8_t i2c_addr, TwoWire *twoWire) {
    _i2c_addr = i2c_addr;
    _i2c = twoWire;

    _i2c->begin();

    this->getZero();
}


/**************************************************************************/
/*!
    @brief takes a digital value and convert it to force value
    @returns The measured force, is in Newtons
*/
/**************************************************************************/
double ForceSensor::digitalToForce(double digital_value){
    return (digital_value-_zero_offset)*44.4822/(16000-_zero_offset);
}


/**************************************************************************/
/*!
    @brief Converts Newton to psi for an Specific Syringe
    @returns The measured pressure, is in psi
*/
/**************************************************************************/
double ForceSensor::forceToPressure(double force){
    return (force/78.5)*145.038;
}


/**************************************************************************/
/*!
    @brief Apply a mean of size 50 with a moving averange of 10 
    @returns The measured force, is in Newtons
*/
/**************************************************************************/
double ForceSensor::readForce(void){
    double mean = overSampleAndMean(5);
    double moving_averange = movingAverange(mean);
    double force = digitalToForce(moving_averange);
    return force;
}

/**************************************************************************/
/*!
    @brief After readForceProcess retrieves the pressure 
    @returns The measured pressure, is in psi
*/
/**************************************************************************/
double ForceSensor::readPressure(void) {
    for(int i=0;i<9;i++){
       readForce();
    }
    return forceToPressure(readForce());
}


/**************************************************************************/
/*!
    @brief After readForceProcess retrieves the equivalent mass that would 
    create the same force because of gravity 
    @returns The measured pressure, is in psi
*/
/**************************************************************************/
double ForceSensor::readMass(void){
    return readForce()*1000/9.8;
}



int ForceSensor::getMaxPressureSensor(void){
    return MAX_PREASSURE_SENSOR;
}


/**************************************************************************/
/*!
    @brief Read 24 bits of measurement data from the device
    @returns -1 on failure (check status) or 24 bits of raw ADC reading
*/
/**************************************************************************/
double ForceSensor::sample(void) {
    int sample;

    _i2c->requestFrom(_i2c_addr, (uint8_t)2);
    delay(4);
    sample = Wire.read();
    sample <<= 8;
    sample |= Wire.read();
    sample = sample & 0x3FFF;

    return (double)sample;
}

double ForceSensor::overSampleAndMean(int number_of_samples){
    double mean=0;
    for(int i=0;i<number_of_samples;i++){
        mean += sample();
    }
    mean = mean/number_of_samples;
    return mean;
}

double ForceSensor::movingAverange(double sample){
    double result = 0.0;
    for(int i = windowsSize-1;i>0;i--){
        movingAverangeSamples[i] = movingAverangeSamples[i-1];
        result += movingAverangeSamples[i];
    }
    movingAverangeSamples[0] = sample/windowsSize;
    result+=movingAverangeSamples[0];
    return result;
}

void ForceSensor::getZero(void) {
    endstops.enable(true);
    if(isSyringeLoad()){
        SERIAL_ERROR_MSG("REMOVE THE SYRINGE AND RECONNECT!!!!");
        SERIAL_ECHOLN();
        minkill(true);
    }else{
        homeaxis(X_AXIS);
        _zero_offset = testingMeasure();
        SERIAL_ECHOLN("NEW ZERO SETTLED");
    }
}

bool ForceSensor::isSyringeLoad(){
//     double backmeasure, pressedmeassure;
    return false;
//     if(testingMeasure()>1300){
//         return true;
//     }
//     else{
//         float pos=current_position.z-1;
//         do_blocking_move_to_z(pos, G0_FEEDRATE/300);
//         backmeasure = testingMeasure();

//         pos=current_position.z+2;
//         do_blocking_move_to_z(pos, G0_FEEDRATE/300);
//         pressedmeassure=testingMeasure();
        
//         if(backmeasure+100<pressedmeassure){
//         return true;
//         }else{
//             return false;
//         }
//     }    
}

double ForceSensor::testingMeasure(){
    double measure;
    for(int i = 0;i<windowsSize;i++) movingAverangeSamples[i]=0;
    for(int i = 0;i<=windowsSize;i++){
            measure = movingAverange(overSampleAndMean(10));
        }
    return measure;
}
