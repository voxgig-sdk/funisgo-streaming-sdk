# FunisgoStreaming SDK utility: make_error

from __future__ import annotations
from core.operation import FunisgoStreamingOperation
from core.result import FunisgoStreamingResult
from core.control import FunisgoStreamingControl
from core.error import FunisgoStreamingError


def make_error_util(ctx, err):
    if ctx is None:
        from core.context import FunisgoStreamingContext
        ctx = FunisgoStreamingContext({}, None)

    op = ctx.op
    if op is None:
        op = FunisgoStreamingOperation({})
    opname = op.name
    if opname == "" or opname == "_":
        opname = "unknown operation"

    result = ctx.result
    if result is None:
        result = FunisgoStreamingResult({})
    result.ok = False

    if err is None:
        err = result.err
    if err is None:
        err = ctx.make_error("unknown", "unknown error")

    errmsg = ""
    if isinstance(err, FunisgoStreamingError):
        errmsg = err.msg
    elif hasattr(err, "msg") and err.msg is not None:
        errmsg = err.msg
    elif isinstance(err, str):
        errmsg = err
    else:
        errmsg = str(err)

    msg = "FunisgoStreamingSDK: " + opname + ": " + errmsg
    msg = ctx.utility.clean(ctx, msg)

    result.err = None

    spec = ctx.spec

    if ctx.ctrl.explain is not None:
        ctx.ctrl.explain["err"] = {"message": msg}

    sdk_err = FunisgoStreamingError("", msg, ctx)
    sdk_err.result = ctx.utility.clean(ctx, result)
    sdk_err.spec = ctx.utility.clean(ctx, spec)

    if isinstance(err, FunisgoStreamingError):
        sdk_err.code = err.code

    ctx.ctrl.err = sdk_err

    if ctx.ctrl.throw_err is False:
        return result.resdata

    raise sdk_err
