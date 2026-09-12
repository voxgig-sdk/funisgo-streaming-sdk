import { FunisgoStreamingEntityBase } from '../FunisgoStreamingEntityBase';
import type { FunisgoStreamingSDK } from '../FunisgoStreamingSDK';
import type { Control } from '../types';
import type { Channel, ChannelLoadMatch, ChannelListMatch, ChannelCreateData, ChannelUpdateData, ChannelRemoveMatch } from '../FunisgoStreamingTypes';
declare class ChannelEntity extends FunisgoStreamingEntityBase<Channel> {
    constructor(client: FunisgoStreamingSDK, entopts: any);
    make(this: ChannelEntity): ChannelEntity;
    load(this: any, reqmatch?: ChannelLoadMatch, ctrl?: Control): Promise<ChannelEntity>;
    list(this: any, reqmatch?: ChannelListMatch, ctrl?: Control): Promise<ChannelEntity[]>;
    create(this: any, reqdata?: ChannelCreateData, ctrl?: Control): Promise<ChannelEntity>;
    update(this: any, reqdata?: ChannelUpdateData, ctrl?: Control): Promise<ChannelEntity>;
    remove(this: any, reqmatch?: ChannelRemoveMatch, ctrl?: Control): Promise<ChannelEntity>;
}
export { ChannelEntity };
