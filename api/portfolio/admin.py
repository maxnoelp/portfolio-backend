from django.contrib import admin

from api.portfolio.models import Projects
from api.portfolio.models import Skills

admin.site.register(Projects)
admin.site.register(Skills)

# Register your models here.
