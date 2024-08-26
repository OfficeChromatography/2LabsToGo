from django.db import models
from django.contrib.auth import get_user_model
# To have a better understandig on the Fields of the Database read pySerial
# documentation. Mostly just the "class serial.Serial" parameters


class Connection_Db(models.Model):
    oc_lab = models.CharField('Port', max_length=120)
    auth_id = models.ForeignKey(
                get_user_model(),
                null=True,
                on_delete=models.CASCADE,
                blank=True,
                )
    baudrate = models.DecimalField(decimal_places=0, max_digits=6)
    timeout = models.DecimalField(decimal_places=0, max_digits=4)
    time_of_connection = models.DateTimeField(auto_now_add=True)

class Monitor_Db(models.Model):
    connection = models.ForeignKey(Connection_Db, on_delete=models.CASCADE, default=1)
    monitortext = models.TextField(blank=True)

def __str__(self):
    return self.oc_lab


