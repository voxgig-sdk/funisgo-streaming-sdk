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


class Channel(TypedDict, total=False):
    category: str
    createdAt: str
    description: str
    id: str
    isLive: bool
    isPremium: bool
    language: str
    logoUrl: str
    name: str
    streamUrl: str
    updatedAt: str


class ChannelLoadMatch(TypedDict):
    id: str


class ChannelListMatch(TypedDict, total=False):
    category: str
    limit: int
    page: int


class ChannelCreateData(TypedDict, total=False):
    category: str
    createdAt: str
    description: str
    id: str
    isLive: bool
    isPremium: bool
    language: str
    logoUrl: str
    name: str
    streamUrl: str
    updatedAt: str


class ChannelUpdateDataRequired(TypedDict):
    id: str


class ChannelUpdateData(ChannelUpdateDataRequired, total=False):
    category: str
    createdAt: str
    description: str
    isLive: bool
    isPremium: bool
    language: str
    logoUrl: str
    name: str
    streamUrl: str
    updatedAt: str


class ChannelRemoveMatch(TypedDict):
    id: str


class Movie(TypedDict, total=False):
    createdAt: str
    description: str
    duration: int
    genre: list
    id: str
    isPremium: bool
    rating: float
    releaseYear: int
    streamUrl: str
    thumbnailUrl: str
    title: str
    updatedAt: str


class MovieLoadMatch(TypedDict):
    id: str


class MovieListMatch(TypedDict, total=False):
    genre: str
    limit: int
    page: int


class MovieCreateData(TypedDict, total=False):
    createdAt: str
    description: str
    duration: int
    genre: list
    id: str
    isPremium: bool
    rating: float
    releaseYear: int
    streamUrl: str
    thumbnailUrl: str
    title: str
    updatedAt: str


class MovieUpdateDataRequired(TypedDict):
    id: str


class MovieUpdateData(MovieUpdateDataRequired, total=False):
    createdAt: str
    description: str
    duration: int
    genre: list
    isPremium: bool
    rating: float
    releaseYear: int
    streamUrl: str
    thumbnailUrl: str
    title: str
    updatedAt: str


class MovieRemoveMatch(TypedDict):
    id: str


class Series(TypedDict, total=False):
    createdAt: str
    description: str
    episodes: int
    genre: list
    id: str
    isPremium: bool
    rating: float
    releaseYear: int
    seasons: int
    thumbnailUrl: str
    title: str
    updatedAt: str


class SeriesLoadMatch(TypedDict):
    id: str


class SeriesListMatch(TypedDict, total=False):
    genre: str
    limit: int
    page: int


class SeriesCreateData(TypedDict, total=False):
    createdAt: str
    description: str
    episodes: int
    genre: list
    id: str
    isPremium: bool
    rating: float
    releaseYear: int
    seasons: int
    thumbnailUrl: str
    title: str
    updatedAt: str


class SeriesUpdateDataRequired(TypedDict):
    id: str


class SeriesUpdateData(SeriesUpdateDataRequired, total=False):
    createdAt: str
    description: str
    episodes: int
    genre: list
    isPremium: bool
    rating: float
    releaseYear: int
    seasons: int
    thumbnailUrl: str
    title: str
    updatedAt: str


class SeriesRemoveMatch(TypedDict):
    id: str
