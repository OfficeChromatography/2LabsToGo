from django.shortcuts import render, redirect
from django.http import JsonResponse
from connection.models import Connection_Db, Monitor_Db
from django.forms.models import model_to_dict
from django.db.models.fields import DateTimeField
from datetime import datetime
from django.contrib.auth import (authenticate, get_user_model, login, logout,
                                 update_session_auth_hash, )
from itertools import chain
from .forms import UserRegisterForm, UserLoginForm, ProfileForm, \
    ChangePasswordForm

def to_dict(instance):
    opts = instance._meta
    data = {}
    for f in chain(opts.concrete_fields, opts.private_fields):
        data[f.name] = f.value_from_object(instance)
        if isinstance(f, DateTimeField):
            data[f.name] = f.value_from_object(instance).strftime(
                "%Y/%m/%d, %H:%M:%S")
    for f in opts.many_to_many:
        data[f.name] = [i.id for i in f.value_from_object(instance)]
    return data


User = get_user_model()

USER_INFO = {

}

def login_view(request):
    logout(request)
    form = UserLoginForm(request.POST or None)
    if form.is_valid():
        username = form.cleaned_data.get('username')
        password = form.cleaned_data.get('password')
        user = authenticate(username=username, password=password)
        login(request, user)
        return redirect("/")
    context = {'form': form}
    return render(request, "login.html", context)


def logout_view(request):
    logout(request)
    return redirect("/")
    return render(request, "login.html", {'form': form})


def register_view(request):
    logout(request)
    form = UserRegisterForm(request.POST or None)
    if form.is_valid():
        # Create an Entry for the new User
        user = form.save(commit=False)
        password = form.cleaned_data.get('password')
        user.set_password(password)
        user.save()
        # Check if the user exist and login
        new_user = authenticate(username=user.username, password=password)
        login(request, new_user)
        return redirect("/")

    context = {'form': form}
    return render(request, 'register.html', context)


def profile_view(request):
    context = {}
    if request.user.is_authenticated == True:
        USER_INFO['username'] = request.user.get_username()
        USER_INFO['email'] = request.user.email
        form = ProfileForm(user=request.user, data=request.POST or None)
        if form.is_valid():
            username_qs = User.objects.get(username=USER_INFO['username'])
            if form.cleaned_data.get('username'):
                username_qs.USERNAME = form.cleaned_data.get('username')
            if form.cleaned_data.get('email'):
                username_qs.email = form.cleaned_data.get('email')
            username_qs.save()
            return redirect("/")
    else:
        return redirect("/register/")
    context['form'] = form
    context.update(USER_INFO)
    return render(request, 'profile.html', context)


def username_view(request):
    if request.user.is_authenticated == True:
        return JsonResponse({'username': request.user.get_username()})
    else:
        return JsonResponse({'username': ''})

def change_password_view(request):
    form = ChangePasswordForm(user=request.user, data=request.POST or None)
    if request.POST:
        if form.is_valid():
            u = request.user
            u.set_password(form.cleaned_data['newpassword'])
            u.save()
            update_session_auth_hash(request, u)
            return redirect("/login/")
    return render(request, 'changepass.html', {'form': form})

def log_view(request):
    connections = Connection_Db.objects.filter(auth_id=request.user)
    return render(request, 'log.html', {})

def data_table(request):
    list = []
    connections = Connection_Db.objects.filter(auth_id=request.user)[::-1]
    for i in connections:
        list.append(to_dict(i))
    return JsonResponse(list, safe=False)
