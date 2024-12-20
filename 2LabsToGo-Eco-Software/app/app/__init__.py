from django.core.wsgi import get_wsgi_application
import os
application = get_wsgi_application()
os.environ["DJANGO_ALLOW_ASYNC_UNSAFE"] = "true"
