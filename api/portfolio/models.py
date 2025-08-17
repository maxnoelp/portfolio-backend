from django.db import models
from django.utils.translation import gettext_lazy as _
from tinymce.models import HTMLField


class Skills(models.Model):
    name = models.CharField(_("Name"), max_length=100)
    image = models.ImageField(
        _("Bild"),
        upload_to="portfolio/images/",
        blank=True,
    )

    def __str__(self):
        return self.name


class Projects(models.Model):
    title = models.CharField(_("Titel"), max_length=100)
    tags = models.ManyToManyField(Skills, verbose_name=_("Tags"), blank=True)
    description = HTMLField(_("Beschreibung"))
    image = models.ImageField(_("Bild"), upload_to="portfolio/images/")
    image2 = models.ImageField(
        _("optionales Bild"),
        upload_to="portfolio/images/",
        blank=True,
    )
    gh = models.URLField(_("Github Repo"), blank=True)
    live = models.URLField(_("Live Demo"), blank=True)
    in_progress = models.BooleanField(_("In Arbeit"), default=False)

    def __str__(self):
        return self.title
