from rest_framework import serializers
from finecontrol.models import AirSensor_Db


class AirSensorSerializer(serializers.ModelSerializer):

    class Meta:
        model = AirSensor_Db
        fields = ["temperature", "humidity"]
