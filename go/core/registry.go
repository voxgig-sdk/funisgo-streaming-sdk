package core

var UtilityRegistrar func(u *Utility)

var NewBaseFeatureFunc func() Feature

var NewRatelimitFeatureFunc func() Feature

var NewRetryFeatureFunc func() Feature

var NewTestFeatureFunc func() Feature

var NewTimeoutFeatureFunc func() Feature

var NewChannelEntityFunc func(client *FunisgoStreamingSDK, entopts map[string]any) FunisgoStreamingEntity

var NewMovieEntityFunc func(client *FunisgoStreamingSDK, entopts map[string]any) FunisgoStreamingEntity

var NewSeriesEntityFunc func(client *FunisgoStreamingSDK, entopts map[string]any) FunisgoStreamingEntity

