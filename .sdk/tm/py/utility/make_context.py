# FunisgoStreaming SDK utility: make_context

from core.context import FunisgoStreamingContext


def make_context_util(ctxmap, basectx):
    return FunisgoStreamingContext(ctxmap, basectx)
