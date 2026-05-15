<?php
declare(strict_types=1);

// FunisgoStreaming SDK feature factory

require_once __DIR__ . '/feature/BaseFeature.php';
require_once __DIR__ . '/feature/TestFeature.php';


class FunisgoStreamingFeatures
{
    public static function make_feature(string $name)
    {
        switch ($name) {
            case "base":
                return new FunisgoStreamingBaseFeature();
            case "test":
                return new FunisgoStreamingTestFeature();
            default:
                return new FunisgoStreamingBaseFeature();
        }
    }
}
