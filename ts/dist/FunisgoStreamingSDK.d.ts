import { ChannelEntity } from './entity/ChannelEntity';
import { MovieEntity } from './entity/MovieEntity';
import { SeriesEntity } from './entity/SeriesEntity';
export type * from './FunisgoStreamingTypes';
import { inspect } from 'node:util';
import type { Context, Feature } from './types';
import { config } from './Config';
import { FunisgoStreamingEntityBase } from './FunisgoStreamingEntityBase';
import { Utility } from './utility/Utility';
import { BaseFeature } from './feature/base/BaseFeature';
declare const stdutil: Utility;
declare class FunisgoStreamingSDK {
    _mode: string;
    _options: any;
    _utility: Utility;
    _features: Feature[];
    _rootctx: Context;
    constructor(options?: any);
    options(): any;
    utility(): any;
    prepare(fetchargs?: any): Promise<any>;
    direct(fetchargs?: any): Promise<Error | {
        ok: boolean;
        status: number;
        headers: any;
        data: any;
        err?: undefined;
    } | {
        ok: boolean;
        err: any;
        status?: undefined;
        headers?: undefined;
        data?: undefined;
    }>;
    _rawRequest(fetchargs?: any): Promise<Error | {
        ok: boolean;
        status: number;
        headers: any;
        data: any;
        err?: undefined;
    } | {
        ok: boolean;
        err: any;
        status?: undefined;
        headers?: undefined;
        data?: undefined;
    }>;
    graphql(query: string, variables?: any, ctrl?: any): Promise<any>;
    Channel(entopts?: Record<string, any>): ChannelEntity;
    Movie(entopts?: Record<string, any>): MovieEntity;
    Series(entopts?: Record<string, any>): SeriesEntity;
    static test(testoptsarg?: any, sdkoptsarg?: any): FunisgoStreamingSDK;
    tester(testopts?: any, sdkopts?: any): FunisgoStreamingSDK;
    toJSON(): {
        name: string;
    };
    toString(): string;
    [inspect.custom](): string;
}
declare const SDK: typeof FunisgoStreamingSDK;
export { stdutil, config, BaseFeature, FunisgoStreamingEntityBase, FunisgoStreamingSDK, SDK, };
