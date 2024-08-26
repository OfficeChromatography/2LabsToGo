from django.test import TestCase
import os
from .Camera import Camera


class CameraTestCase(TestCase):
    def setUp(self):
        self.camera = Camera()

    def tearDown(self):
        os.remove(self.path)

    def test_caputure_picture(self):
        format = 'jpeg'
        self.path = self.camera.shoot(format)
        self.assertTrue(os.path.isfile(self.path))