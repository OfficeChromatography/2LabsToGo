import serial.tools.list_ports
from printrun.printcore import printcore, gcoder


class OcLab(printcore):
    _instance = None

    def __new__(cls, *args, **kwargs):
        if cls._instance is None:
            cls._instance = object.__new__(cls)
        return cls._instance

    def __init__(self):
        super().__init__()

    def device_info(self):
        device = {}
        device['connected'] = (self.printer != None)
        device['port'] = self.port
        device['baudrate'] = self.baud
        if self.online:
            device['message'] = self.event_handler[0].messages
        else:
            device['message'] = self.event_handler[0].messages

        return device

    @classmethod
    def get_devices(cls):
        devices = serial.tools.list_ports.comports()
        return list(filter(lambda devices: devices.device is not None, devices))

    def print_from_list(self, list_of_gcodes):
        light_gcode = gcoder.LightGCode(list_of_gcodes)
        self.startprint(light_gcode)

    def print_from_file(self, f):
        list_of_gcodes = [code_line.strip() for code_line in f]
        self.print_from_list(list_of_gcodes)


