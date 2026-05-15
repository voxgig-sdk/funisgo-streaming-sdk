<?php
declare(strict_types=1);

// FunisgoStreaming SDK utility registration

require_once __DIR__ . '/../core/UtilityType.php';
require_once __DIR__ . '/Clean.php';
require_once __DIR__ . '/Done.php';
require_once __DIR__ . '/MakeError.php';
require_once __DIR__ . '/FeatureAdd.php';
require_once __DIR__ . '/FeatureHook.php';
require_once __DIR__ . '/FeatureInit.php';
require_once __DIR__ . '/Fetcher.php';
require_once __DIR__ . '/MakeFetchDef.php';
require_once __DIR__ . '/MakeContext.php';
require_once __DIR__ . '/MakeOptions.php';
require_once __DIR__ . '/MakeRequest.php';
require_once __DIR__ . '/MakeResponse.php';
require_once __DIR__ . '/MakeResult.php';
require_once __DIR__ . '/MakePoint.php';
require_once __DIR__ . '/MakeSpec.php';
require_once __DIR__ . '/MakeUrl.php';
require_once __DIR__ . '/Param.php';
require_once __DIR__ . '/PrepareAuth.php';
require_once __DIR__ . '/PrepareBody.php';
require_once __DIR__ . '/PrepareHeaders.php';
require_once __DIR__ . '/PrepareMethod.php';
require_once __DIR__ . '/PrepareParams.php';
require_once __DIR__ . '/PreparePath.php';
require_once __DIR__ . '/PrepareQuery.php';
require_once __DIR__ . '/ResultBasic.php';
require_once __DIR__ . '/ResultBody.php';
require_once __DIR__ . '/ResultHeaders.php';
require_once __DIR__ . '/TransformRequest.php';
require_once __DIR__ . '/TransformResponse.php';

FunisgoStreamingUtility::setRegistrar(function (FunisgoStreamingUtility $u): void {
    $u->clean = [FunisgoStreamingClean::class, 'call'];
    $u->done = [FunisgoStreamingDone::class, 'call'];
    $u->make_error = [FunisgoStreamingMakeError::class, 'call'];
    $u->feature_add = [FunisgoStreamingFeatureAdd::class, 'call'];
    $u->feature_hook = [FunisgoStreamingFeatureHook::class, 'call'];
    $u->feature_init = [FunisgoStreamingFeatureInit::class, 'call'];
    $u->fetcher = [FunisgoStreamingFetcher::class, 'call'];
    $u->make_fetch_def = [FunisgoStreamingMakeFetchDef::class, 'call'];
    $u->make_context = [FunisgoStreamingMakeContext::class, 'call'];
    $u->make_options = [FunisgoStreamingMakeOptions::class, 'call'];
    $u->make_request = [FunisgoStreamingMakeRequest::class, 'call'];
    $u->make_response = [FunisgoStreamingMakeResponse::class, 'call'];
    $u->make_result = [FunisgoStreamingMakeResult::class, 'call'];
    $u->make_point = [FunisgoStreamingMakePoint::class, 'call'];
    $u->make_spec = [FunisgoStreamingMakeSpec::class, 'call'];
    $u->make_url = [FunisgoStreamingMakeUrl::class, 'call'];
    $u->param = [FunisgoStreamingParam::class, 'call'];
    $u->prepare_auth = [FunisgoStreamingPrepareAuth::class, 'call'];
    $u->prepare_body = [FunisgoStreamingPrepareBody::class, 'call'];
    $u->prepare_headers = [FunisgoStreamingPrepareHeaders::class, 'call'];
    $u->prepare_method = [FunisgoStreamingPrepareMethod::class, 'call'];
    $u->prepare_params = [FunisgoStreamingPrepareParams::class, 'call'];
    $u->prepare_path = [FunisgoStreamingPreparePath::class, 'call'];
    $u->prepare_query = [FunisgoStreamingPrepareQuery::class, 'call'];
    $u->result_basic = [FunisgoStreamingResultBasic::class, 'call'];
    $u->result_body = [FunisgoStreamingResultBody::class, 'call'];
    $u->result_headers = [FunisgoStreamingResultHeaders::class, 'call'];
    $u->transform_request = [FunisgoStreamingTransformRequest::class, 'call'];
    $u->transform_response = [FunisgoStreamingTransformResponse::class, 'call'];
});
