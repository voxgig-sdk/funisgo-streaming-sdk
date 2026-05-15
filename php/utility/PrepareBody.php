<?php
declare(strict_types=1);

// FunisgoStreaming SDK utility: prepare_body

class FunisgoStreamingPrepareBody
{
    public static function call(FunisgoStreamingContext $ctx): mixed
    {
        if ($ctx->op->input === 'data') {
            return ($ctx->utility->transform_request)($ctx);
        }
        return null;
    }
}
