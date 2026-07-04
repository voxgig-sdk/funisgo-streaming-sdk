-- Typed models for the FunisgoStreaming SDK (LuaLS annotations).
--
-- GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
-- params (op.<name>.points[].args.params[]). Field/param types come from the
-- canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
-- @voxgig/apidef VALID_CANON). Annotations only — no runtime effect. Do not
-- edit by hand.

---@class Channel
---@field category string
---@field created_at? string
---@field data? table
---@field description string
---@field id? string
---@field is_live? boolean
---@field is_premium? boolean
---@field language? string
---@field logo_url? string
---@field name string
---@field stream_url? string
---@field success? boolean
---@field updated_at? string

---@class ChannelLoadMatch
---@field id string

---@class ChannelListMatch

---@class ChannelCreateData

---@class ChannelUpdateData
---@field id string

---@class ChannelRemoveMatch
---@field id string

---@class Movie
---@field created_at? string
---@field data? table
---@field description string
---@field duration number
---@field genre table
---@field id? string
---@field is_premium? boolean
---@field rating? number
---@field release_year number
---@field stream_url? string
---@field success? boolean
---@field thumbnail_url? string
---@field title string
---@field updated_at? string

---@class MovieLoadMatch
---@field id string

---@class MovieListMatch

---@class MovieCreateData

---@class MovieUpdateData
---@field id string

---@class MovieRemoveMatch
---@field id string

---@class Series
---@field created_at? string
---@field data? table
---@field description string
---@field episode? number
---@field genre table
---@field id? string
---@field is_premium? boolean
---@field rating? number
---@field release_year number
---@field season? number
---@field success? boolean
---@field thumbnail_url? string
---@field title string
---@field updated_at? string

---@class SeriesLoadMatch
---@field id string

---@class SeriesListMatch

---@class SeriesCreateData

---@class SeriesUpdateData
---@field id string

---@class SeriesRemoveMatch
---@field id string

local M = {}

return M
