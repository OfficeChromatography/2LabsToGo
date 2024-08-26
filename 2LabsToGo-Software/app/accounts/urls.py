"""app URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from accounts import views as accounts_views
from django.urls import path
urlpatterns = [
    path('login/',  accounts_views.login_view, name='login'),
    path('logout/',  accounts_views.logout_view, name='logout'),
    path('register/',  accounts_views.register_view, name='register'),
    path('profile/',  accounts_views.profile_view, name='profile'),
    path('userinfo/',  accounts_views.username_view, name='username'),
    path('changepass/',  accounts_views.change_password_view, name='username'),
    path('log/',  accounts_views.log_view, name='logs'),
    path('logdatatable/',  accounts_views.data_table, name='logs'),
]
