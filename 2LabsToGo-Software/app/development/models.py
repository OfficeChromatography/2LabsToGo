from django.db import models
from django.contrib.auth import get_user_model
import finecontrol.models as core_models


class Development_Db(core_models.Application_Db):
    class Meta(core_models.Application_Db.Meta):
        
        pass


class PlateProperties_Db(core_models.PlateProperties_Db):
    development = models.ForeignKey(Development_Db,
                                    related_name='plate_properties',
                                    null=True,
                                    on_delete=models.CASCADE,
                                    blank=True)


class ZeroPosition_Db(core_models.ZeroPosition_Db):
    development = models.ForeignKey(Development_Db,
                                    related_name='zero_properties',
                                    null=True,
                                    on_delete=models.CASCADE,
                                    blank=True)



class PressureSettings_Dev_Db(models.Model):
    development = models.ForeignKey(Development_Db,
                                    related_name='pressure_settings',
                                    null=True,
                                    on_delete=models.CASCADE,
                                    blank=True)
    pressure = models.DecimalField(null=True, decimal_places=0, max_digits=3)
    temperature = models.DecimalField(null=True, decimal_places=0, max_digits=3, blank=True)
    nozzlediameter = models.CharField(max_length=120, default='0.08')
    motor_speed = models.DecimalField(null=True, decimal_places=0, max_digits=5)


class BandSettings_Dev_Db(models.Model):
    development = models.ForeignKey(Development_Db,
                                    related_name='band_settings',
                                    null=True,
                                    on_delete=models.CASCADE,
                                    blank=True)
    volume = models.DecimalField(null=True, decimal_places=1, max_digits=5)
    fluid = models.CharField(max_length=120, default='Methanol')
    printBothways = models.CharField(max_length=120, default='Off', blank=True)
    density = models.DecimalField(decimal_places=2, max_digits=6, null=True, blank=True)
    viscosity = models.DecimalField(decimal_places=2, max_digits=6, null=True, blank=True)
    applications = models.DecimalField(decimal_places=0, max_digits=6, null=True, blank=True)
    waitTime = models.DecimalField(decimal_places=0, max_digits=6, null=True, blank=True)
    description = models.CharField(max_length=120, default='', null=True, blank=True)


class Flowrate_Db(models.Model):
    development = models.ForeignKey(Development_Db, related_name='flowrates', null=True, on_delete=models.CASCADE, blank=True)
    value = models.DecimalField(decimal_places=2, max_digits=6, null=True, blank=True)

class WaitTime_Db(models.Model):
    development = models.ForeignKey(Development_Db,
                                    related_name='wait_time',
                                    null=True,
                                    on_delete=models.CASCADE,
                                    blank=True)
    waitTime = models.DecimalField(decimal_places=0, max_digits=6, null=True, blank=True)
    application = models.DecimalField(decimal_places=0, max_digits=6, null=True, blank=True)


