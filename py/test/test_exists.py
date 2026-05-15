# ProjectName SDK exists test

import pytest
from funisgostreaming_sdk import FunisgoStreamingSDK


class TestExists:

    def test_should_create_test_sdk(self):
        testsdk = FunisgoStreamingSDK.test(None, None)
        assert testsdk is not None
