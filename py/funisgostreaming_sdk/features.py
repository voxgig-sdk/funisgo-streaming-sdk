# FunisgoStreaming SDK feature factory

from funisgostreaming_sdk.feature.base_feature import FunisgoStreamingBaseFeature
from funisgostreaming_sdk.feature.test_feature import FunisgoStreamingTestFeature


def _make_feature(name):
    features = {
        "base": lambda: FunisgoStreamingBaseFeature(),
        "test": lambda: FunisgoStreamingTestFeature(),
    }
    factory = features.get(name)
    if factory is not None:
        return factory()
    return features["base"]()
