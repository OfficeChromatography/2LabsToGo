from django.urls import path
from connection.views import *
urlpatterns = [
    path('', Connection_test.as_view(), name='test'),
    path('connection/', Connection_test.as_view(), name='connection'),
    path('connection_info/', CommunicationWithOC.as_view(), name='isconnected'),
    path('send/', CommunicationWithOC.as_view(), name='test'),
    path('monitor/<int:id>/', MonitorView.as_view(), name='connection'),
]
