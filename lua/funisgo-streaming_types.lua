-- Typed models for the FunisgoStreaming SDK (LuaLS annotations).
--
-- GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
-- params (op.<name>.points[].args.params[]). Field/param types come from the
-- canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
-- @voxgig/apidef VALID_CANON). Annotations only — no runtime effect. Do not
-- edit by hand.

---@class Channel
---@field category? string
---@field createdAt? string
---@field description? string
---@field id? string
---@field isLive? boolean
---@field isPremium? boolean
---@field language? string
---@field logoUrl? string
---@field name? string
---@field streamUrl? string
---@field updatedAt? string

---@class ChannelLoadMatch
---@field id string

---@class ChannelListMatch
---@field category? string
---@field limit? number
---@field page? number

---@class ChannelCreateData
---@field category? string
---@field createdAt? string
---@field description? string
---@field id? string
---@field isLive? boolean
---@field isPremium? boolean
---@field language? string
---@field logoUrl? string
---@field name? string
---@field streamUrl? string
---@field updatedAt? string

---@class ChannelUpdateData
---@field id string
---@field category? string
---@field createdAt? string
---@field description? string
---@field isLive? boolean
---@field isPremium? boolean
---@field language? string
---@field logoUrl? string
---@field name? string
---@field streamUrl? string
---@field updatedAt? string

---@class ChannelRemoveMatch
---@field id string

---@class Movie
---@field createdAt? string
---@field description? string
---@field duration? number
---@field genre? table
---@field id? string
---@field isPremium? boolean
---@field rating? number
---@field releaseYear? number
---@field streamUrl? string
---@field thumbnailUrl? string
---@field title? string
---@field updatedAt? string

---@class MovieLoadMatch
---@field id string

---@class MovieListMatch
---@field genre? string
---@field limit? number
---@field page? number

---@class MovieCreateData
---@field createdAt? string
---@field description? string
---@field duration? number
---@field genre? table
---@field id? string
---@field isPremium? boolean
---@field rating? number
---@field releaseYear? number
---@field streamUrl? string
---@field thumbnailUrl? string
---@field title? string
---@field updatedAt? string

---@class MovieUpdateData
---@field id string
---@field createdAt? string
---@field description? string
---@field duration? number
---@field genre? table
---@field isPremium? boolean
---@field rating? number
---@field releaseYear? number
---@field streamUrl? string
---@field thumbnailUrl? string
---@field title? string
---@field updatedAt? string

---@class MovieRemoveMatch
---@field id string

---@class Series
---@field createdAt? string
---@field description? string
---@field episodes? number
---@field genre? table
---@field id? string
---@field isPremium? boolean
---@field rating? number
---@field releaseYear? number
---@field seasons? number
---@field thumbnailUrl? string
---@field title? string
---@field updatedAt? string

---@class SeriesLoadMatch
---@field id string

---@class SeriesListMatch
---@field genre? string
---@field limit? number
---@field page? number

---@class SeriesCreateData
---@field createdAt? string
---@field description? string
---@field episodes? number
---@field genre? table
---@field id? string
---@field isPremium? boolean
---@field rating? number
---@field releaseYear? number
---@field seasons? number
---@field thumbnailUrl? string
---@field title? string
---@field updatedAt? string

---@class SeriesUpdateData
---@field id string
---@field createdAt? string
---@field description? string
---@field episodes? number
---@field genre? table
---@field isPremium? boolean
---@field rating? number
---@field releaseYear? number
---@field seasons? number
---@field thumbnailUrl? string
---@field title? string
---@field updatedAt? string

---@class SeriesRemoveMatch
---@field id string

local M = {}

return M
