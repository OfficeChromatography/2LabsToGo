from .views import *
from django.urls import path
from finecontrol.views import MethodList

urlpatterns = [
    path('development/', DevelopmentView.as_view(), name='development'),
    path('development/list', MethodList.as_view(), name='development_list'),

    path('development/load/<int:id>/', DevelopmentDetail.as_view(), name='development_element'),
    path('development/save/', DevelopmentDetail.as_view(), name='development_element'),
    path('development/delete/<int:id>/', DevelopmentDelete.as_view(), name='developmentdelete'),

    path('development/start/', DevelopmentAppPlay.as_view(), name='development_element'),

    path('development/waiting_time/<int:id>/', DevelopmentWaitingTime.as_view(), name='development_waiting_time'),
    path('development/waiting_time/', DevelopmentWaitingTime.as_view(), name='development_waiting_time'),
    path('development/waiting_time_view/', DevelopmentViewWaitingTimes.as_view(), name='development_waiting_time'),
    path('development/import_csv/', ImportDevelopmentCSV.as_view(), name='import_development_csv'),
]
