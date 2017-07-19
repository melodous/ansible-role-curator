# -*- coding: utf-8 -*-
#
# Copyright (C) 2017 Opensolutions

import os
import fnmatch
import re
from subprocess import check_output

import yaml2rst


def yaml2rst_role_defaults(dir_path):
    """Generate documentation on the fly based on Ansible default variables"""
    yaml2rst.convert_file(
            dir_path + '/defaults/main.yml',
            dir_path + 'DEFAULTS.rst',
            strip_regex=r'\s*(:?\[{3}|\]{3})\d?$',
            yaml_strip_regex=r'^\s{66,67}#\s\]{3}\d?$',
    )
