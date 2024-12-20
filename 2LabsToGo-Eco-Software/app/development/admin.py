from django.contrib import admin
from .models import *
from django.db import models

# admin.site.register(PlateProperties_Dev_Db)
admin.site.register(Development_Db)
admin.site.register(PlateProperties_Db)
admin.site.register(ZeroPosition_Db)
admin.site.register(PressureSettings_Dev_Db)
admin.site.register(BandSettings_Dev_Db)
admin.site.register(Flowrate_Db)
admin.site.register(WaitTime_Db)


