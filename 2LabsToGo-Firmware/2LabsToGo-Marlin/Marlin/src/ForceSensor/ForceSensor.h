#include "Arduino.h"
#include "Wire.h"


#define FORCE_DEFAULT_ADDR (0x28)   ///< Most common I2C address
#define SIZE_DEFAULT_MOVING_AVERANGE 10    ///< Most common I2C address
/**************************************************************************/
/*!
    @brief  Class that stores state and functions for interacting with ForceSensor
*/
/**************************************************************************/
class ForceSensor {
public:
  ForceSensor(uint16_t PSI_min = 0, uint16_t PSI_max = 10, uint16_t zero_offset = 1060);

  void begin(uint8_t i2c_addr = FORCE_DEFAULT_ADDR,
                TwoWire *twoWire = &Wire);

  double readPressure(void);
  double readForce(void);
  double readMass(void);
  double sample(void);
  double overSampleAndMean(int number_of_samples);
  double movingAverange(double marcel);
  int getMaxPressureSensor();

  double digitalToForce(double digital_value);
  double forceToPressure(double force);
  double movingAverangeSamples[SIZE_DEFAULT_MOVING_AVERANGE];

private:
    int windowsSize = SIZE_DEFAULT_MOVING_AVERANGE;

    int MAX_PREASSURE_SENSOR = 80;

    double _zero_offset;
    uint8_t _i2c_addr;
    void getZero(void);
    bool isSyringeLoad(void);
    double testingMeasure(void);
    // int movingAverangeSamples[SIZE_DEFAULT_MOVING_AVERANGE];

    uint32_t _PSI_min, _PSI_max;

    TwoWire *_i2c;
};

