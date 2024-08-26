# This file is part of the Printrun suite.
#
# Printrun is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Printrun is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Printrun.  If not, see <http://www.gnu.org/licenses/>.
from connection.models import Monitor_Db
from channels.layers import get_channel_layer
from asgiref.sync import async_to_sync
channel_layer = get_channel_layer()
import time



class PrinterEventHandler():
    '''
    Defines a skeletton of an event-handler for printer events. It
    allows attaching to the printcore and will be triggered for
    different events.
    '''
    def __init__(self):
        '''
        Constructor.
        '''
        self.messages = ""
        self.air_sensor = {
            "temperature": "-10.00",
            "humidity": "-100.00",
        }
        pass

    def on_init(self):
        '''
        Called whenever a new printcore is initialized.
        '''
        pass

    def on_send(self, command, gline):
        '''
        Called on every command sent to the printer.

        @param command: The command to be sent.
        @param gline: The parsed high-level command.
        '''
        # aux = Monitor_Db.objects.last()
        # aux.monitortext += command+'\n'
        # aux.save()
        self.messages += command+'\n'
        async_to_sync(channel_layer.group_send)("monitor_oc_lab", {'type': 'chat_message', 'message': command})
        pass

    def on_recv(self, line):
        '''
        Called on every line read from the printer.

        @param line: The data has been read from printer.
        '''
        # aux = Monitor_Db.objects.last()
        # aux.monitortext += line
        # aux.save()
        if all(x in line for x in ["H:","T:"]):
            print(line)
            self.air_sensor = {
                "temperature": line[2:7],
                "humidity": line[10::],
            }
            async_to_sync(channel_layer.group_send)("monitor_air_sensor",
                                                {'type': 'chat_message',
                                                 'message': self.air_sensor
                                                 })

        self.messages += line
        async_to_sync(channel_layer.group_send)("monitor_oc_lab", {'type': 'chat_message', 'message': line[:-1]})
        pass

    def on_connect(self):
        '''
        Called whenever printcore is connected.
        '''
        self.messages = ""
        time.sleep(2)
        async_to_sync(channel_layer.group_send)("monitor_oc_lab", {'type': 'chat_message', 'message': 'Connected!'})
        async_to_sync(channel_layer.group_send)("monitor_oc_lab_status",
                                                {'type': 'chat_message',
                                                 'message': {'connected': True},
                                                 })
        pass

    def on_disconnect(self):
        '''
        Called whenever printcore is disconnected.
        '''
        aux = Monitor_Db.objects.last()
        aux.monitortext = self.messages
        aux.save()
        self.messages = ""
        async_to_sync(channel_layer.group_send)("monitor_oc_lab_status",
                                                {'type': 'chat_message',
                                                 'message': {'connected': False},
                                                 })
        pass

    def on_error(self, error):
        '''
        Called whenever an error occurs.

        @param error: The error that has been triggered.
        '''
        aux = Monitor_Db.objects.last()
        aux.monitortext = self.messages
        aux.save()
        pass

    def on_online(self):
        '''
        Called when printer got online.
        '''
        pass

    def on_temp(self, line):
        '''
        Called for temp, status, whatever.

        @param line: Line of data.
        '''
        pass

    def on_start(self, resume):
        '''
        Called when printing is started.

        @param resume: If true, the print is resumed.
        '''
        pass

    def on_end(self):
        '''
        Called when printing ends.
        '''
        pass

    def on_layerchange(self, layer):
        '''
        Called on layer changed.

        @param layer: The new layer.
        '''
        pass

    def on_preprintsend(self, gline, index, mainqueue):
        '''
        Called pre sending printing command.

        @param gline: Line to be send.
        @param index: Index in the mainqueue.
        @param mainqueue: The main queue of commands.
        '''
        pass

    def on_printsend(self, gline):
        '''
        Called whenever a line is sent to the printer.

        @param gline: The line send to the printer.
        '''
        pass
