# frozen_string_literal: true

# Typed models for the FunisgoStreaming SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Member types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Ruby types are unenforced; these YARD
# annotations document the shapes. Do not edit by hand.

# Channel entity data model.
#
# @!attribute [rw] category
#   @return [String]
#
# @!attribute [rw] created_at
#   @return [String, nil]
#
# @!attribute [rw] data
#   @return [Hash, nil]
#
# @!attribute [rw] description
#   @return [String]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] is_live
#   @return [Boolean, nil]
#
# @!attribute [rw] is_premium
#   @return [Boolean, nil]
#
# @!attribute [rw] language
#   @return [String, nil]
#
# @!attribute [rw] logo_url
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String]
#
# @!attribute [rw] stream_url
#   @return [String, nil]
#
# @!attribute [rw] success
#   @return [Boolean, nil]
#
# @!attribute [rw] updated_at
#   @return [String, nil]
Channel = Struct.new(
  :category,
  :created_at,
  :data,
  :description,
  :id,
  :is_live,
  :is_premium,
  :language,
  :logo_url,
  :name,
  :stream_url,
  :success,
  :updated_at,
  keyword_init: true
)

# Request payload for Channel#load.
#
# @!attribute [rw] id
#   @return [String]
ChannelLoadMatch = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for Channel#list.
#
# @!attribute [rw] category
#   @return [String, nil]
#
# @!attribute [rw] created_at
#   @return [String, nil]
#
# @!attribute [rw] data
#   @return [Hash, nil]
#
# @!attribute [rw] description
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] is_live
#   @return [Boolean, nil]
#
# @!attribute [rw] is_premium
#   @return [Boolean, nil]
#
# @!attribute [rw] language
#   @return [String, nil]
#
# @!attribute [rw] logo_url
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] stream_url
#   @return [String, nil]
#
# @!attribute [rw] success
#   @return [Boolean, nil]
#
# @!attribute [rw] updated_at
#   @return [String, nil]
ChannelListMatch = Struct.new(
  :category,
  :created_at,
  :data,
  :description,
  :id,
  :is_live,
  :is_premium,
  :language,
  :logo_url,
  :name,
  :stream_url,
  :success,
  :updated_at,
  keyword_init: true
)

# Request payload for Channel#create.
#
# @!attribute [rw] category
#   @return [String]
#
# @!attribute [rw] created_at
#   @return [String, nil]
#
# @!attribute [rw] data
#   @return [Hash, nil]
#
# @!attribute [rw] description
#   @return [String]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] is_live
#   @return [Boolean, nil]
#
# @!attribute [rw] is_premium
#   @return [Boolean, nil]
#
# @!attribute [rw] language
#   @return [String, nil]
#
# @!attribute [rw] logo_url
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String]
#
# @!attribute [rw] stream_url
#   @return [String, nil]
#
# @!attribute [rw] success
#   @return [Boolean, nil]
#
# @!attribute [rw] updated_at
#   @return [String, nil]
ChannelCreateData = Struct.new(
  :category,
  :created_at,
  :data,
  :description,
  :id,
  :is_live,
  :is_premium,
  :language,
  :logo_url,
  :name,
  :stream_url,
  :success,
  :updated_at,
  keyword_init: true
)

# Request payload for Channel#update.
#
# @!attribute [rw] id
#   @return [String]
ChannelUpdateData = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for Channel#remove.
#
# @!attribute [rw] id
#   @return [String]
ChannelRemoveMatch = Struct.new(
  :id,
  keyword_init: true
)

# Movie entity data model.
#
# @!attribute [rw] created_at
#   @return [String, nil]
#
# @!attribute [rw] data
#   @return [Hash, nil]
#
# @!attribute [rw] description
#   @return [String]
#
# @!attribute [rw] duration
#   @return [Integer]
#
# @!attribute [rw] genre
#   @return [Array]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] is_premium
#   @return [Boolean, nil]
#
# @!attribute [rw] rating
#   @return [Float, nil]
#
# @!attribute [rw] release_year
#   @return [Integer]
#
# @!attribute [rw] stream_url
#   @return [String, nil]
#
# @!attribute [rw] success
#   @return [Boolean, nil]
#
# @!attribute [rw] thumbnail_url
#   @return [String, nil]
#
# @!attribute [rw] title
#   @return [String]
#
# @!attribute [rw] updated_at
#   @return [String, nil]
Movie = Struct.new(
  :created_at,
  :data,
  :description,
  :duration,
  :genre,
  :id,
  :is_premium,
  :rating,
  :release_year,
  :stream_url,
  :success,
  :thumbnail_url,
  :title,
  :updated_at,
  keyword_init: true
)

# Request payload for Movie#load.
#
# @!attribute [rw] id
#   @return [String]
MovieLoadMatch = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for Movie#list.
#
# @!attribute [rw] created_at
#   @return [String, nil]
#
# @!attribute [rw] data
#   @return [Hash, nil]
#
# @!attribute [rw] description
#   @return [String, nil]
#
# @!attribute [rw] duration
#   @return [Integer, nil]
#
# @!attribute [rw] genre
#   @return [Array, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] is_premium
#   @return [Boolean, nil]
#
# @!attribute [rw] rating
#   @return [Float, nil]
#
# @!attribute [rw] release_year
#   @return [Integer, nil]
#
# @!attribute [rw] stream_url
#   @return [String, nil]
#
# @!attribute [rw] success
#   @return [Boolean, nil]
#
# @!attribute [rw] thumbnail_url
#   @return [String, nil]
#
# @!attribute [rw] title
#   @return [String, nil]
#
# @!attribute [rw] updated_at
#   @return [String, nil]
MovieListMatch = Struct.new(
  :created_at,
  :data,
  :description,
  :duration,
  :genre,
  :id,
  :is_premium,
  :rating,
  :release_year,
  :stream_url,
  :success,
  :thumbnail_url,
  :title,
  :updated_at,
  keyword_init: true
)

# Request payload for Movie#create.
#
# @!attribute [rw] created_at
#   @return [String, nil]
#
# @!attribute [rw] data
#   @return [Hash, nil]
#
# @!attribute [rw] description
#   @return [String]
#
# @!attribute [rw] duration
#   @return [Integer]
#
# @!attribute [rw] genre
#   @return [Array]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] is_premium
#   @return [Boolean, nil]
#
# @!attribute [rw] rating
#   @return [Float, nil]
#
# @!attribute [rw] release_year
#   @return [Integer]
#
# @!attribute [rw] stream_url
#   @return [String, nil]
#
# @!attribute [rw] success
#   @return [Boolean, nil]
#
# @!attribute [rw] thumbnail_url
#   @return [String, nil]
#
# @!attribute [rw] title
#   @return [String]
#
# @!attribute [rw] updated_at
#   @return [String, nil]
MovieCreateData = Struct.new(
  :created_at,
  :data,
  :description,
  :duration,
  :genre,
  :id,
  :is_premium,
  :rating,
  :release_year,
  :stream_url,
  :success,
  :thumbnail_url,
  :title,
  :updated_at,
  keyword_init: true
)

# Request payload for Movie#update.
#
# @!attribute [rw] id
#   @return [String]
MovieUpdateData = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for Movie#remove.
#
# @!attribute [rw] id
#   @return [String]
MovieRemoveMatch = Struct.new(
  :id,
  keyword_init: true
)

# Series entity data model.
#
# @!attribute [rw] created_at
#   @return [String, nil]
#
# @!attribute [rw] data
#   @return [Hash, nil]
#
# @!attribute [rw] description
#   @return [String]
#
# @!attribute [rw] episode
#   @return [Integer, nil]
#
# @!attribute [rw] genre
#   @return [Array]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] is_premium
#   @return [Boolean, nil]
#
# @!attribute [rw] rating
#   @return [Float, nil]
#
# @!attribute [rw] release_year
#   @return [Integer]
#
# @!attribute [rw] season
#   @return [Integer, nil]
#
# @!attribute [rw] success
#   @return [Boolean, nil]
#
# @!attribute [rw] thumbnail_url
#   @return [String, nil]
#
# @!attribute [rw] title
#   @return [String]
#
# @!attribute [rw] updated_at
#   @return [String, nil]
Series = Struct.new(
  :created_at,
  :data,
  :description,
  :episode,
  :genre,
  :id,
  :is_premium,
  :rating,
  :release_year,
  :season,
  :success,
  :thumbnail_url,
  :title,
  :updated_at,
  keyword_init: true
)

# Request payload for Series#load.
#
# @!attribute [rw] id
#   @return [String]
SeriesLoadMatch = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for Series#list.
#
# @!attribute [rw] created_at
#   @return [String, nil]
#
# @!attribute [rw] data
#   @return [Hash, nil]
#
# @!attribute [rw] description
#   @return [String, nil]
#
# @!attribute [rw] episode
#   @return [Integer, nil]
#
# @!attribute [rw] genre
#   @return [Array, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] is_premium
#   @return [Boolean, nil]
#
# @!attribute [rw] rating
#   @return [Float, nil]
#
# @!attribute [rw] release_year
#   @return [Integer, nil]
#
# @!attribute [rw] season
#   @return [Integer, nil]
#
# @!attribute [rw] success
#   @return [Boolean, nil]
#
# @!attribute [rw] thumbnail_url
#   @return [String, nil]
#
# @!attribute [rw] title
#   @return [String, nil]
#
# @!attribute [rw] updated_at
#   @return [String, nil]
SeriesListMatch = Struct.new(
  :created_at,
  :data,
  :description,
  :episode,
  :genre,
  :id,
  :is_premium,
  :rating,
  :release_year,
  :season,
  :success,
  :thumbnail_url,
  :title,
  :updated_at,
  keyword_init: true
)

# Request payload for Series#create.
#
# @!attribute [rw] created_at
#   @return [String, nil]
#
# @!attribute [rw] data
#   @return [Hash, nil]
#
# @!attribute [rw] description
#   @return [String]
#
# @!attribute [rw] episode
#   @return [Integer, nil]
#
# @!attribute [rw] genre
#   @return [Array]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] is_premium
#   @return [Boolean, nil]
#
# @!attribute [rw] rating
#   @return [Float, nil]
#
# @!attribute [rw] release_year
#   @return [Integer]
#
# @!attribute [rw] season
#   @return [Integer, nil]
#
# @!attribute [rw] success
#   @return [Boolean, nil]
#
# @!attribute [rw] thumbnail_url
#   @return [String, nil]
#
# @!attribute [rw] title
#   @return [String]
#
# @!attribute [rw] updated_at
#   @return [String, nil]
SeriesCreateData = Struct.new(
  :created_at,
  :data,
  :description,
  :episode,
  :genre,
  :id,
  :is_premium,
  :rating,
  :release_year,
  :season,
  :success,
  :thumbnail_url,
  :title,
  :updated_at,
  keyword_init: true
)

# Request payload for Series#update.
#
# @!attribute [rw] id
#   @return [String]
SeriesUpdateData = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for Series#remove.
#
# @!attribute [rw] id
#   @return [String]
SeriesRemoveMatch = Struct.new(
  :id,
  keyword_init: true
)

