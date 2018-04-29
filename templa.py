#!/usr/bin/env python
#
# render templates using various template engines.
# todo: python2 pytho3 support
#
import sys,os
import json
import baker


@baker.command
def render_percent(template):
    """
    Render a template using python's % formatting.
    """
    template_str=file(template).read().decode('utf8')
    for line in sys.stdin.readlines():
        params=json.loads(line)
        print template_str % params


@baker.command
def render_format(template):
    """
    Render a template using python's {}.format.
    """
    template_str=file(template).read().decode('utf8')
    for line in sys.stdin.readlines():
        params=json.loads(line)
        if isinstance(params, dict):
            print template_str.format(**params)
        else:
            print template_str.format(*params)


@baker.command
def render_jinja2(template):
    """
    Render a template using jinja2
    """
    import jinja2
    template_str=file(template).read().decode('utf8')
    for line in sys.stdin.readlines():
        params=json.loads(line)
        print jinja2.Template(template_str, undefined=jinja2.StrictUndefined).render(**params)


baker.run()
