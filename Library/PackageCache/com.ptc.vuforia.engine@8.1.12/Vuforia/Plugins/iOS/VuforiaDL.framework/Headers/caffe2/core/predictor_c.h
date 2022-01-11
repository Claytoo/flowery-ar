/*===============================================================================
Copyright (c) 2018-2019 PTC Inc. All Rights Reserved.

Confidential and Proprietary - Protected under copyright and other laws.
Vuforia is a trademark of PTC Inc., registered in the United States and other
countries.
===============================================================================*/

#pragma once

#include <stddef.h>

#if _MSC_VER && defined(CAFFE2_C_EXPORTS)
#define CAFFE2_C_API __declspec(dllexport)
#else
#define CAFFE2_C_API
#endif

#ifdef __APPLE__
#define CAFFE2_IMPORT __attribute__((weak_import))
#else
#define CAFFE2_IMPORT
#endif
extern "C" {
    CAFFE2_C_API void*        caffe2_create_predictor() CAFFE2_IMPORT;
    CAFFE2_C_API void         caffe2_destroy_predictor(void const* pred) CAFFE2_IMPORT;
    CAFFE2_C_API bool         caffe2_set_init_net(void* pred, void* data, size_t size_bytes) CAFFE2_IMPORT;
    CAFFE2_C_API bool         caffe2_set_predict_net(void* pred, void* data, size_t size_bytes) CAFFE2_IMPORT;
    CAFFE2_C_API bool         caffe2_init_predictor(void* pred) CAFFE2_IMPORT;
    CAFFE2_C_API bool         caffe2_init_from_tflite(void* pred, void* data, size_t size_bytes) CAFFE2_IMPORT;
    CAFFE2_C_API bool         caffe2_do_prediction(void* pred, float const* data, size_t num_channels, size_t num_rows, size_t num_cols) CAFFE2_IMPORT;
    CAFFE2_C_API float const* caffe2_get_last_prediction_result(void* pred) CAFFE2_IMPORT;
    CAFFE2_C_API size_t       caffe2_get_last_prediction_result_size(void* pred) CAFFE2_IMPORT;
    CAFFE2_C_API size_t       caffe2_get_last_prediction_num_results(void* pred) CAFFE2_IMPORT;
    CAFFE2_C_API float const* caffe2_get_last_prediction_result_by_index(void* pred, size_t index) CAFFE2_IMPORT;
    CAFFE2_C_API size_t       caffe2_get_last_prediction_result_size_by_index(void* pred, size_t index) CAFFE2_IMPORT;
}
