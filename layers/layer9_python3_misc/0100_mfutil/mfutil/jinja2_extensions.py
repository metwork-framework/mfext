import uuid
import hashlib
from jinja2.ext import Extension


def uuid_filter(value):
    v = str(uuid.uuid4()) + value
    return hashlib.md5(v.encode()).hexdigest()


class UUIDExtension(Extension):
    def __init__(self, environment):
        super(UUIDExtension, self).__init__(environment)
        environment.filters['uuid'] = uuid_filter


def alnum_filter(value):
    return ''.join(c for c in value if c.isalnum())


class AlphaNumericExtension(Extension):
    def __init__(self, environment):
        super(AlphaNumericExtension, self).__init__(environment)
        environment.filters['alnum'] = alnum_filter
