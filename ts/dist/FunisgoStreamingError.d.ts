import { Context } from './Context';
declare class FunisgoStreamingError extends Error {
    isFunisgoStreamingError: boolean;
    sdk: string;
    code: string;
    ctx: Context;
    status: number;
    get notFound(): boolean;
    constructor(code: string, msg: string, ctx: Context);
}
export { FunisgoStreamingError };
