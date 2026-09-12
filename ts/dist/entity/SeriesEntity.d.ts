import { FunisgoStreamingEntityBase } from '../FunisgoStreamingEntityBase';
import type { FunisgoStreamingSDK } from '../FunisgoStreamingSDK';
import type { Control } from '../types';
import type { Series, SeriesLoadMatch, SeriesListMatch, SeriesCreateData, SeriesUpdateData, SeriesRemoveMatch } from '../FunisgoStreamingTypes';
declare class SeriesEntity extends FunisgoStreamingEntityBase<Series> {
    constructor(client: FunisgoStreamingSDK, entopts: any);
    make(this: SeriesEntity): SeriesEntity;
    load(this: any, reqmatch?: SeriesLoadMatch, ctrl?: Control): Promise<SeriesEntity>;
    list(this: any, reqmatch?: SeriesListMatch, ctrl?: Control): Promise<SeriesEntity[]>;
    create(this: any, reqdata?: SeriesCreateData, ctrl?: Control): Promise<SeriesEntity>;
    update(this: any, reqdata?: SeriesUpdateData, ctrl?: Control): Promise<SeriesEntity>;
    remove(this: any, reqmatch?: SeriesRemoveMatch, ctrl?: Control): Promise<SeriesEntity>;
}
export { SeriesEntity };
