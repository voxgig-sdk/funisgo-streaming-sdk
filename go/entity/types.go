// Typed models for the FunisgoStreaming SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.
package entity

import "encoding/json"

// Channel is the typed data model for the channel entity.
type Channel struct {
	Category string `json:"category"`
	CreatedAt *string `json:"created_at,omitempty"`
	Data *map[string]any `json:"data,omitempty"`
	Description string `json:"description"`
	Id *string `json:"id,omitempty"`
	IsLive *bool `json:"is_live,omitempty"`
	IsPremium *bool `json:"is_premium,omitempty"`
	Language *string `json:"language,omitempty"`
	LogoUrl *string `json:"logo_url,omitempty"`
	Name string `json:"name"`
	StreamUrl *string `json:"stream_url,omitempty"`
	Success *bool `json:"success,omitempty"`
	UpdatedAt *string `json:"updated_at,omitempty"`
}

// ChannelLoadMatch is the typed request payload for Channel.LoadTyped.
type ChannelLoadMatch struct {
	Id string `json:"id"`
}

// ChannelListMatch is the typed request payload for Channel.ListTyped.
type ChannelListMatch struct {
	Category *string `json:"category,omitempty"`
	CreatedAt *string `json:"created_at,omitempty"`
	Data *map[string]any `json:"data,omitempty"`
	Description *string `json:"description,omitempty"`
	Id *string `json:"id,omitempty"`
	IsLive *bool `json:"is_live,omitempty"`
	IsPremium *bool `json:"is_premium,omitempty"`
	Language *string `json:"language,omitempty"`
	LogoUrl *string `json:"logo_url,omitempty"`
	Name *string `json:"name,omitempty"`
	StreamUrl *string `json:"stream_url,omitempty"`
	Success *bool `json:"success,omitempty"`
	UpdatedAt *string `json:"updated_at,omitempty"`
}

// ChannelCreateData is the typed request payload for Channel.CreateTyped.
type ChannelCreateData struct {
	Category string `json:"category"`
	CreatedAt *string `json:"created_at,omitempty"`
	Data *map[string]any `json:"data,omitempty"`
	Description string `json:"description"`
	Id *string `json:"id,omitempty"`
	IsLive *bool `json:"is_live,omitempty"`
	IsPremium *bool `json:"is_premium,omitempty"`
	Language *string `json:"language,omitempty"`
	LogoUrl *string `json:"logo_url,omitempty"`
	Name string `json:"name"`
	StreamUrl *string `json:"stream_url,omitempty"`
	Success *bool `json:"success,omitempty"`
	UpdatedAt *string `json:"updated_at,omitempty"`
}

// ChannelUpdateData is the typed request payload for Channel.UpdateTyped.
type ChannelUpdateData struct {
	Id string `json:"id"`
}

// ChannelRemoveMatch is the typed request payload for Channel.RemoveTyped.
type ChannelRemoveMatch struct {
	Id string `json:"id"`
}

// Movie is the typed data model for the movie entity.
type Movie struct {
	CreatedAt *string `json:"created_at,omitempty"`
	Data *map[string]any `json:"data,omitempty"`
	Description string `json:"description"`
	Duration int `json:"duration"`
	Genre []any `json:"genre"`
	Id *string `json:"id,omitempty"`
	IsPremium *bool `json:"is_premium,omitempty"`
	Rating *float64 `json:"rating,omitempty"`
	ReleaseYear int `json:"release_year"`
	StreamUrl *string `json:"stream_url,omitempty"`
	Success *bool `json:"success,omitempty"`
	ThumbnailUrl *string `json:"thumbnail_url,omitempty"`
	Title string `json:"title"`
	UpdatedAt *string `json:"updated_at,omitempty"`
}

// MovieLoadMatch is the typed request payload for Movie.LoadTyped.
type MovieLoadMatch struct {
	Id string `json:"id"`
}

// MovieListMatch is the typed request payload for Movie.ListTyped.
type MovieListMatch struct {
	CreatedAt *string `json:"created_at,omitempty"`
	Data *map[string]any `json:"data,omitempty"`
	Description *string `json:"description,omitempty"`
	Duration *int `json:"duration,omitempty"`
	Genre *[]any `json:"genre,omitempty"`
	Id *string `json:"id,omitempty"`
	IsPremium *bool `json:"is_premium,omitempty"`
	Rating *float64 `json:"rating,omitempty"`
	ReleaseYear *int `json:"release_year,omitempty"`
	StreamUrl *string `json:"stream_url,omitempty"`
	Success *bool `json:"success,omitempty"`
	ThumbnailUrl *string `json:"thumbnail_url,omitempty"`
	Title *string `json:"title,omitempty"`
	UpdatedAt *string `json:"updated_at,omitempty"`
}

// MovieCreateData is the typed request payload for Movie.CreateTyped.
type MovieCreateData struct {
	CreatedAt *string `json:"created_at,omitempty"`
	Data *map[string]any `json:"data,omitempty"`
	Description string `json:"description"`
	Duration int `json:"duration"`
	Genre []any `json:"genre"`
	Id *string `json:"id,omitempty"`
	IsPremium *bool `json:"is_premium,omitempty"`
	Rating *float64 `json:"rating,omitempty"`
	ReleaseYear int `json:"release_year"`
	StreamUrl *string `json:"stream_url,omitempty"`
	Success *bool `json:"success,omitempty"`
	ThumbnailUrl *string `json:"thumbnail_url,omitempty"`
	Title string `json:"title"`
	UpdatedAt *string `json:"updated_at,omitempty"`
}

// MovieUpdateData is the typed request payload for Movie.UpdateTyped.
type MovieUpdateData struct {
	Id string `json:"id"`
}

// MovieRemoveMatch is the typed request payload for Movie.RemoveTyped.
type MovieRemoveMatch struct {
	Id string `json:"id"`
}

// Series is the typed data model for the series entity.
type Series struct {
	CreatedAt *string `json:"created_at,omitempty"`
	Data *map[string]any `json:"data,omitempty"`
	Description string `json:"description"`
	Episode *int `json:"episode,omitempty"`
	Genre []any `json:"genre"`
	Id *string `json:"id,omitempty"`
	IsPremium *bool `json:"is_premium,omitempty"`
	Rating *float64 `json:"rating,omitempty"`
	ReleaseYear int `json:"release_year"`
	Season *int `json:"season,omitempty"`
	Success *bool `json:"success,omitempty"`
	ThumbnailUrl *string `json:"thumbnail_url,omitempty"`
	Title string `json:"title"`
	UpdatedAt *string `json:"updated_at,omitempty"`
}

// SeriesLoadMatch is the typed request payload for Series.LoadTyped.
type SeriesLoadMatch struct {
	Id string `json:"id"`
}

// SeriesListMatch is the typed request payload for Series.ListTyped.
type SeriesListMatch struct {
	CreatedAt *string `json:"created_at,omitempty"`
	Data *map[string]any `json:"data,omitempty"`
	Description *string `json:"description,omitempty"`
	Episode *int `json:"episode,omitempty"`
	Genre *[]any `json:"genre,omitempty"`
	Id *string `json:"id,omitempty"`
	IsPremium *bool `json:"is_premium,omitempty"`
	Rating *float64 `json:"rating,omitempty"`
	ReleaseYear *int `json:"release_year,omitempty"`
	Season *int `json:"season,omitempty"`
	Success *bool `json:"success,omitempty"`
	ThumbnailUrl *string `json:"thumbnail_url,omitempty"`
	Title *string `json:"title,omitempty"`
	UpdatedAt *string `json:"updated_at,omitempty"`
}

// SeriesCreateData is the typed request payload for Series.CreateTyped.
type SeriesCreateData struct {
	CreatedAt *string `json:"created_at,omitempty"`
	Data *map[string]any `json:"data,omitempty"`
	Description string `json:"description"`
	Episode *int `json:"episode,omitempty"`
	Genre []any `json:"genre"`
	Id *string `json:"id,omitempty"`
	IsPremium *bool `json:"is_premium,omitempty"`
	Rating *float64 `json:"rating,omitempty"`
	ReleaseYear int `json:"release_year"`
	Season *int `json:"season,omitempty"`
	Success *bool `json:"success,omitempty"`
	ThumbnailUrl *string `json:"thumbnail_url,omitempty"`
	Title string `json:"title"`
	UpdatedAt *string `json:"updated_at,omitempty"`
}

// SeriesUpdateData is the typed request payload for Series.UpdateTyped.
type SeriesUpdateData struct {
	Id string `json:"id"`
}

// SeriesRemoveMatch is the typed request payload for Series.RemoveTyped.
type SeriesRemoveMatch struct {
	Id string `json:"id"`
}

// asMap turns a typed request/data struct into the map[string]any the
// runtime op pipeline consumes, honouring the json tags above.
func asMap(v any) map[string]any {
	out := map[string]any{}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}

// typedFrom decodes a runtime value (a map[string]any produced by the op
// pipeline) into a typed model T via a JSON round-trip. On any error it
// returns the zero value of T; the op's own (value, error) tuple carries the
// real error.
func typedFrom[T any](v any) T {
	var out T
	if v == nil {
		return out
	}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}

// typedSliceFrom decodes a runtime list value ([]any of maps) into a typed
// slice []T via a JSON round-trip, for list ops.
func typedSliceFrom[T any](v any) []T {
	var out []T
	if v == nil {
		return out
	}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}
