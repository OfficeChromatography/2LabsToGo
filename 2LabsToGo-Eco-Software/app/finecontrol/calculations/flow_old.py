import math


class Flow:
    def __init__(self, pressure, nozzle_diameter, time_or_frequency, fluid, density, viscosity):
        """
        density [g/cm^3]
        pressure [psi]
        nozzleDiameter ['0.xxmm']
        timeOrFrequency [s] or [Hz]
            used in sample app as frequency [Hz]
            used in development as time [s]
        """

        """density [g/cm**3]"""
        density_table = {
            "Water": 1,
            "Methanol": 0.792,
            "Acetone": 0.784,
            "2-Butanol": 0.810,
            'n-Hexane': 0.655,
            'Pentane': 0.6209,
            'Cyclohexane': 0.779,
            'Carbon Tetrachloride': 1.589,
            'Toluene': 0.867,
            'Chloroform': 1.49,
            'Dichloromethane': 1.33,
            'Diethyl ether': 0.713,
            'Ethyl acetate': 0.902,
            'Ethanol': 0.789,
            'Pyridine': 0.982,
        }
        if fluid != 'Specific':
            fluid_density = density_table[fluid]
        else:
            fluid_density = float(density)
            viscosity = float(viscosity)

        self.pressure = pressure
        self.timeOrFrequency = time_or_frequency
        self.density = fluid_density
        if nozzle_diameter == '0.25':
            self.nozzle_lohms = 7500
        elif nozzle_diameter == '0.19':
            self.nozzle_lohms = 15400
        elif nozzle_diameter == '0.13':
            self.nozzle_lohms = 35000
        elif nozzle_diameter == '0.10':
            self.nozzle_lohms = 60000
        elif nozzle_diameter == '0.08':
            self.nozzle_lohms = 125000
        elif nozzle_diameter == '0.05':
            self.nozzle_lohms = 280000
        elif nozzle_diameter == 'atomizer 22k':
            self.nozzle_lohms = 22000
        elif nozzle_diameter == 'atomizer 67k':
            self.nozzle_lohms = 67000

    def calcFlow(self):
        """
        flowRateI [ul/s]
        """
        unit_conversion_constant_k = 75700
        lohms = math.sqrt(self.nozzle_lohms ** 2 + 4750 ** 2 + 2100 ** 2 + 700 ** 2)

        # empirically determined correction factor
        correction_factor = self.pressure/40

        # flow rate in ul per s
        flow_rate_i = correction_factor * unit_conversion_constant_k / lohms * math.sqrt(
            self.pressure / self.density) / 60 * 1000
        return flow_rate_i

    def calcVolumeFrequency(self):
        """
        calculates the volume for one opening of the valve
        volume [ul] (SampleApp)
        """
        volume = self.calcFlow() * (0.5 / self.timeOrFrequency)
        return volume

    def calcVolumeTime(self):
        """
        calculates the volume for the valve opened for a duration of time
        (development)
        """
        volume = self.calcFlow() * self.timeOrFrequency
        
        return volume

class FlowAS:
    def __init__(self, pressure, nozzle_diameter, time_or_frequency, fluid, density, viscosity):
        """
        density [g/cm^3]
        pressure [psi]
        nozzleDiameter ['0.xxmm']
        timeOrFrequency [s] or [Hz]
            used in sample app as frequency [Hz]
            used in development as time [s]
        """

        """density [g/cm**3]"""
        density_table = {
            "Water": 1,
            "Methanol": 0.792,
            "Acetone": 0.784,
            "2-Butanol": 0.810,
            'n-Hexane': 0.655,
            'Pentane': 0.6209,
            'Cyclohexane': 0.779,
            'Carbon Tetrachloride': 1.589,
            'Toluene': 0.867,
            'Chloroform': 1.49,
            'Dichloromethane': 1.33,
            'Diethyl ether': 0.713,
            'Ethyl acetate': 0.902,
            'Ethanol': 0.789,
            'Pyridine': 0.982,
        }
        if fluid != 'Specific':
            fluid_density = density_table[fluid]
        else:
            fluid_density = float(density)
            viscosity = float(viscosity)

        self.pressure = 5.0
        self.timeOrFrequency = time_or_frequency
        self.density = fluid_density
        if nozzle_diameter == '0.25':
            self.nozzle_lohms = 7500
            self.correction_factor = 1
        elif nozzle_diameter == '0.19':
            self.nozzle_lohms = 15400
            self.correction_factor = 1
        elif nozzle_diameter == '0.13': 
            self.nozzle_lohms = 35000
            self.correction_factor = 0.58959066
        elif nozzle_diameter == '0.10':
            self.nozzle_lohms = 60000
            self.correction_factor = 0.9242424242424242
            #self.correction_factor = 1
        elif nozzle_diameter == '0.08':
            self.nozzle_lohms = 125000
            self.correction_factor = 1.14375
            #self.correction_factor = 1
        elif nozzle_diameter == '0.05':
            self.nozzle_lohms = 280000
            self.correction_factor = 1
        elif nozzle_diameter == 'atomizer 22k':
            self.nozzle_lohms = 22000
            self.correction_factor = 1
        elif nozzle_diameter == 'atomizer 67k':
            self.nozzle_lohms = 67000
            self.correction_factor = 0.5633333333333334
            #self.correction_factor = 1

    def calcFlow(self):
        """
        flowRateI [ul/s]
        """
        unit_conversion_constant_k = 75700
        lohms = math.sqrt(self.nozzle_lohms ** 2 + 4750 ** 2 + 2100 ** 2 + 700 ** 2)

        # flow rate in ul per s
        flow_rate_i = self.correction_factor * unit_conversion_constant_k / lohms * math.sqrt(
            self.pressure / self.density) / 60 * 1000
        return flow_rate_i

    def calcVolumeFrequency(self):
        """
        calculates the volume for one opening of the valve
        volume [ul] (SampleApp)
        """
        volume = self.calcFlow() * (0.5/ self.timeOrFrequency)
        return volume
