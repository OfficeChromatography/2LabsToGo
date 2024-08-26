from django.forms import ModelForm
from .models import CleaningProcess_Db, ZeroPosition, Method_Db, SyringeConfiguration
from django import forms
from django.http import JsonResponse

class CleaningProcessForm(forms.ModelForm):
    class Meta:
        model = CleaningProcess_Db
        fields = [  'start_frequency',
                    'stop_frequency', 
                    'steps',
                    'warmup_pressure',
                    'times',]

    start_frequency = forms.DecimalField(label='Frequency',
                            required=False,
                            max_digits=4,
                            decimal_places=0,
                            max_value=1200,
                            min_value=1,
                            widget=forms.NumberInput(attrs={'size': '1', 'placeholder':'100', 'class':'form-control'}))

    stop_frequency = forms.DecimalField(label='Stop Frequency',
                            required=False,
                            max_digits=3,
                            decimal_places=0,
                            max_value=500,
                            min_value=100,
                            widget=forms.NumberInput(attrs={'size': '1', 'placeholder':'500', 'class':'form-control'}))

    steps = forms.DecimalField(label='# Droplets',
                            required=False,
                            max_digits=5,
                            decimal_places=0,
                            max_value=10000,
                            min_value=1,
                            widget=forms.NumberInput(attrs={'size': '1', 'placeholder':'50', 'class':'form-control'}))

    warmup_pressure = forms.DecimalField(label='Pressure',
                            required=False,
                            max_digits=3,
                            decimal_places=1,
                            max_value=50,
                            min_value=0,
                            widget=forms.NumberInput(attrs={'size': '1', 'placeholder':'200', 'class':'form-control'}))
 
    times = forms.DecimalField(label='Times',
                            required=False,
                            max_digits=3,
                            decimal_places=0,
                            max_value=50,
                            min_value=1,
                            widget=forms.NumberInput(attrs={'size': '1', 'placeholder':'1', 'class':'form-control'}))

    def clean_start_frequency(self):
        return int(self.cleaned_data['start_frequency'])
    def clean_steps(self):
        return int(self.cleaned_data['steps'])
    def clean_warmup_pressure(self):
        return float(self.cleaned_data['warmup_pressure'])
    def clean_times(self):
        times = self.cleaned_data['times']
        if times:
            times = int(times)
        if not times:
            times = 1
        return times

class ZeroPosition_Form(forms.ModelForm):

    class Meta:
        model = ZeroPosition
        fields = ['zero_x','zero_y']

class Method_Form(forms.ModelForm):

    class Meta:
        model = Method_Db
        fields = ['filename']



def data_validations(**kwargs):
    # Iterate each form and run validations
    forms_data = {}
    for key_form, form in kwargs.items():
        if form.is_valid():
            forms_data.update(form.cleaned_data)
        else:
            return JsonResponse({'error':f'Check {key_form}'})
    return forms_data


# returns a dictionary with all objects saved.
def data_validations_and_save(**kwargs):
    objects_saved = {}
    for key_form, form in kwargs.items():
        if form.is_valid():
            objects_saved[key_form] = form.save()
        else:
            return JsonResponse({'error':f'Check {key_form}'})
    return objects_saved

class SyringeSettingsForm(forms.ModelForm):
    class Meta:
        model = SyringeConfiguration

        fields =[   'volume_type',
                    'length_type',
                    ]
        widgets = {
                    'volume_type':                forms.Select(attrs={'class': 'form-control'}),
                    'length_type':                forms.TextInput(attrs={'readonly': 'readonly'}),
                    }
        labels = {
                    'volume_type':                  _('Volume:'),
                    'length_type':                  _('Length:'),
                }

    def clean_volume_type(self):
        volume_type = self.cleaned_data['volume_type']
        if volume_type:
            volume_type = int(volume_type)
        if not volume_type:
            volume_type = 3
        return volume_type

    def clean_length_type(self):
        length_type = self.cleaned_data['length_type']
        if length_type:
            length_type = int(length_type)
        if not length_type:
            length_type = 40
        return length_type
   
