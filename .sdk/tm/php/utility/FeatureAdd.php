<?php
declare(strict_types=1);

// FunisgoStreaming SDK utility: feature_add

class FunisgoStreamingFeatureAdd
{
    public static function call(FunisgoStreamingContext $ctx, mixed $f): void
    {
        $ctx->client->features[] = $f;
    }
}
