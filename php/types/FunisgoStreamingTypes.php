<?php
declare(strict_types=1);

// Typed models for the FunisgoStreaming SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.
//
// These are documentation-grade value objects (PHP 8 typed properties),
// registered on the composer classmap autoload. The SDK boundary exchanges
// assoc-arrays; these classes name the shapes for tooling and typed callers.

/** Channel entity data model. */
class Channel
{
    public ?string $category = null;
    public ?string $createdAt = null;
    public ?string $description = null;
    public ?string $id = null;
    public ?bool $isLive = null;
    public ?bool $isPremium = null;
    public ?string $language = null;
    public ?string $logoUrl = null;
    public ?string $name = null;
    public ?string $streamUrl = null;
    public ?string $updatedAt = null;
}

/** Request payload for Channel#load. */
class ChannelLoadMatch
{
    public string $id;
}

/** Request payload for Channel#list. */
class ChannelListMatch
{
    public ?string $category = null;
    public ?string $createdAt = null;
    public ?string $description = null;
    public ?string $id = null;
    public ?bool $isLive = null;
    public ?bool $isPremium = null;
    public ?string $language = null;
    public ?string $logoUrl = null;
    public ?string $name = null;
    public ?string $streamUrl = null;
    public ?string $updatedAt = null;
}

/** Request payload for Channel#create. */
class ChannelCreateData
{
    public ?string $category = null;
    public ?string $createdAt = null;
    public ?string $description = null;
    public ?string $id = null;
    public ?bool $isLive = null;
    public ?bool $isPremium = null;
    public ?string $language = null;
    public ?string $logoUrl = null;
    public ?string $name = null;
    public ?string $streamUrl = null;
    public ?string $updatedAt = null;
}

/** Request payload for Channel#update. */
class ChannelUpdateData
{
    public string $id;
    public ?string $category = null;
    public ?string $createdAt = null;
    public ?string $description = null;
    public ?bool $isLive = null;
    public ?bool $isPremium = null;
    public ?string $language = null;
    public ?string $logoUrl = null;
    public ?string $name = null;
    public ?string $streamUrl = null;
    public ?string $updatedAt = null;
}

/** Request payload for Channel#remove. */
class ChannelRemoveMatch
{
    public string $id;
}

/** Movie entity data model. */
class Movie
{
    public ?string $createdAt = null;
    public ?string $description = null;
    public ?int $duration = null;
    public ?array $genre = null;
    public ?string $id = null;
    public ?bool $isPremium = null;
    public ?float $rating = null;
    public ?int $releaseYear = null;
    public ?string $streamUrl = null;
    public ?string $thumbnailUrl = null;
    public ?string $title = null;
    public ?string $updatedAt = null;
}

/** Request payload for Movie#load. */
class MovieLoadMatch
{
    public string $id;
}

/** Request payload for Movie#list. */
class MovieListMatch
{
    public ?string $createdAt = null;
    public ?string $description = null;
    public ?int $duration = null;
    public ?array $genre = null;
    public ?string $id = null;
    public ?bool $isPremium = null;
    public ?float $rating = null;
    public ?int $releaseYear = null;
    public ?string $streamUrl = null;
    public ?string $thumbnailUrl = null;
    public ?string $title = null;
    public ?string $updatedAt = null;
}

/** Request payload for Movie#create. */
class MovieCreateData
{
    public ?string $createdAt = null;
    public ?string $description = null;
    public ?int $duration = null;
    public ?array $genre = null;
    public ?string $id = null;
    public ?bool $isPremium = null;
    public ?float $rating = null;
    public ?int $releaseYear = null;
    public ?string $streamUrl = null;
    public ?string $thumbnailUrl = null;
    public ?string $title = null;
    public ?string $updatedAt = null;
}

/** Request payload for Movie#update. */
class MovieUpdateData
{
    public string $id;
    public ?string $createdAt = null;
    public ?string $description = null;
    public ?int $duration = null;
    public ?array $genre = null;
    public ?bool $isPremium = null;
    public ?float $rating = null;
    public ?int $releaseYear = null;
    public ?string $streamUrl = null;
    public ?string $thumbnailUrl = null;
    public ?string $title = null;
    public ?string $updatedAt = null;
}

/** Request payload for Movie#remove. */
class MovieRemoveMatch
{
    public string $id;
}

/** Series entity data model. */
class Series
{
    public ?string $createdAt = null;
    public ?string $description = null;
    public ?int $episodes = null;
    public ?array $genre = null;
    public ?string $id = null;
    public ?bool $isPremium = null;
    public ?float $rating = null;
    public ?int $releaseYear = null;
    public ?int $seasons = null;
    public ?string $thumbnailUrl = null;
    public ?string $title = null;
    public ?string $updatedAt = null;
}

/** Request payload for Series#load. */
class SeriesLoadMatch
{
    public string $id;
}

/** Request payload for Series#list. */
class SeriesListMatch
{
    public ?string $createdAt = null;
    public ?string $description = null;
    public ?int $episodes = null;
    public ?array $genre = null;
    public ?string $id = null;
    public ?bool $isPremium = null;
    public ?float $rating = null;
    public ?int $releaseYear = null;
    public ?int $seasons = null;
    public ?string $thumbnailUrl = null;
    public ?string $title = null;
    public ?string $updatedAt = null;
}

/** Request payload for Series#create. */
class SeriesCreateData
{
    public ?string $createdAt = null;
    public ?string $description = null;
    public ?int $episodes = null;
    public ?array $genre = null;
    public ?string $id = null;
    public ?bool $isPremium = null;
    public ?float $rating = null;
    public ?int $releaseYear = null;
    public ?int $seasons = null;
    public ?string $thumbnailUrl = null;
    public ?string $title = null;
    public ?string $updatedAt = null;
}

/** Request payload for Series#update. */
class SeriesUpdateData
{
    public string $id;
    public ?string $createdAt = null;
    public ?string $description = null;
    public ?int $episodes = null;
    public ?array $genre = null;
    public ?bool $isPremium = null;
    public ?float $rating = null;
    public ?int $releaseYear = null;
    public ?int $seasons = null;
    public ?string $thumbnailUrl = null;
    public ?string $title = null;
    public ?string $updatedAt = null;
}

/** Request payload for Series#remove. */
class SeriesRemoveMatch
{
    public string $id;
}

