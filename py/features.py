# FunisgoStreaming SDK feature factory

from feature.base_feature import FunisgoStreamingBaseFeature
from feature.test_feature import FunisgoStreamingTestFeature


def _make_feature(name):
    features = {
        "base": lambda: FunisgoStreamingBaseFeature(),
        "test": lambda: FunisgoStreamingTestFeature(),
    }
    factory = features.get(name)
    if factory is not None:
        return factory()
    return features["base"]()
