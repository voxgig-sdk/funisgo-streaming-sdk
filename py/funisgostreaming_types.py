# Typed models for the FunisgoStreaming SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Field/param types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Do not edit by hand.
#
# These are TypedDicts, not dataclasses: the SDK ops return/accept plain dicts
# at runtime, and a TypedDict IS a dict shape, so the types match the runtime.
# Optional (req:false) keys are modelled as TypedDict key-optionality
# (total=False), split into a required base + total=False subclass when a type
# has both required and optional keys.

from __future__ import annotations

from typing import TypedDict, Any


class ChannelRequired(TypedDict):
    category: str
    description: str
    name: str


class Channel(ChannelRequired, total=False):
    created_at: str
    data: dict
    id: str
    is_live: bool
    is_premium: bool
    language: str
    logo_url: str
    stream_url: str
    success: bool
    updated_at: str


class ChannelLoadMatch(TypedDict):
    id: str


class ChannelListMatch(TypedDict, total=False):
    category: str
    created_at: str
    data: dict
    description: str
    id: str
    is_live: bool
    is_premium: bool
    language: str
    logo_url: str
    name: str
    stream_url: str
    success: bool
    updated_at: str


class ChannelCreateDataRequired(TypedDict):
    category: str
    description: str
    name: str


class ChannelCreateData(ChannelCreateDataRequired, total=False):
    created_at: str
    data: dict
    id: str
    is_live: bool
    is_premium: bool
    language: str
    logo_url: str
    stream_url: str
    success: bool
    updated_at: str


class ChannelUpdateData(TypedDict):
    id: str


class ChannelRemoveMatch(TypedDict):
    id: str


class MovieRequired(TypedDict):
    description: str
    duration: int
    genre: list
    release_year: int
    title: str


class Movie(MovieRequired, total=False):
    created_at: str
    data: dict
    id: str
    is_premium: bool
    rating: float
    stream_url: str
    success: bool
    thumbnail_url: str
    updated_at: str


class MovieLoadMatch(TypedDict):
    id: str


class MovieListMatch(TypedDict, total=False):
    created_at: str
    data: dict
    description: str
    duration: int
    genre: list
    id: str
    is_premium: bool
    rating: float
    release_year: int
    stream_url: str
    success: bool
    thumbnail_url: str
    title: str
    updated_at: str


class MovieCreateDataRequired(TypedDict):
    description: str
    duration: int
    genre: list
    release_year: int
    title: str


class MovieCreateData(MovieCreateDataRequired, total=False):
    created_at: str
    data: dict
    id: str
    is_premium: bool
    rating: float
    stream_url: str
    success: bool
    thumbnail_url: str
    updated_at: str


class MovieUpdateData(TypedDict):
    id: str


class MovieRemoveMatch(TypedDict):
    id: str


class SeriesRequired(TypedDict):
    description: str
    genre: list
    release_year: int
    title: str


class Series(SeriesRequired, total=False):
    created_at: str
    data: dict
    episode: int
    id: str
    is_premium: bool
    rating: float
    season: int
    success: bool
    thumbnail_url: str
    updated_at: str


class SeriesLoadMatch(TypedDict):
    id: str


class SeriesListMatch(TypedDict, total=False):
    created_at: str
    data: dict
    description: str
    episode: int
    genre: list
    id: str
    is_premium: bool
    rating: float
    release_year: int
    season: int
    success: bool
    thumbnail_url: str
    title: str
    updated_at: str


class SeriesCreateDataRequired(TypedDict):
    description: str
    genre: list
    release_year: int
    title: str


class SeriesCreateData(SeriesCreateDataRequired, total=False):
    created_at: str
    data: dict
    episode: int
    id: str
    is_premium: bool
    rating: float
    season: int
    success: bool
    thumbnail_url: str
    updated_at: str


class SeriesUpdateData(TypedDict):
    id: str


class SeriesRemoveMatch(TypedDict):
    id: str
