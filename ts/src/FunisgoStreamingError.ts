
import { Context } from './Context'


class FunisgoStreamingError extends Error {

  isFunisgoStreamingError = true

  sdk = 'FunisgoStreaming'

  code: string
  ctx: Context

  constructor(code: string, msg: string, ctx: Context) {
    super(msg)
    this.code = code
    this.ctx = ctx
  }

}

export {
  FunisgoStreamingError
}

