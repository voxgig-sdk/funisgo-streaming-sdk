<?php
declare(strict_types=1);

// FunisgoStreaming SDK utility: result_headers

class FunisgoStreamingResultHeaders
{
    public static function call(FunisgoStreamingContext $ctx): ?FunisgoStreamingResult
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result) {
            if ($response && is_array($response->headers)) {
                $result->headers = $response->headers;
            } else {
                $result->headers = [];
            }
        }
        return $result;
    }
}
