from django.urls import path
from .views import *
from finecontrol.views import MethodList, MethodListSP

urlpatterns = [
    path('sample/', SampleView.as_view(), name='sample'),
    path('syringepump/', SyringeView.as_view(), name='syringepump'),
    path('sample/list/', MethodList.as_view(), name='samplelist'),

    path('sample/load/<int:id>/', SampleDetails.as_view(), name='sampleload'),
    path('sample/save/', SampleDetails.as_view(), name='samplesave'),
    path('sample/delete/<int:id>/', SampleDelete.as_view(), name='sampledelete'),

    path('sample/start/', SampleAppPlay.as_view(), name='sampleplay'),
    path('samplecalc/', CalcVol.as_view(), name='samplecalc'),

    path('syringepumpcalc/', CalcVolSP.as_view(), name='syringepumpcalc'),
    path('syringepump/list/', MethodListSP.as_view(), name='syringepumplist'),

    path('syringepump/load/<int:id>/', SampleDetailsSP.as_view(), name='syringepumpload'),
    path('syringepump/save/', SampleDetailsSP.as_view(), name='syringepumpsave'),
    path('syringepump/delete/<int:id>/', SampleDeleteSP.as_view(), name='syringepumpdelete'),

    path('syringepump/start/', SampleAppPlaySP.as_view(), name='syringepumpplay'),
    
]
