<?php
declare(strict_types=1);

// FunisgoStreaming SDK utility: make_context

require_once __DIR__ . '/../core/Context.php';

class FunisgoStreamingMakeContext
{
    public static function call(array $ctxmap, ?FunisgoStreamingContext $basectx): FunisgoStreamingContext
    {
        return new FunisgoStreamingContext($ctxmap, $basectx);
    }
}
