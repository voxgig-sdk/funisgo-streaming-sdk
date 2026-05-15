package voxgigfunisgostreamingsdk

import (
	"github.com/voxgig-sdk/funisgo-streaming-sdk/core"
	"github.com/voxgig-sdk/funisgo-streaming-sdk/entity"
	"github.com/voxgig-sdk/funisgo-streaming-sdk/feature"
	_ "github.com/voxgig-sdk/funisgo-streaming-sdk/utility"
)

// Type aliases preserve external API.
type FunisgoStreamingSDK = core.FunisgoStreamingSDK
type Context = core.Context
type Utility = core.Utility
type Feature = core.Feature
type Entity = core.Entity
type FunisgoStreamingEntity = core.FunisgoStreamingEntity
type FetcherFunc = core.FetcherFunc
type Spec = core.Spec
type Result = core.Result
type Response = core.Response
type Operation = core.Operation
type Control = core.Control
type FunisgoStreamingError = core.FunisgoStreamingError

// BaseFeature from feature package.
type BaseFeature = feature.BaseFeature

func init() {
	core.NewBaseFeatureFunc = func() core.Feature {
		return feature.NewBaseFeature()
	}
	core.NewTestFeatureFunc = func() core.Feature {
		return feature.NewTestFeature()
	}
	core.NewChannelEntityFunc = func(client *core.FunisgoStreamingSDK, entopts map[string]any) core.FunisgoStreamingEntity {
		return entity.NewChannelEntity(client, entopts)
	}
	core.NewMovieEntityFunc = func(client *core.FunisgoStreamingSDK, entopts map[string]any) core.FunisgoStreamingEntity {
		return entity.NewMovieEntity(client, entopts)
	}
	core.NewSeriesEntityFunc = func(client *core.FunisgoStreamingSDK, entopts map[string]any) core.FunisgoStreamingEntity {
		return entity.NewSeriesEntity(client, entopts)
	}
}

// Constructor re-exports.
var NewFunisgoStreamingSDK = core.NewFunisgoStreamingSDK
var TestSDK = core.TestSDK
var NewContext = core.NewContext
var NewSpec = core.NewSpec
var NewResult = core.NewResult
var NewResponse = core.NewResponse
var NewOperation = core.NewOperation
var MakeConfig = core.MakeConfig
var NewBaseFeature = feature.NewBaseFeature
var NewTestFeature = feature.NewTestFeature
