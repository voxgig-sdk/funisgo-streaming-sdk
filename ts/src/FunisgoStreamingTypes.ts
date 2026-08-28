// Typed models for the FunisgoStreaming SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.

export interface Channel {
  category?: string
  createdAt?: string
  description?: string
  id?: string
  isLive?: boolean
  isPremium?: boolean
  language?: string
  logoUrl?: string
  name?: string
  streamUrl?: string
  updatedAt?: string
}

export interface ChannelLoadMatch {
  id: string
}

export interface ChannelListMatch {
  category?: string
  limit?: number
  page?: number
}

export interface ChannelCreateData {
  category?: string
  createdAt?: string
  description?: string
  id?: string
  isLive?: boolean
  isPremium?: boolean
  language?: string
  logoUrl?: string
  name?: string
  streamUrl?: string
  updatedAt?: string
}

export interface ChannelUpdateData {
  id: string
  category?: string
  createdAt?: string
  description?: string
  isLive?: boolean
  isPremium?: boolean
  language?: string
  logoUrl?: string
  name?: string
  streamUrl?: string
  updatedAt?: string
}

export interface ChannelRemoveMatch {
  id: string
}

export interface Movie {
  createdAt?: string
  description?: string
  duration?: number
  genre?: any[]
  id?: string
  isPremium?: boolean
  rating?: number
  releaseYear?: number
  streamUrl?: string
  thumbnailUrl?: string
  title?: string
  updatedAt?: string
}

export interface MovieLoadMatch {
  id: string
}

export interface MovieListMatch {
  genre?: string
  limit?: number
  page?: number
}

export interface MovieCreateData {
  createdAt?: string
  description?: string
  duration?: number
  genre?: any[]
  id?: string
  isPremium?: boolean
  rating?: number
  releaseYear?: number
  streamUrl?: string
  thumbnailUrl?: string
  title?: string
  updatedAt?: string
}

export interface MovieUpdateData {
  id: string
  createdAt?: string
  description?: string
  duration?: number
  genre?: any[]
  isPremium?: boolean
  rating?: number
  releaseYear?: number
  streamUrl?: string
  thumbnailUrl?: string
  title?: string
  updatedAt?: string
}

export interface MovieRemoveMatch {
  id: string
}

export interface Series {
  createdAt?: string
  description?: string
  episodes?: number
  genre?: any[]
  id?: string
  isPremium?: boolean
  rating?: number
  releaseYear?: number
  seasons?: number
  thumbnailUrl?: string
  title?: string
  updatedAt?: string
}

export interface SeriesLoadMatch {
  id: string
}

export interface SeriesListMatch {
  genre?: string
  limit?: number
  page?: number
}

export interface SeriesCreateData {
  createdAt?: string
  description?: string
  episodes?: number
  genre?: any[]
  id?: string
  isPremium?: boolean
  rating?: number
  releaseYear?: number
  seasons?: number
  thumbnailUrl?: string
  title?: string
  updatedAt?: string
}

export interface SeriesUpdateData {
  id: string
  createdAt?: string
  description?: string
  episodes?: number
  genre?: any[]
  isPremium?: boolean
  rating?: number
  releaseYear?: number
  seasons?: number
  thumbnailUrl?: string
  title?: string
  updatedAt?: string
}

export interface SeriesRemoveMatch {
  id: string
}

