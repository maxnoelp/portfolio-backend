from rest_framework import serializers

from api.portfolio.models import Projects
from api.portfolio.models import Skills


class SkillsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Skills
        fields = "__all__"


class TagSerializer(serializers.ModelSerializer):
    class Meta:
        model = Skills
        fields = ["id", "name", "image"]


class ProjectsSerializer(serializers.ModelSerializer):
    tags = TagSerializer(many=True)

    class Meta:
        model = Projects
        fields = "__all__"
