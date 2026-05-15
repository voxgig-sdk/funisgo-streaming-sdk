<?php
declare(strict_types=1);

// FunisgoStreaming SDK utility: result_body

class FunisgoStreamingResultBody
{
    public static function call(FunisgoStreamingContext $ctx): ?FunisgoStreamingResult
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result && $response && $response->json_func && $response->body) {
            $result->body = ($response->json_func)();
        }
        return $result;
    }
}
