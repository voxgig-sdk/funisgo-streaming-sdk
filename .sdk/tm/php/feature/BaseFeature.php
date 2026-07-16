<?php
declare(strict_types=1);

// FunisgoStreaming SDK base feature

class FunisgoStreamingBaseFeature
{
    public string $version;
    public string $name;
    public bool $active;

    // Positions this feature when added via the client `extend` option:
    // "__before__" / "__after__" / "__replace__" name an already-added
    // feature (mirrors the ts feature `_options`). Declared so setting it
    // on an extension instance avoids the dynamic-property deprecation.
    public ?array $_options = null;

    public function __construct()
    {
        $this->version = '0.0.1';
        $this->name = 'base';
        $this->active = true;
    }

    public function get_version(): string { return $this->version; }
    public function get_name(): string { return $this->name; }
    public function get_active(): bool { return $this->active; }

    public function init(FunisgoStreamingContext $ctx, array $options): void {}
    public function PostConstruct(FunisgoStreamingContext $ctx): void {}
    public function PostConstructEntity(FunisgoStreamingContext $ctx): void {}
    public function SetData(FunisgoStreamingContext $ctx): void {}
    public function GetData(FunisgoStreamingContext $ctx): void {}
    public function GetMatch(FunisgoStreamingContext $ctx): void {}
    public function SetMatch(FunisgoStreamingContext $ctx): void {}
    public function PrePoint(FunisgoStreamingContext $ctx): void {}
    public function PreSpec(FunisgoStreamingContext $ctx): void {}
    public function PreRequest(FunisgoStreamingContext $ctx): void {}
    public function PreResponse(FunisgoStreamingContext $ctx): void {}
    public function PreResult(FunisgoStreamingContext $ctx): void {}
    public function PreDone(FunisgoStreamingContext $ctx): void {}
    public function PreUnexpected(FunisgoStreamingContext $ctx): void {}
}
