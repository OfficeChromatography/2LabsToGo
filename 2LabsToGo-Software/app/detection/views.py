from django.views.generic import FormView, View
from django.shortcuts import render, redirect
from django.views import View
from django.http import JsonResponse, HttpResponseBadRequest
from connection.forms import OC_LAB
from app.settings import STATIC_ROOT, MEDIA_ROOT
from .models import *
from django.core.files import File
from django.core.files.storage import FileSystemStorage
from django.forms.models import model_to_dict
from .hdr import *
import cv2
import numpy as np
from  django.http import QueryDict
import json

from django.core.files import File
import re
from .takeimage import *
from django.core.exceptions import ObjectDoesNotExist
import os
from finecontrol.forms import data_validations, data_validations_and_save
import csv
import urllib.parse
from django.core.files.uploadedfile import SimpleUploadedFile



MOTION_MODEL = ((0, 'Translation'),
                    (1, 'Euclidean'),
                    (2, 'Affine'),
                    (3, 'Homography'))

class ImportCSV(View):
    def post(self, request):
        csv_file = request.FILES.get('csv_file')
        if not csv_file:
            return JsonResponse({'error': 'No CSV file uploaded'}, status=400)

        try:
            decoded_file = csv_file.read().decode('utf-8').splitlines()
            reader = csv.reader(decoded_file, delimiter=',', quotechar='"')

            form_data = {}
            color_selected = {}  
            default_image_url = 'http://127.0.0.1:8000/static/img/login.jpg'

            for row in reader:
                if len(row) < 2:
                    continue  

                key = row[0].strip()  
                value = row[1].strip()  

                if key.startswith('colorSelected'):
                    try:
                        json_str = key[len('colorSelected'):] + value
                        color_array = json.loads(json_str)

                        for color in color_array:
                            color_selected[color['name']] = color['value']

                        
                    except json.JSONDecodeError as e:
                        return JsonResponse({'error': f'Error parsing colorSelected: {str(e)}'}, status=400)
                else:
                    if key in ['filename', 'note']:
                        form_data[key] = urllib.parse.unquote(value)
                    elif key == 'colour_gains':
                        form_data[key] = urllib.parse.unquote(value).replace('%2C', ',')
                    elif key == 'image_id':
                        form_data['image_id'] = default_image_url
                    else:
                        form_data[key] = value
            form_data['image_id'] = default_image_url

            request.session['imported_form_data'] = form_data
            request.session['imported_color_selected'] = color_selected

            return redirect('capture')

        except Exception as e:
            return JsonResponse({'error': str(e)}, status=400)

class Image_Process(View):
    
    def get(self, request):
            last_photo = Images_Db.objects.latest('id')
            photo_path = last_photo.image.url
            full_photo_url = request.build_absolute_uri(photo_path)
            context = {
                'imagepath': full_photo_url,
            }   
            return render(request, 'Image_Process.html', context) 
        
    def post(self, request):
        
        direction = request.POST.get('direction')
        photo_name = request.POST.get("current_photo_id")

        if direction == 'next' :
            current_photo = Images_Db.objects.get(image__contains=photo_name)
            current_photo_id = int(current_photo.id);
            next_photo_id = current_photo_id + 1;
            next_photo = Images_Db.objects.get(id=next_photo_id);
            if next_photo:
                
                photo_path = next_photo.image.url
                full_photo_url = request.build_absolute_uri(photo_path)

        elif direction == 'pre':
                current_photo = Images_Db.objects.get(image__contains=photo_name)
                current_photo_id = int(current_photo.id);
                previous_photo_id = current_photo_id - 1;
                previous_photo = Images_Db.objects.get(id=previous_photo_id);
                if previous_photo:
                    photo_path = previous_photo.image.url
                    full_photo_url = request.build_absolute_uri(photo_path)
        else:
            last_photo = Images_Db.objects.latest('id')
            photo_path = last_photo.image.url
            full_photo_url = request.build_absolute_uri(photo_path)
    
        return JsonResponse({'imagepath':full_photo_url})

class DetectionView(FormView):
    def get(self, request):
        form = {}
        initial = basic_conf()
        imported_data = request.session.pop('imported_form_data', None)
        color_selected = request.session.pop('imported_color_selected', None)

        if imported_data:
              
            initial.update(imported_data)

        form['FormatControlsForm'] = ShootConfigurationForm(initial=initial)
        form['CameraControlsForm'] = CameraControlsForm(initial=initial)
        form['UserControlsForm'] = UserControlsForm(initial=initial)
        form['LedsControlsForm'] = LedsControlsForm(initial=initial)
        
        image_info = {'url': 'http://127.0.0.1:8000/static/img/login.jpg'}
        if 'image_id' in initial:
            image_id = initial['image_id']
            if image_id.startswith('http'):
                image_info = {'url': image_id}
            else:
                image_info = {'url': f'http://127.0.0.1:8000/capture/load/{image_id}/'}
        context = {**form, **image_info}

        if color_selected:
            context['color_selected'] = color_selected
            context['importedColorSelected'] = json.dumps(color_selected)

        if imported_data:
            context['importedFormData'] = json.dumps(imported_data)

        return render(request, 'capture.html', context)

class TakeImage(View):
    def get(self, request):
        action = request.GET.get('action')
        if action == "LOAD_NOTE":
            image_id = request.GET.get('id')
            try:
                image_instance = Images_Db.objects.get(id=image_id)
                return JsonResponse({'note': image_instance.note}, status=200)
            except Images_Db.DoesNotExist:
                return JsonResponse({'error': 'Image not found'}, status=404)
        else:
            return JsonResponse({'error': 'Invalid action for GET method'}, status=400)
    
    def post(self, request):
        try:
            action = request.POST.get('action', 'TAKE_PHOTO')
            

            if action == "SAVE_NOTE":
                image_id = request.POST.get('id')
                note_text = request.POST.get('note')
                print(f"Saving note for image ID {image_id}: {note_text}")

                try:
                    image_instance = Images_Db.objects.get(id=image_id)
                    image_instance.note = note_text
                    image_instance.save()
                    return JsonResponse({'message': 'Note saved successfully!'}, status=200)
                except Images_Db.DoesNotExist:
                    print(f"Image with ID {image_id} not found.")
                    return JsonResponse({'error': 'Image not found'}, status=404)

            elif action == "TAKE_PHOTO":
                color_selected = request.POST.getlist('colorSelected[]')
                method_selected = request.POST.getlist('methodSelected[]')


                if len(color_selected) != 3:
                    print("Invalid colorSelected data:", color_selected)
                    return JsonResponse({'error': 'Invalid colorSelected data'}, status=400)
                if len(method_selected) != 2:
                    print("Invalid methodSelected data:", method_selected)
                    return JsonResponse({'error': 'Invalid methodSelected data'}, status=400)

                try:
                    color_dict = {
                        "red": int(color_selected[0]),
                        "green": int(color_selected[1]),
                        "blue": int(color_selected[2]),
                    }
                    
                except ValueError as ve:
                    print("Error parsing color values:", ve)
                    return JsonResponse({'error': 'Invalid color values'}, status=400)

                try:
                    print("Starting photo shoot process...")
                    photo_shoot = PhotoShootManager(request)
                    photo_shoot.set_camera_configurations(color_dict)
                    photo_shoot.shoot()
                    photo_shoot.photo_correction()
                    photo_infos = []
                    
                    images = photo_shoot.save_photo_in_db()  
                    for photo_object in images:
                        photo_info = {
                            'url': request.META['HTTP_ORIGIN'] + photo_object.image.url,
                            'new_name': photo_object.image.url,
                            'id': photo_object.id,
                        }
                        photo_infos.append(photo_info)
                        print("Photo info saved:", photo_info)
                    
                    return JsonResponse(photo_infos, safe=False)
                
                except Exception as e:
                    print("Error during photo shoot process:", str(e))
                    return JsonResponse({'error': str(e)}, status=500)

            else:
                print("Invalid action:", action)
                return JsonResponse({'error': 'Invalid action'}, status=400)
        
        except Exception as e:
            print("Unexpected error occurred:", str(e))
            return JsonResponse({'error': 'An error occurred on the server. Check logs for details.'}, status=500)

class DetectionDetail(View):
    def delete(self, request, id):
        Method_Db.objects.get(pk=id).delete()
        return JsonResponse({})

    def get(self, request, id):
        """Loads an object specified by ID"""
        id_object = id
        response = {}
        method = Method_Db.objects.get(id=id_object, auth=request.user)
        images = Images_Db.objects.filter(method=method)


        if not Method_Db.objects.get(id=id_object, auth=request.user) or images.count()==0:
            response.update({"filename":getattr(method,"filename")})
            response.update({"id":id_object})
        
        else:
            url_list=[]
            id_list=[]

            
            pos = images.count() - 1
            if (pos<0): pos=0 
            imageconf = images[pos]
            
            user_conf = model_to_dict(imageconf.user_conf,
                                    fields=[field.name for field in imageconf.user_conf._meta.fields])
            leds_conf = model_to_dict(imageconf.leds_conf,
                                    fields=[field.name for field in imageconf.leds_conf._meta.fields])
            camera_conf = model_to_dict(imageconf.camera_conf,
                                    fields=[field.name for field in imageconf.camera_conf._meta.fields])
            
            for image in images:
                url_list.append(image.image.url)
                id_list.append(image.id)

            response.update({**{
                        'url': url_list,
                        'filename': image.method.filename,
                        'id': id_object,
                        'id_list': id_list,
                        'user_conf': user_conf,
                        'leds_conf': leds_conf,
                        'camera_conf': camera_conf,
                        'note': imageconf.note,
                        }})
        return JsonResponse(response)

    def post(self, request):
        """Save and Update Data"""
        
        id = request.POST.get("selected-element-id")
        image_id = request.POST.get("image_id")
        method_form = Method_Form(request.POST)

        if not id:
            method = method_form.save(commit=False)
            method.auth = request.user
            method.save()
        else:
            method = Method_Db.objects.get(pk=id)
            method_form = Method_Form(request.POST, instance=method)
            method_form.save()
            if image_id:
                image_instance = Images_Db.objects.get(id=image_id)
                image_instance.method = method
                image_instance.note = request.POST.get("note")
                image_instance.save()

        return JsonResponse({'message':'Data !!'})

class GetConfig(View):
    def get(self, request, id):
        image = Images_Db.objects.get(pk=id)
        response = {}
        user_conf = model_to_dict(image.user_conf,
                                fields=[field.name for field in image.user_conf._meta.fields])
        leds_conf = model_to_dict(image.leds_conf,
                                fields=[field.name for field in image.leds_conf._meta.fields])
        camera_conf = model_to_dict(image.camera_conf,
                                fields=[field.name for field in image.camera_conf._meta.fields])
        response.update({**{
                        'user_conf': user_conf,
                        'leds_conf': leds_conf,
                        'camera_conf': camera_conf,
                        'note': image.note,
                        }})
        return JsonResponse(response)

class Hdr_View(View):
    def get(self, request):
        form = {
            'AligmentConfigurationForm': AligmentConfigurationForm(initial={
                    'number_of_iterations': 5000,
                    'warp_mode': 0,
            }),
        }
        return render(request, "hdr.html", form)

    def post(self, request):
        fs = FileSystemStorage()
        form = AligmentConfigurationForm(QueryDict(request.POST.getlist('AligmentConfigurationForm')[0]))
        ids = request.POST.getlist('id[]')
        if not form.is_valid():
            # Check the form values
            return HttpResponseBadRequest("Wrong Parameters")
        elif len(ids)<2:
            # Check there's at least 2 images
            return HttpResponseBadRequest("Select at least 2 Valid Pictures")
        else:
            try:
                img_list = [cv2.imread(Images_Db.objects.get(id=id).image.path) for id in ids]
            except ValueError:
                return HttpResponseBadRequest("Select valid Pictures")

            processed_hdr = HDR(  img_list,
                                form.cleaned_data.get('warp_mode'),
                                form.cleaned_data.get('number_of_iterations')).process_images()
            if processed_hdr is None:
                return HttpResponseBadRequest('There was an error processing HDR on images')
            else:
                with open(processed_hdr, 'rb') as f:
                    object = Hdr_Image()
                    object.image.save(os.path.basename(processed_hdr), File(f))
                    object.save()
                    f.close()
                    response = {
                        'url':request.META['HTTP_ORIGIN']+object.image.url,
                        'new_name':object.image.name,
                        'method': MOTION_MODEL[form.cleaned_data.get('warp_mode')][1]
                    }
                return JsonResponse(response)

class DeleteImage(View):
    def delete(self, request, id):
        if not Images_Db.objects.get(pk=id):
            return JsonResponse({'warning': 'Something went wrong!'})
        else:
            image = Images_Db.objects.get(pk=id)
            path = os.path.join(MEDIA_ROOT, str(image.image))
            if os.path.exists(path):
                os.remove(path)
                image.delete()
            return JsonResponse({'success': 'File removed!'})

class DeleteImages(View):
    def delete(self, request, id):
        apps = Images_Db.objects.filter(method=Method_Db.objects.get(pk=id))
        for image in apps:
            path = os.path.join(MEDIA_ROOT, str(image.image))
            if os.path.exists(path):
                os.remove(path)
        apps.delete()
        return JsonResponse({})
