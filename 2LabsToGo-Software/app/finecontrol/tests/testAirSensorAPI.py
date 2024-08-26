from finecontrol.models import AirSensor_Db
from finecontrol.serializers import AirSensorSerializer
from django.test import TestCase
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APITestCase

values = [{
    "temperature": "25.30",
    "humidity": "80.00"
},
    {
        "temperature": "26.30",
        "humidity": "95.00"
    }]


class AirSensorSerializerTestCase(TestCase):
    def setUp(self):
        AirSensor_Db.objects.create(**values[0])
        AirSensor_Db.objects.create(**values[1])

    def test_deserialize(self):
        measure_1 = AirSensor_Db.objects.create(**values[0])
        self.assertEqual(AirSensorSerializer(measure_1).data, values[0])


class AirSensorListAPITestCase(APITestCase):
    def setUp(self):
        AirSensor_Db.objects.create(**values[0])
        AirSensor_Db.objects.create(**values[1])

    def test_get(self):
        response = self.client.get(reverse('airsensor'))
        self.assertEqual(response.data[0], values[0])
        self.assertEqual(response.data[1], values[1])
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_post(self):
        response = self.client.post(reverse('airsensor'), values[0], format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(response.data, values[0])


class AirSensorDetailAPITestCase(APITestCase):
    def setUp(self):
        AirSensor_Db.objects.create(**values[0])
        AirSensor_Db.objects.create(**values[1])

    def test_get(self):
        response = self.client.get(reverse('airsensordetail', args=[1]))

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data, values[0])

    def test_put(self):
        new_value = {
            "humidity": "50.00",
            "temperature": "30.00",
        }
        response = self.client.put(reverse('airsensordetail', args=[1]), new_value, format='json')

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data, new_value)
