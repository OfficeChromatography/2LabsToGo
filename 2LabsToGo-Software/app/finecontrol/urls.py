from django.urls import path
from .views import *
urlpatterns = [
    path('motorcontrol/', MotorControl.as_view(), name='motorcontrol'),
    path('clean/', Clean.as_view(), name='pumpcontrol'),
    path('cleanas/', CleanAS.as_view(), name='ascontrol'),
    path('cells/', Cells.as_view(), name='cells'),
    path('incubation/', Incubation.as_view(), name='incubation'),
    path('incubationControl/', IncubationControl.as_view(), name='incubationcontrol'),
    path('cleanprocess/', CleanControl.as_view(), name='cleanprocess'),
    path('cleanprocessas/', CleanControlAS.as_view(), name='cleanprocessas'),
    path('warmupas/', WarmUp.as_view(), name='warmupas'),
    path('staticpurge/', StaticPurge.as_view(), name='staticpurge'),
    path('staticpurgeas/', StaticPurgeAS.as_view(), name='staticpurgeas'),
    path('gcode-editor/',GcodeEditor.as_view(), name='gcodeeditor'),
    path('syringeload/', SyringeLoad.as_view(), name='syringeload'),
    path('syringetype/', SyringeType.as_view(), name='syringetype'),
    path('temperature/', Temperature.as_view(), name='temperature'),
    path('tempControl/', TempControl.as_view(), name='tempcontrol'),
    path('light/', Light.as_view(), name='light'),
    path('backlight/', Back_Light.as_view(), name='backlight'),
    path('neolight/', Neo_Light.as_view(), name='neolight'),
    path('uv265light/', UVLed_Light_265.as_view(), name='uv265light'),
    path('uv365light/', UVLed_Light_365.as_view(), name='uv365light'),
    path('fan/', Fan.as_view(), name='fan'),
    path('drypump/', DryPump.as_view(), name='drypump'),
    path('drypumpControl/', DryPumpControl.as_view(), name='drypumpcontrol'),
    path('oclab/control/', OcLabControl.as_view(), name='oclabcontrol'),
    path('oclab/airsensor/', AirSensorList.as_view(), name='airsensor'),
    path('oclab/airsensor/<int:pk>/', AirSensorDetail.as_view(), name='airsensordetail'),
    
    path('method/delete/<int:id>/', MethodDelete.as_view(), name='methoddelete'),
    path('export/<int:id>/', Export.as_view(), name='export')
]
