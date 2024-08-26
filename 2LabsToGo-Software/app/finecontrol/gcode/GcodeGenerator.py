import time

INIT_POINT_X = 24
INIT_POINT_Y = 5.5

class GcodeGenerator:
    # set these values according to each machine!!!
    

    pos_common= "G0Z"
    vial_9= "145" #rinse bottle
    vial_8= "268.5" #vial 8
    vial_7= "254.5" #vial 7
    vial_6= "240.5" #vial 6
    vial_5= "226.5" #vial 5
    vial_4= "212.5" #vial 4
    vial_3= "198.5" #vial 3
    vial_2= "184.5" #vial 2
    vial_1= "170.5" #vial 1
    rin_bot= "145" #rinse bottle

    pos_vial9= pos_common + vial_9 #vial 9
    pos_vial8= pos_common + vial_8 #vial 8
    pos_vial7= pos_common + vial_7 #vial 7
    pos_vial6= pos_common + vial_6 #vial 6
    pos_vial5= pos_common + vial_5 #vial 5
    pos_vial4= pos_common + vial_4 #vial 4
    pos_vial3= pos_common + vial_3 #vial 3
    pos_vial2= pos_common + vial_2 #vial 2
    pos_vial1= pos_common + vial_1 #vial 1
    pos_rinbot= pos_common + rin_bot #rinse bottle

    hole_pos_vial9= pos_common + str(float(vial_9)+1.5) #vial 9
    hole_pos_vial8= pos_common + str(float(vial_8)+1.5) #vial 8
    hole_pos_vial7= pos_common + str(float(vial_7)+1.5) #vial 7
    hole_pos_vial6= pos_common + str(float(vial_6)+1.5) #vial 6
    hole_pos_vial5= pos_common + str(float(vial_5)+1.5) #vial 5
    hole_pos_vial4= pos_common + str(float(vial_4)+1.5) #vial 4
    hole_pos_vial3= pos_common + str(float(vial_3)+1.5) #vial 3
    hole_pos_vial2= pos_common + str(float(vial_2)+1.5) #vial 1
    hole_pos_vial1= pos_common + str(float(vial_1)+1.5) #vial 1
    hole_pos_rinbot= pos_common + str(float(rin_bot)+1.5) #rinse bottle


    positions= [pos_vial1, pos_vial2, pos_vial3, pos_vial4, pos_vial5, pos_vial6, pos_vial7, pos_vial8, pos_vial9, pos_rinbot]
    hole_positions= [hole_pos_vial1, hole_pos_vial2, hole_pos_vial3, hole_pos_vial4, hole_pos_vial5, hole_pos_vial6, hole_pos_vial7, hole_pos_vial8, hole_pos_vial9, hole_pos_rinbot]

    def __init__(self, save_in_list):
        self.list_of_gcodes = []
        self.save_in_list = save_in_list
        
    def check_return(self, gcode):
        if self.save_in_list:
            self.list_of_gcodes.append(gcode)
            return
        else:
            return gcode

    def linear_move_xyz(self, pos_x, pos_y, pos_z, speed):
        """"A linear move traces a straight line from one point to another, ensuring that the specified axes will arrive
        simultaneously at the given coordinates (by linear interpolation). The speed may change over time following an
        acceleration curve, according to the acceleration and jerk settings of the given axes."""
        if pos_x != "":
            pos_x = str(round(float(pos_x), 3))
        if pos_y != "":
            pos_y = str(round(float(pos_y), 3))
        if pos_z != "":
            pos_z = str(round(float(pos_z), 3))
        return self.check_return(f"G1X{pos_x}Y{pos_y}Z{pos_z}F{speed}")
        
    def linear_move_x(self, pos_x, speed):
        return self.linear_move_xyz(pos_x, "", "", speed)

    def linear_move_y(self, pos_y, speed):
        return self.linear_move_xyz("", pos_y, "", speed)

    def linear_move_z(self, pos_z, speed):
        return self.linear_move_xyz("", "", pos_z, speed)

    def linear_move_xy(self, pos_x, pos_y, speed):
        return self.linear_move_xyz(pos_x, pos_y, "", speed)

    def linear_move_xz(self, pos_x, pos_z, speed):
        return self.linear_move_xyz(pos_x, "", pos_z, speed)

    def linear_move_yz(self, pos_y, pos_z, speed):
        return self.linear_move_xyz("", pos_y, pos_z, speed)

    def wait_bed_temperature(self, temperature):
        """This command optionally sets a new target bed temperature and waits for the target temperature
        to be reached before proceeding. """
        return self.check_return(f"M190R{temperature}")

    def hold_bed_temperature(self, temperature):
        '''This command sets a new bed temperature and proceeds without waiting. The temperature will be held in the background'''
        return self.check_return(f"M140S{temperature}")

    def hold_incubation_temperature(self, temperature):
        '''This command sets a new  temperature and proceeds without waiting. The temperature will be held in the background'''
        return self.check_return(f"M104S{temperature}")    

    def report_bed_temperature(self, timeIntervall):
        '''
        It can be useful for host software to track temperatures, display and graph them over time, but polling with M105 is less than optimal. 
        With M155 hosts simply set an interval and Marlin will keep sending data automatically. This method is preferred over polling with M105.
        timeIntervall in seconds
        '''
        return self.check_return(f"M155S{timeIntervall}")

    def homming(self, axis):
        """Auto-home one or more axes, moving them towards their endstops until triggered."""
        return self.check_return(f"G28{axis.upper()}")
        
    def set_position_xyz(self, pos_x, pos_y, pos_z):
        """Set the current position to the values specified."""
        return self.check_return(f"G92X{pos_x}Y{pos_y}Z{pos_z}")

    def set_position_x(self, pos_x):
        """Set the current position to the values specified."""
        return self.check_return(f"G92X{pos_x}")

    def set_position_y(self, pos_y):
        """Set the current position to the values specified."""
        return self.check_return(f"G92Y{pos_y}")

    def set_position_z(self, pos_z):
        """Set the current position to the values specified."""
        return self.check_return(f"G92Z{pos_z}")

    def set_position_xy(self, pos_x, pos_y):
        """Set the current position to the values specified."""
        return self.check_return(f"G92X{pos_x}Y{pos_y}")

    def set_position_xz(self, pos_x, pos_z):
        """Set the current position to the values specified."""
        return self.check_return(f"G92X{pos_x}Z{pos_z}")

    def set_position_yz(self, pos_y, pos_z):
        """Set the current position to the values specified."""
        return self.check_return(f"G92Y{pos_y}Z{pos_z}")

    def finish_moves(self):
        """This command causes G-code processing to pause and wait in a loop until all
        moves in the planner are completed."""
        return self.check_return(f"M400")

    def pressurize(self, pressure):
        """This command increase the pressure in the system"""
        return self.check_return(f"G97P{pressure}")

    def open_valve_frequency(self, frequency):
        """This command open and close the valve at a certain frequency"""
        return self.check_return(f"G98F{frequency}")

    def close_valve(self):
        """This command closes the valve"""
        return self.check_return(f"G40")

    def open_valve(self):
        """This command opens the valve"""
        return self.check_return(f"G41")

    def set_pin_state(self, pin, state):
        """For custom hardware not officially supported in Marlin, you can often just connect
        up an unused pin and use M42 to control it."""
        return self.check_return(f"M42P{pin}S{state}")

    def start_pump(self):
        return self.check_return(f"M42P40S255")
    
    def stop_pump(self):
        return self.check_return(f"M42P40S0")

    def wait(self, time):
        """pauses the command queue and waits for a period of time in seconds"""
        return self.check_return(f"G4S{time}")
    
    def wait_ms(self, time):
        """pauses the command queue and waits for a period of time in miliseconds"""
        return self.check_return(f"G4P{time}")
    
    def set_relative(self):
        """In this mode all coordinates are interpreted as relative to the last position."""
        return self.check_return(f"G91")

    def set_absolute(self):
        """In absolute mode all coordinates given in G-code are interpreted as positions in the logical coordinate space."""
        return self.check_return(f"G90")

    def check_pressure(self):
        return self.check_return(f"G95P")

    def check_temperature_humidity(self):
        return self.check_return(f"G96")

    def time_stamp(self):
        return self.create_time_stamp()
    
    def static_cleaning(self, times, frequency):
        '''Rinse an amount of times with the rinsing solution'''
        self.check_return("M92Z400")
        self.check_return("M203Z40")
        self.check_return("M42P49S0")    #z-switch
        self.check_return("M42P36S0")    #3-way valve switch
        self.check_return("G0X1F5000")
        self.check_return(self.pos_rinbot)
        self.down_sample()
        self.finish_moves()
        for i in range(times):
            self.start_pump()
            
            self.finish_moves()
            self.stop_pump()
            
            self.finish_moves()
            self.open_valve_frequency(frequency)
            self.wait_ms(200)
        
        self.up()
        self.finish_moves()
        self.check_return("M203Z40")
        self.check_return("G28Z")
        self.finish_moves()

    def warmup_window(self, times, frequency):
        '''Warm up the nozzle with an amount of drops of rinsing solution'''
        
        self.check_return("M92Z400")
        self.check_return("M203Z40")
        self.check_return("M42P49S0")    #z-switch
        self.check_return("M42P36S0")    #3-way valve switch
        self.check_return("G28X")
        self.check_return("G0X1F5000")
        self.check_return("G28YZ")
        self.finish_moves()
        self.check_return(self.pos_rinbot)
        self.check_return("G0X1F5000")
        self.down_rinsing()
        self.finish_moves()        
        a = 0
        while (a < 4):
            self.start_pump()
            
            self.finish_moves()
            self.stop_pump()
            
            self.finish_moves()
            self.open_valve_frequency(2)
            a += 1        
        i = 0
        while (i < times):
            j = 0
            self.increase()
            while (j < 25):
                self.open_valve_frequency(frequency)
                self.wait_ms(200)
                self.finish_moves()
                j += 1
            self.open_valve_frequency(2)
            i += 1    
        self.up()
        self.finish_moves()
        self.stop_pump()
        self.finish_moves()
        self.check_return("G28Z")
        self.finish_moves()
        self.start_pump()
        self.finish_moves()

    def set_new_zero_position(self, x, y,speed):
        self.homming("XY")
        self.linear_move_xy(x, y, speed)
        self.set_position_xy(0, 0)
        self.finish_moves()    

    def rinsing(self, nozzlediameter):
        '''Rinse 8 times with the rinsing solution'''
        self.check_return("M92Z400")     #Set Axis Steps-per-unit
        self.check_return("M203Z40")     #set max feedrate
        self.check_return("M42P49S0")    #z-switch
        self.check_return("M42P36S0")    #3-way valve switch
        self.check_return("G0X1F5000")
        self.check_return(self.pos_rinbot)
        self.down_sample()
        self.finish_moves() 
        if nozzlediameter == '0.08':
            j = 42
        elif nozzlediameter == '0.10':
            j = 23
        elif nozzlediameter == '0.13':
            j = 18
        elif nozzlediameter == 'atomizer 67k':
            j = 1   
        i = 0
        while (i < 6):            
            j_cont = 0
            while (j_cont < j): 
                self.start_pump()
                self.finish_moves()
                self.stop_pump()
                self.finish_moves()
                self.open_valve_frequency(2)
                j_cont += 1            
            i += 1
        self.up()
        self.finish_moves()

    def set_new_zero_position(self, x, y,speed):
        self.homming("XY")
        self.linear_move_xy(x, y, speed)
        self.set_position_xy(0, 0)
        self.finish_moves()

    def set_new_zero_position_x(self, x, speed):
        self.homming("X")
        self.linear_move_x(x, speed)
        self.set_position_x(7.5)
        self.finish_moves()

    def set_new_zero_position_y(self, y, speed):
        self.homming("Y")
        self.linear_move_y(y, speed)
        self.set_position_y(1)
        self.finish_moves()
   
    def up(self):
        '''Take off the needle from the vial'''
        return self.check_return(f"G0E0")
    
    def down_rinsing(self):
        '''Inject the needle on the vial'''
        return self.check_return(f"G0E44")
    
    def down_sample(self):
        '''Inject the needle on the vial'''
        return self.check_return(f"G0E47")

    def sample_rinsing(self,frequency, nozzlediameter): 
        '''Rinse X times with the sample and then warm up the nozzle with 200 sample drops '''
        self.check_return("G0X1F5000")
        
        if nozzlediameter == '0.08':
            j = 23
        elif nozzlediameter == '0.10':
            j = 13
        elif nozzlediameter == '0.13':
            j = 10
        elif nozzlediameter == 'atomizer 67k':
            j = 1
        i = 0
        while (i < 6):            
            j_cont = 0
            while (j_cont < j):
                self.start_pump()
                self.finish_moves()
                self.stop_pump()
                self.finish_moves()
                self.open_valve_frequency(2)
                j_cont += 1             
            i += 1
        k = 0        
        while (k < 0):
            self.start_pump()
            self.finish_moves()
            self.stop_pump()
            self.finish_moves()
            m = 0
            while (m < 25 ):
                self.open_valve_frequency(frequency)
                self.finish_moves()
                self.wait_ms(200)
                m += 1
            self.open_valve_frequency(2)
            self.finish_moves()
            k += 1        
        self.increase()
        self.finish_moves()

    def increase(self):
        '''Start the pump three times to increase the pressure'''
        i=0
        while(i < 1):
            self.start_pump()
            self.finish_moves()
            self.stop_pump()
            self.finish_moves()
            i += 1
        self.finish_moves()
    
    def application(self,frequency,list_of_bands,waitTime,speed,list_sample,rinsingPeriod, nozzlediameter): 
        self.check_return("M92Z400")    #Set Axis Steps-per-unit
        self.check_return("M203Z40")    #max feedrate
        self.check_return("M42P49S0")   #z-switch
        self.check_return("M42P36S0")   #3-way valve switch
        
        i = 0
        temp = 0
        mod = 0
        step = 0
        decrement = rinsingPeriod

        for band in list_of_bands:
            if i == 0 or list_sample[i] != list_sample[i-1]:  
                self.check_return("G0X1F5000")
                self.check_return(self.hole_positions[list_sample[i] - 1])
                self.check_return("G0E11")
                self.finish_moves()
                self.up()
                self.finish_moves()
                self.check_return(self.positions[list_sample[i] - 1])
                self.down_rinsing()
                self.finish_moves()        
            aux = list_sample[i]
            flag = 0
            if (i != (len(list_sample)-1)):
                if (aux == list_sample[i+1]):
                    flag = 1
                    if (mod == 0):
                        temp = 1
                        step = 1  
                else:
                    flag = 0
                    temp = 0
                    mod = 0
            elif (len(list_sample) == 1):
                flag = 4
                self.sample_rinsing(frequency, nozzlediameter)
                
            else:
                if (aux == list_sample[i-1]):
                    flag = 3
                
            if (temp == 1):
                self.sample_rinsing(frequency, nozzlediameter)
                temp = 0
                mod = 1 
            if (flag == 0 and step != 1):
                self.sample_rinsing(frequency, nozzlediameter)
            elif(step == 1 and flag == 0):
                step = 0
            direction_y = 0
            decrement = rinsingPeriod
            for list_of_points in band:
                self.increase()
                decrement = decrement-1
                for point in list_of_points:                      
                    if (direction_y - point[0]) > 0:
                        self.wait(waitTime)
                    self.linear_move_xy(point[0]+INIT_POINT_X, point[1]+INIT_POINT_Y, speed) #change the values corresponds to the 0,0 position
                    self.finish_moves()
                    self.open_valve_frequency(frequency)
                    self.finish_moves()
                    direction_y = point[0]
                if decrement == 0:
                    self.check_return("G0X1F5000")
                    self.finish_moves()
                    self.open_valve_frequency(2)
                    decrement = rinsingPeriod
            if (flag == 0 or flag == 3 or flag == 4):
                self.up()
                self.finish_moves()         
                self.rinsing(nozzlediameter) 
            i += 1
        self.check_return("M42P37S0")

    def load_vials(self):
        '''Load/Unload the vials'''
        self.check_return("G0X1F5000")
        self.check_return("G0E0")
        self.check_return("G28Z")
        self.finish_moves()

class GcodeGeneratorSP:   #syringe pump

    def __init__(self, save_in_list):
        self.list_of_gcodes = []
        self.save_in_list = save_in_list

    def check_return(self, gcode):
        if self.save_in_list:
            self.list_of_gcodes.append(gcode)
            return
        else:
            return gcode

    def linear_move_xyz(self, pos_x, pos_y, pos_z, speed):
        """"A linear move traces a straight line from one point to another, ensuring that the specified axes will arrive
        simultaneously at the given coordinates (by linear interpolation). The speed may change over time following an
        acceleration curve, according to the acceleration and jerk settings of the given axes."""
        if pos_x != "":
            pos_x = str(round(float(pos_x), 3))
        if pos_y != "":
            pos_y = str(round(float(pos_y), 3))
        if pos_z != "":
            pos_z = str(round(float(pos_z), 3))
        return self.check_return(f"G1X{pos_x}Y{pos_y}Z{pos_z}F{speed}")

    def linear_move_x(self, pos_x, speed):
        return self.linear_move_xyz(pos_x, "", "", speed)

    def linear_move_y(self, pos_y, speed):
        return self.linear_move_xyz("", pos_y, "", speed)

    def linear_move_z(self, pos_z, speed):
        return self.linear_move_xyz("", "", pos_z, speed)

    def linear_move_xy(self, pos_x, pos_y, speed):
        return self.linear_move_xyz(pos_x, pos_y, "", speed)

    def linear_move_xz(self, pos_x, pos_z, speed):
        return self.linear_move_xyz(pos_x, "", pos_z, speed)

    def linear_move_yz(self, pos_y, pos_z, speed):
        return self.linear_move_xyz("", pos_y, pos_z, speed)

    def wait_bed_temperature(self, temperature):
        """This command optionally sets a new target bed temperature and waits for the target temperature
        to be reached before proceeding. """
        return self.check_return(f"M190R{temperature}")

    def hold_bed_temperature(self, temperature):
        '''This command sets a new bed temperature and proceeds without waiting. The temperature will be held in the background'''
        return self.check_return(f"M140S{temperature}")

    def report_bed_temperature(self, timeIntervall):
        '''
        It can be useful for host software to track temperatures, display and graph them over time, but polling with M105 is less than optimal. 
        With M155 hosts simply set an interval and Marlin will keep sending data automatically. This method is preferred over polling with M105.
        timeIntervall in seconds
        '''
        return self.check_return(f"M155S{timeIntervall}")


    def homming(self, axis):
        """Auto-home one or more axes, moving them towards their endstops until triggered."""
        return self.check_return(f"G28{axis.upper()}")

    def set_position_xyz(self, pos_x, pos_y, pos_z):
        """Set the current position to the values specified."""
        return self.check_return(f"G92X{pos_x}Y{pos_y}Z{pos_z}")

    def set_position_x(self, pos_x):
        """Set the current position to the values specified."""
        return self.check_return(f"G92X{pos_x}")

    def set_position_y(self, pos_y):
        """Set the current position to the values specified."""
        return self.check_return(f"G92Y{pos_y}")

    def set_position_z(self, pos_z):
        """Set the current position to the values specified."""
        return self.check_return(f"G92Z{pos_z}")

    def set_position_xy(self, pos_x, pos_y):
        """Set the current position to the values specified."""
        return self.check_return(f"G92X{pos_x}Y{pos_y}")

    def set_position_xz(self, pos_x, pos_z):
        """Set the current position to the values specified."""
        return self.check_return(f"G92X{pos_x}Z{pos_z}")

    def set_position_yz(self, pos_y, pos_z):
        """Set the current position to the values specified."""
        return self.check_return(f"G92Y{pos_y}Z{pos_z}")

    def finish_moves(self):
        """This command causes G-code processing to pause and wait in a loop until all
        moves in the planner are completed."""
        return self.check_return(f"M400")

    def pressurize(self, pressure):
        """This command increase the pressure in the system"""
        return self.check_return(f"G97P{pressure}")

    def open_valve_frequency(self, frequency):
        """This command open and close the valve at a certain frequency"""
        return self.check_return(f"G98F{frequency}")

    def close_valve(self):
        """This command closes the valve"""
        return self.check_return(f"G40")

    def open_valve(self):
        """This command opens the valve"""
        return self.check_return(f"G41")

    def set_pin_state(self, pin, state):
        """For custom hardware not officially supported in Marlin, you can often just connect
        up an unused pin and use M42 to control it."""
        return self.check_return(f"M42P{pin}S{state}")
    
    def wait(self, time):
        """pauses the command queue and waits for a period of time in seconds"""
        return self.check_return(f"G4S{time}")
    
    def wait_ms(self, time):
        """pauses the command queue and waits for a period of time in miliseconds"""
        return self.check_return(f"G4P{time}")
    
    def set_relative(self):
        """In this mode all coordinates are interpreted as relative to the last position."""
        return self.check_return(f"G91")

    def set_absolute(self):
        """In absolute mode all coordinates given in G-code are interpreted as positions in the logical coordinate space."""
        return self.check_return(f"G90")

    def check_pressure(self):
        return self.check_return(f"G95P")

    def rinsing(self):
        self.check_return("M92Z1600")     #Set Axis Steps-per-unit, syringe pump motor
        self.check_return("M203Z5")       #max feedrate
        self.check_return("M42P49S255")   #z-switch
        self.check_return("M42P36S255")   #3-way valve switch
        self.check_return("G0X1F5000")
        self.pressurize("10")
        self.open_valve_frequency("2")

    def set_new_zero_position(self, x, y,speed):
        self.homming("XY")
        self.linear_move_xy(x, y, speed)
        self.set_position_xy(0, 0)
        self.finish_moves()

    def set_new_zero_position_x(self, x, speed):
        self.homming("X")
        self.linear_move_x(x, speed)
        self.set_position_x(0)
        self.finish_moves()

    def set_new_zero_position_y(self, y, speed):
        self.homming("Y")
        self.linear_move_y(y, speed)
        self.set_position_y(0)
        self.finish_moves()

    

