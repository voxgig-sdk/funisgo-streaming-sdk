import { FunisgoStreamingEntityBase } from '../FunisgoStreamingEntityBase';
import type { FunisgoStreamingSDK } from '../FunisgoStreamingSDK';
import type { Control } from '../types';
import type { Movie, MovieLoadMatch, MovieListMatch, MovieCreateData, MovieUpdateData, MovieRemoveMatch } from '../FunisgoStreamingTypes';
declare class MovieEntity extends FunisgoStreamingEntityBase<Movie> {
    constructor(client: FunisgoStreamingSDK, entopts: any);
    make(this: MovieEntity): MovieEntity;
    load(this: any, reqmatch?: MovieLoadMatch, ctrl?: Control): Promise<MovieEntity>;
    list(this: any, reqmatch?: MovieListMatch, ctrl?: Control): Promise<MovieEntity[]>;
    create(this: any, reqdata?: MovieCreateData, ctrl?: Control): Promise<MovieEntity>;
    update(this: any, reqdata?: MovieUpdateData, ctrl?: Control): Promise<MovieEntity>;
    remove(this: any, reqmatch?: MovieRemoveMatch, ctrl?: Control): Promise<MovieEntity>;
}
export { MovieEntity };
