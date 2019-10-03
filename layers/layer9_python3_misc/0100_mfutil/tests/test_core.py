import os
import shutil
import string
from six import string_types
from unittest import TestCase
from mfutil import get_unique_hexa_identifier
from mfutil import mkdir_p
from mfutil import create_tmp_dirpath
from mfutil import hash_generator
from mfutil import get_utc_unix_timestamp
from mfutil import get_ipv4_for_hostname, BashWrapper, BashWrapperOrRaise
from mfutil import get_recursive_mtime, get_tmp_filepath, BashWrapperException

TEST_DIRECTORY = os.path.dirname(os.path.realpath(__file__))


class TestCase1(TestCase):

    def test_get_utc_unix_timestamp(self):
        x = get_utc_unix_timestamp()
        self.assertTrue(x > 1513000000)

    def test_get_unique_hexa_identifier(self):
        x = get_unique_hexa_identifier()
        self.assertTrue(len(x) == 32)
        for c in x:
            if c not in string.hexdigits.lower():
                raise("Invalid char in identifier")
        y = get_unique_hexa_identifier()
        self.assertTrue(x != y)

    def test_mkdir_p(self):
        tmp = create_tmp_dirpath()
        x = get_unique_hexa_identifier()
        new_tmp = os.path.join(tmp, x)
        res = mkdir_p(new_tmp, nowarning=True)
        self.assertTrue(res)
        self.assertTrue(os.path.isdir(new_tmp))
        res = mkdir_p(new_tmp, nowarning=True)
        self.assertTrue(res)
        self.assertTrue(os.path.isdir(new_tmp))
        shutil.rmtree(tmp)

    def test_get_ipv4_for_hostname(self):
        self.assertEquals(get_ipv4_for_hostname('localhost'), '127.0.0.1')
        self.assertEquals(get_ipv4_for_hostname('localhost.localdomain'),
                          '127.0.0.1')
        self.assertEquals(get_ipv4_for_hostname('127.0.0.1'), '127.0.0.1')
        self.assertEquals(get_ipv4_for_hostname('1.2.3.4'), '1.2.3.4')
        x = get_ipv4_for_hostname('foo.bar.doesnotexist')
        self.assertTrue(x is None)
        x = get_ipv4_for_hostname('www.google.com')
        self.assertTrue(x is not None)
        self.assertTrue(len(x) >= 4)
        y = x.split('.')
        self.assertEquals(len(y), 4)

    def test_get_recursive_mtime(self):
        mtime = get_recursive_mtime(".", ignores=["foo", "*.py"])
        self.assertTrue(isinstance(mtime, int))
        self.assertTrue(mtime > 0)

    def test_get_recursive_mtime2(self):
        mtime = get_recursive_mtime(".")
        self.assertTrue(isinstance(mtime, int))
        self.assertTrue(mtime > 0)

    def test_get_tmp_filepath(self):
        tmpdir = os.path.join(TEST_DIRECTORY, get_unique_hexa_identifier())
        tmp = get_tmp_filepath(tmpdir, "foo")
        self.assertTrue(tmp.startswith(os.path.join(tmpdir, "foo")))
        shutil.rmtree(tmpdir, True)

    def test_bash_wrapper(self):
        x = BashWrapper("ls /foo/bar")
        if x:
            raise Exception("this exception must not be raised")
        self.assertTrue(x.code != 0)
        self.assertTrue(len(x.stderr) > 0)
        self.assertTrue(len(x.stdout) == 0)
        self.assertTrue(len("%s" % x) > 0)

    def test_bash_wrapper2(self):
        x = BashWrapper("ls %s" % TEST_DIRECTORY)
        if not x:
            raise Exception("this exception must not be raised")
        self.assertTrue(x.code == 0)
        self.assertTrue(len(x.stdout) > 0)
        self.assertTrue(len(x.stderr) == 0)
        self.assertTrue(len("%s" % x) > 0)

    def test_bash_wrapper3(self):
        try:
            BashWrapperOrRaise("ls /foo/bar")
            raise Exception("this exception must not be raised")
        except BashWrapperException as e:
            self.assertTrue(len("%s" % e) > 0)

    def test_hash_generator(self):
        x1 = hash_generator()
        x2 = hash_generator(1, "foo")
        x3 = hash_generator("bar", (1, 2, 3), True, None)
        x4 = hash_generator("bar", (1, 2, 3), True, None)
        self.assertTrue(x1 != x2)
        self.assertTrue(x1 != x3)
        self.assertTrue(x2 != x3)
        self.assertEquals(x3, x4)
        self.assertTrue(isinstance(x1, string_types))
        self.assertTrue(isinstance(x2, string_types))
        self.assertTrue(isinstance(x3, string_types))
        self.assertTrue(isinstance(x4, string_types))
        self.assertTrue(len(x1) > 8)
        self.assertTrue(len(x2) > 8)
        self.assertTrue(len(x3) > 8)
        self.assertTrue(len(x4) > 8)
