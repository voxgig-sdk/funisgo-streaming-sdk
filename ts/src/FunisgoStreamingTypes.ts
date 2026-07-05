// Typed models for the FunisgoStreaming SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.

export interface Channel {
  category: string
  created_at?: string
  data?: Record<string, any>
  description: string
  id?: string
  is_live?: boolean
  is_premium?: boolean
  language?: string
  logo_url?: string
  name: string
  stream_url?: string
  success?: boolean
  updated_at?: string
}

export interface ChannelLoadMatch {
  id: string
}

export interface ChannelListMatch {
  category?: string
  created_at?: string
  data?: Record<string, any>
  description?: string
  id?: string
  is_live?: boolean
  is_premium?: boolean
  language?: string
  logo_url?: string
  name?: string
  stream_url?: string
  success?: boolean
  updated_at?: string
}

export interface ChannelCreateData {
  category: string
  created_at?: string
  data?: Record<string, any>
  description: string
  id?: string
  is_live?: boolean
  is_premium?: boolean
  language?: string
  logo_url?: string
  name: string
  stream_url?: string
  success?: boolean
  updated_at?: string
}

export interface ChannelUpdateData {
  id: string
}

export interface ChannelRemoveMatch {
  id: string
}

export interface Movie {
  created_at?: string
  data?: Record<string, any>
  description: string
  duration: number
  genre: any[]
  id?: string
  is_premium?: boolean
  rating?: number
  release_year: number
  stream_url?: string
  success?: boolean
  thumbnail_url?: string
  title: string
  updated_at?: string
}

export interface MovieLoadMatch {
  id: string
}

export interface MovieListMatch {
  created_at?: string
  data?: Record<string, any>
  description?: string
  duration?: number
  genre?: any[]
  id?: string
  is_premium?: boolean
  rating?: number
  release_year?: number
  stream_url?: string
  success?: boolean
  thumbnail_url?: string
  title?: string
  updated_at?: string
}

export interface MovieCreateData {
  created_at?: string
  data?: Record<string, any>
  description: string
  duration: number
  genre: any[]
  id?: string
  is_premium?: boolean
  rating?: number
  release_year: number
  stream_url?: string
  success?: boolean
  thumbnail_url?: string
  title: string
  updated_at?: string
}

export interface MovieUpdateData {
  id: string
}

export interface MovieRemoveMatch {
  id: string
}

export interface Series {
  created_at?: string
  data?: Record<string, any>
  description: string
  episode?: number
  genre: any[]
  id?: string
  is_premium?: boolean
  rating?: number
  release_year: number
  season?: number
  success?: boolean
  thumbnail_url?: string
  title: string
  updated_at?: string
}

export interface SeriesLoadMatch {
  id: string
}

export interface SeriesListMatch {
  created_at?: string
  data?: Record<string, any>
  description?: string
  episode?: number
  genre?: any[]
  id?: string
  is_premium?: boolean
  rating?: number
  release_year?: number
  season?: number
  success?: boolean
  thumbnail_url?: string
  title?: string
  updated_at?: string
}

export interface SeriesCreateData {
  created_at?: string
  data?: Record<string, any>
  description: string
  episode?: number
  genre: any[]
  id?: string
  is_premium?: boolean
  rating?: number
  release_year: number
  season?: number
  success?: boolean
  thumbnail_url?: string
  title: string
  updated_at?: string
}

export interface SeriesUpdateData {
  id: string
}

export interface SeriesRemoveMatch {
  id: string
}

