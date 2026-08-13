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
#   @return [String, nil]
#
# @!attribute [rw] createdAt
#   @return [String, nil]
#
# @!attribute [rw] description
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] isLive
#   @return [Boolean, nil]
#
# @!attribute [rw] isPremium
#   @return [Boolean, nil]
#
# @!attribute [rw] language
#   @return [String, nil]
#
# @!attribute [rw] logoUrl
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] streamUrl
#   @return [String, nil]
#
# @!attribute [rw] updatedAt
#   @return [String, nil]
Channel = Struct.new(
  :category,
  :createdAt,
  :description,
  :id,
  :isLive,
  :isPremium,
  :language,
  :logoUrl,
  :name,
  :streamUrl,
  :updatedAt,
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
# @!attribute [rw] createdAt
#   @return [String, nil]
#
# @!attribute [rw] description
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] isLive
#   @return [Boolean, nil]
#
# @!attribute [rw] isPremium
#   @return [Boolean, nil]
#
# @!attribute [rw] language
#   @return [String, nil]
#
# @!attribute [rw] logoUrl
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] streamUrl
#   @return [String, nil]
#
# @!attribute [rw] updatedAt
#   @return [String, nil]
ChannelListMatch = Struct.new(
  :category,
  :createdAt,
  :description,
  :id,
  :isLive,
  :isPremium,
  :language,
  :logoUrl,
  :name,
  :streamUrl,
  :updatedAt,
  keyword_init: true
)

# Request payload for Channel#create.
#
# @!attribute [rw] category
#   @return [String, nil]
#
# @!attribute [rw] createdAt
#   @return [String, nil]
#
# @!attribute [rw] description
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] isLive
#   @return [Boolean, nil]
#
# @!attribute [rw] isPremium
#   @return [Boolean, nil]
#
# @!attribute [rw] language
#   @return [String, nil]
#
# @!attribute [rw] logoUrl
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] streamUrl
#   @return [String, nil]
#
# @!attribute [rw] updatedAt
#   @return [String, nil]
ChannelCreateData = Struct.new(
  :category,
  :createdAt,
  :description,
  :id,
  :isLive,
  :isPremium,
  :language,
  :logoUrl,
  :name,
  :streamUrl,
  :updatedAt,
  keyword_init: true
)

# Request payload for Channel#update.
#
# @!attribute [rw] id
#   @return [String]
#
# @!attribute [rw] category
#   @return [String, nil]
#
# @!attribute [rw] createdAt
#   @return [String, nil]
#
# @!attribute [rw] description
#   @return [String, nil]
#
# @!attribute [rw] isLive
#   @return [Boolean, nil]
#
# @!attribute [rw] isPremium
#   @return [Boolean, nil]
#
# @!attribute [rw] language
#   @return [String, nil]
#
# @!attribute [rw] logoUrl
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] streamUrl
#   @return [String, nil]
#
# @!attribute [rw] updatedAt
#   @return [String, nil]
ChannelUpdateData = Struct.new(
  :id,
  :category,
  :createdAt,
  :description,
  :isLive,
  :isPremium,
  :language,
  :logoUrl,
  :name,
  :streamUrl,
  :updatedAt,
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
# @!attribute [rw] createdAt
#   @return [String, nil]
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
# @!attribute [rw] isPremium
#   @return [Boolean, nil]
#
# @!attribute [rw] rating
#   @return [Float, nil]
#
# @!attribute [rw] releaseYear
#   @return [Integer, nil]
#
# @!attribute [rw] streamUrl
#   @return [String, nil]
#
# @!attribute [rw] thumbnailUrl
#   @return [String, nil]
#
# @!attribute [rw] title
#   @return [String, nil]
#
# @!attribute [rw] updatedAt
#   @return [String, nil]
Movie = Struct.new(
  :createdAt,
  :description,
  :duration,
  :genre,
  :id,
  :isPremium,
  :rating,
  :releaseYear,
  :streamUrl,
  :thumbnailUrl,
  :title,
  :updatedAt,
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
# @!attribute [rw] createdAt
#   @return [String, nil]
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
# @!attribute [rw] isPremium
#   @return [Boolean, nil]
#
# @!attribute [rw] rating
#   @return [Float, nil]
#
# @!attribute [rw] releaseYear
#   @return [Integer, nil]
#
# @!attribute [rw] streamUrl
#   @return [String, nil]
#
# @!attribute [rw] thumbnailUrl
#   @return [String, nil]
#
# @!attribute [rw] title
#   @return [String, nil]
#
# @!attribute [rw] updatedAt
#   @return [String, nil]
MovieListMatch = Struct.new(
  :createdAt,
  :description,
  :duration,
  :genre,
  :id,
  :isPremium,
  :rating,
  :releaseYear,
  :streamUrl,
  :thumbnailUrl,
  :title,
  :updatedAt,
  keyword_init: true
)

# Request payload for Movie#create.
#
# @!attribute [rw] createdAt
#   @return [String, nil]
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
# @!attribute [rw] isPremium
#   @return [Boolean, nil]
#
# @!attribute [rw] rating
#   @return [Float, nil]
#
# @!attribute [rw] releaseYear
#   @return [Integer, nil]
#
# @!attribute [rw] streamUrl
#   @return [String, nil]
#
# @!attribute [rw] thumbnailUrl
#   @return [String, nil]
#
# @!attribute [rw] title
#   @return [String, nil]
#
# @!attribute [rw] updatedAt
#   @return [String, nil]
MovieCreateData = Struct.new(
  :createdAt,
  :description,
  :duration,
  :genre,
  :id,
  :isPremium,
  :rating,
  :releaseYear,
  :streamUrl,
  :thumbnailUrl,
  :title,
  :updatedAt,
  keyword_init: true
)

# Request payload for Movie#update.
#
# @!attribute [rw] id
#   @return [String]
#
# @!attribute [rw] createdAt
#   @return [String, nil]
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
# @!attribute [rw] isPremium
#   @return [Boolean, nil]
#
# @!attribute [rw] rating
#   @return [Float, nil]
#
# @!attribute [rw] releaseYear
#   @return [Integer, nil]
#
# @!attribute [rw] streamUrl
#   @return [String, nil]
#
# @!attribute [rw] thumbnailUrl
#   @return [String, nil]
#
# @!attribute [rw] title
#   @return [String, nil]
#
# @!attribute [rw] updatedAt
#   @return [String, nil]
MovieUpdateData = Struct.new(
  :id,
  :createdAt,
  :description,
  :duration,
  :genre,
  :isPremium,
  :rating,
  :releaseYear,
  :streamUrl,
  :thumbnailUrl,
  :title,
  :updatedAt,
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
# @!attribute [rw] createdAt
#   @return [String, nil]
#
# @!attribute [rw] description
#   @return [String, nil]
#
# @!attribute [rw] episodes
#   @return [Integer, nil]
#
# @!attribute [rw] genre
#   @return [Array, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] isPremium
#   @return [Boolean, nil]
#
# @!attribute [rw] rating
#   @return [Float, nil]
#
# @!attribute [rw] releaseYear
#   @return [Integer, nil]
#
# @!attribute [rw] seasons
#   @return [Integer, nil]
#
# @!attribute [rw] thumbnailUrl
#   @return [String, nil]
#
# @!attribute [rw] title
#   @return [String, nil]
#
# @!attribute [rw] updatedAt
#   @return [String, nil]
Series = Struct.new(
  :createdAt,
  :description,
  :episodes,
  :genre,
  :id,
  :isPremium,
  :rating,
  :releaseYear,
  :seasons,
  :thumbnailUrl,
  :title,
  :updatedAt,
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
# @!attribute [rw] createdAt
#   @return [String, nil]
#
# @!attribute [rw] description
#   @return [String, nil]
#
# @!attribute [rw] episodes
#   @return [Integer, nil]
#
# @!attribute [rw] genre
#   @return [Array, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] isPremium
#   @return [Boolean, nil]
#
# @!attribute [rw] rating
#   @return [Float, nil]
#
# @!attribute [rw] releaseYear
#   @return [Integer, nil]
#
# @!attribute [rw] seasons
#   @return [Integer, nil]
#
# @!attribute [rw] thumbnailUrl
#   @return [String, nil]
#
# @!attribute [rw] title
#   @return [String, nil]
#
# @!attribute [rw] updatedAt
#   @return [String, nil]
SeriesListMatch = Struct.new(
  :createdAt,
  :description,
  :episodes,
  :genre,
  :id,
  :isPremium,
  :rating,
  :releaseYear,
  :seasons,
  :thumbnailUrl,
  :title,
  :updatedAt,
  keyword_init: true
)

# Request payload for Series#create.
#
# @!attribute [rw] createdAt
#   @return [String, nil]
#
# @!attribute [rw] description
#   @return [String, nil]
#
# @!attribute [rw] episodes
#   @return [Integer, nil]
#
# @!attribute [rw] genre
#   @return [Array, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] isPremium
#   @return [Boolean, nil]
#
# @!attribute [rw] rating
#   @return [Float, nil]
#
# @!attribute [rw] releaseYear
#   @return [Integer, nil]
#
# @!attribute [rw] seasons
#   @return [Integer, nil]
#
# @!attribute [rw] thumbnailUrl
#   @return [String, nil]
#
# @!attribute [rw] title
#   @return [String, nil]
#
# @!attribute [rw] updatedAt
#   @return [String, nil]
SeriesCreateData = Struct.new(
  :createdAt,
  :description,
  :episodes,
  :genre,
  :id,
  :isPremium,
  :rating,
  :releaseYear,
  :seasons,
  :thumbnailUrl,
  :title,
  :updatedAt,
  keyword_init: true
)

# Request payload for Series#update.
#
# @!attribute [rw] id
#   @return [String]
#
# @!attribute [rw] createdAt
#   @return [String, nil]
#
# @!attribute [rw] description
#   @return [String, nil]
#
# @!attribute [rw] episodes
#   @return [Integer, nil]
#
# @!attribute [rw] genre
#   @return [Array, nil]
#
# @!attribute [rw] isPremium
#   @return [Boolean, nil]
#
# @!attribute [rw] rating
#   @return [Float, nil]
#
# @!attribute [rw] releaseYear
#   @return [Integer, nil]
#
# @!attribute [rw] seasons
#   @return [Integer, nil]
#
# @!attribute [rw] thumbnailUrl
#   @return [String, nil]
#
# @!attribute [rw] title
#   @return [String, nil]
#
# @!attribute [rw] updatedAt
#   @return [String, nil]
SeriesUpdateData = Struct.new(
  :id,
  :createdAt,
  :description,
  :episodes,
  :genre,
  :isPremium,
  :rating,
  :releaseYear,
  :seasons,
  :thumbnailUrl,
  :title,
  :updatedAt,
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

