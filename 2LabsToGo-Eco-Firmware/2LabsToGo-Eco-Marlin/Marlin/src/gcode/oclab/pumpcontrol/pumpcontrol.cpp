#include "src/module/endstops.h"
#include "src/MarlinCore.h"
#include "src/ForceSensor/ForceSensor.h"
#include "src/module/motion.h"
#include "pumpcontrol.h"

extern ForceSensor force ;
extern xyze_pos_t current_position;

int PumpControl::errorFunction(float set, float real){
  int error = abs(set - real);
  return (error)<1?(1):(error);
}
    
void PumpControl::calculateNewPosition()
{
	if (pressure_set <= 10)
	{
		if(pressure_read< min_pressure)
		{
			int error = errorFunction(min_pressure, pressure_read);
			pos+=(0.001*error);
		}
		if(pressure_read > max_pressure)
		{
			int error = errorFunction(max_pressure, pressure_read);
			pos-=(0.001*error);
		}
	}
	if (pressure_set >10 and pressure_set <= 24)
	{
		if(pressure_read< min_pressure)
		{
			int error = errorFunction(min_pressure, pressure_read);
			pos+=(0.005*error);
		}
		if(pressure_read > max_pressure)
		{
			int error = errorFunction(max_pressure, pressure_read);
			pos-=(0.005*error);
		}
	}
	else // > 24 psi
	{
		if(pressure_read< min_pressure)
		{
			int error = errorFunction(min_pressure, pressure_read);
			pos+=(0.01*error);
		}
		if(pressure_read > max_pressure)
		{
			int error = errorFunction(max_pressure, pressure_read);
			pos-=(0.01*error);
		}
	}
}

void PumpControl::move(){
  endstops.enable(true);
  do_blocking_move_to_z(pos, G0_FEEDRATE/500);
  pressure_read = force.readPressure();
  SERIAL_ECHOPAIR("Ps: ", pressure_set);
  SERIAL_ECHOLNPAIR("\tPr: ", pressure_read);
}

PumpControl::PumpControl(float pressure_set){
  toHigh = pressure_set > ABSOLUTE_MAX_PRESSURE;
  toLow = pressure_set < ABSOLUTE_MIN_PRESSURE;

  if(!is_out_of_range()){
    this->pressure_set = pressure_set;
    if(pressure_set<=10)  //<=LIMIT_PRESSURE_CHANGE_CALCULATION)
    {
      min_pressure = pressure_set*0.975;      //-1;
      max_pressure = pressure_set*1.025;     //+1;
    }
    if(pressure_set>10 and pressure_set <=24)  //>LIMIT_PRESSURE_CHANGE_CALCULATION)
    {
      min_pressure = pressure_set*0.9625;
      max_pressure = pressure_set*1.0375; 
    }
    else{
      min_pressure = pressure_set*0.95;
      max_pressure = pressure_set*1.05;
    }
  }
}

bool PumpControl::is_out_of_range(){
  if(toHigh || toLow){
    if(toHigh){
      SERIAL_ECHOLN("Pressure settled too high!!");
    }else{
      SERIAL_ECHOLNPAIR("Pressure settled too low, must be greater than ",this->ABSOLUTE_MIN_PRESSURE);
    }
    return true;
  }
  return false;
}

void PumpControl::compute(){
  if(!is_out_of_range()){
    while(pressure_read<min_pressure || pressure_read>=max_pressure){
      calculateNewPosition();
      if(pressure_read < ABSOLUTE_MAX_PRESSURE){
        move();
      }else{
        SERIAL_ECHOLN("Pressure is too high!!");
        break;
      }
    }
  }
}

