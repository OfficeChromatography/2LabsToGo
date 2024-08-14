extern ForceSensor force ;
class PumpControl{
  private:
    int ABSOLUTE_MAX_PRESSURE = 50;
    int ABSOLUTE_MIN_PRESSURE = 1;
    //float GAIN = 0.03;
    //int LIMIT_PRESSURE_CHANGE_CALCULATION = 20;

    float pressure_read = force.readPressure();
    float pos=current_position.z;
    float pressure_set;
    float min_pressure;
    float max_pressure;
    bool toHigh;
    bool toLow;

    int errorFunction(float set, float real);
    void calculateNewPosition();
    void move();
    bool is_out_of_range();

  public:
    void compute();
    PumpControl(float pressure_set);
};