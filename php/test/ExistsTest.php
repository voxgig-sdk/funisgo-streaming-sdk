<?php
declare(strict_types=1);

// FunisgoStreaming SDK exists test

require_once __DIR__ . '/../funisgostreaming_sdk.php';

use PHPUnit\Framework\TestCase;

class ExistsTest extends TestCase
{
    public function test_create_test_sdk(): void
    {
        $testsdk = FunisgoStreamingSDK::test(null, null);
        $this->assertNotNull($testsdk);
    }
}
