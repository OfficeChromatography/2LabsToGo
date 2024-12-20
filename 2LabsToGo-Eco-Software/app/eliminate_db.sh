#!/bin/bash
find . -path "*/migrations/*.py" -not -name "__init__.py" -delete
find . -path "*/migrations/*.pyc"  -delete
rm -r db.sqlite3
python manage.py makemigrations
python manage.py migrate
python manage.py createsuperuser





# subprocess.run(["sudo", "docker-compose", "unpause"], stderr=subprocess.PIPE)
# subprocess.run(["sudo", "docker-compose", "up"])
