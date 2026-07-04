# Typed models for the FunisgoStreaming SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Field/param types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Do not edit by hand.

from __future__ import annotations

from dataclasses import dataclass
from typing import Optional, Any


@dataclass
class Channel:
    category: str
    description: str
    name: str
    created_at: Optional[str] = None
    data: Optional[dict] = None
    id: Optional[str] = None
    is_live: Optional[bool] = None
    is_premium: Optional[bool] = None
    language: Optional[str] = None
    logo_url: Optional[str] = None
    stream_url: Optional[str] = None
    success: Optional[bool] = None
    updated_at: Optional[str] = None


@dataclass
class ChannelLoadMatch:
    id: str


@dataclass
class ChannelListMatch:
    category: Optional[str] = None
    created_at: Optional[str] = None
    data: Optional[dict] = None
    description: Optional[str] = None
    id: Optional[str] = None
    is_live: Optional[bool] = None
    is_premium: Optional[bool] = None
    language: Optional[str] = None
    logo_url: Optional[str] = None
    name: Optional[str] = None
    stream_url: Optional[str] = None
    success: Optional[bool] = None
    updated_at: Optional[str] = None


@dataclass
class ChannelCreateData:
    category: Optional[str] = None
    created_at: Optional[str] = None
    data: Optional[dict] = None
    description: Optional[str] = None
    id: Optional[str] = None
    is_live: Optional[bool] = None
    is_premium: Optional[bool] = None
    language: Optional[str] = None
    logo_url: Optional[str] = None
    name: Optional[str] = None
    stream_url: Optional[str] = None
    success: Optional[bool] = None
    updated_at: Optional[str] = None


@dataclass
class ChannelUpdateData:
    id: str


@dataclass
class ChannelRemoveMatch:
    id: str


@dataclass
class Movie:
    description: str
    duration: int
    genre: list
    release_year: int
    title: str
    created_at: Optional[str] = None
    data: Optional[dict] = None
    id: Optional[str] = None
    is_premium: Optional[bool] = None
    rating: Optional[float] = None
    stream_url: Optional[str] = None
    success: Optional[bool] = None
    thumbnail_url: Optional[str] = None
    updated_at: Optional[str] = None


@dataclass
class MovieLoadMatch:
    id: str


@dataclass
class MovieListMatch:
    created_at: Optional[str] = None
    data: Optional[dict] = None
    description: Optional[str] = None
    duration: Optional[int] = None
    genre: Optional[list] = None
    id: Optional[str] = None
    is_premium: Optional[bool] = None
    rating: Optional[float] = None
    release_year: Optional[int] = None
    stream_url: Optional[str] = None
    success: Optional[bool] = None
    thumbnail_url: Optional[str] = None
    title: Optional[str] = None
    updated_at: Optional[str] = None


@dataclass
class MovieCreateData:
    created_at: Optional[str] = None
    data: Optional[dict] = None
    description: Optional[str] = None
    duration: Optional[int] = None
    genre: Optional[list] = None
    id: Optional[str] = None
    is_premium: Optional[bool] = None
    rating: Optional[float] = None
    release_year: Optional[int] = None
    stream_url: Optional[str] = None
    success: Optional[bool] = None
    thumbnail_url: Optional[str] = None
    title: Optional[str] = None
    updated_at: Optional[str] = None


@dataclass
class MovieUpdateData:
    id: str


@dataclass
class MovieRemoveMatch:
    id: str


@dataclass
class Series:
    description: str
    genre: list
    release_year: int
    title: str
    created_at: Optional[str] = None
    data: Optional[dict] = None
    episode: Optional[int] = None
    id: Optional[str] = None
    is_premium: Optional[bool] = None
    rating: Optional[float] = None
    season: Optional[int] = None
    success: Optional[bool] = None
    thumbnail_url: Optional[str] = None
    updated_at: Optional[str] = None


@dataclass
class SeriesLoadMatch:
    id: str


@dataclass
class SeriesListMatch:
    created_at: Optional[str] = None
    data: Optional[dict] = None
    description: Optional[str] = None
    episode: Optional[int] = None
    genre: Optional[list] = None
    id: Optional[str] = None
    is_premium: Optional[bool] = None
    rating: Optional[float] = None
    release_year: Optional[int] = None
    season: Optional[int] = None
    success: Optional[bool] = None
    thumbnail_url: Optional[str] = None
    title: Optional[str] = None
    updated_at: Optional[str] = None


@dataclass
class SeriesCreateData:
    created_at: Optional[str] = None
    data: Optional[dict] = None
    description: Optional[str] = None
    episode: Optional[int] = None
    genre: Optional[list] = None
    id: Optional[str] = None
    is_premium: Optional[bool] = None
    rating: Optional[float] = None
    release_year: Optional[int] = None
    season: Optional[int] = None
    success: Optional[bool] = None
    thumbnail_url: Optional[str] = None
    title: Optional[str] = None
    updated_at: Optional[str] = None


@dataclass
class SeriesUpdateData:
    id: str


@dataclass
class SeriesRemoveMatch:
    id: str

