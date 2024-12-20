from django.shortcuts import render
from django.views import View
from django.http import JsonResponse
from .forms import ConnectionForm, OC_LAB
from .models import *
from django.forms.models import model_to_dict

# MainView of Connection
class Connection_test(View):
    def get(self, request):
        form = {
            'connectionset': ConnectionForm(initial={
                                'baudrate': '115200',
                                'timeout': '2',
                                }),
        }
        return render(
                        request,
                        "connection.html",
                        form
                        )

    def post(self, request):
        # Steps follow after a ConnectionRequest is Send (Connection Form)
        if 'oc_lab' in request.POST:
            connection_form_instance = ConnectionForm(request.POST, user=request.user)
            if connection_form_instance.is_valid():
                data = OC_LAB.device_info()
                connection = connection_form_instance.save()
                new_monitor = Monitor_Db(connection=connection)
                new_monitor.save()
            else:
                data = OC_LAB.device_info()
            return JsonResponse({**data})

        if 'DISCONNECT' in request.POST:
            if OC_LAB:
                OC_LAB.disconnect();
                return JsonResponse({'message':'disconnected'})


class CommunicationWithOC(View):
    def post(self, request):
        response = {'message': ""}
        if OC_LAB.online:
            gcode = request.POST.get('gcode')
            OC_LAB.send(gcode)
            response['message'] = gcode+' sent'
        else:
            response['message'] = 'OC is disconnected'
        return JsonResponse(response)

    def get(self, request):
        response = {}
        response.update(OC_LAB.device_info())
        return JsonResponse(response)


class MonitorView(View):
    def get(self, request, id):
        response = model_to_dict(Monitor_Db.objects.get(pk=id))
        return JsonResponse(response)
