#!/bin/bash
# This is an shell script to run the experiment
export experiment_name=test-run-linear-4
export config_file=experiment-config.yaml 
export benchmark_list=("freetype2_ftfuzzer" "libjpeg-turbo_libjpeg_turbo_fuzzer" "libpng_libpng_read_fuzzer" "libxml2_xml")
# done: curl_curl_fuzzer_http,
# benchmark_list=("curl_curl_fuzzer_http" "freetype2_ftfuzzer" "libpng_libpng_read_fuzzer" "libxml2_xml" "openssl_x509" "openthread_ot-ip6-send-fuzzer" "proj4_proj_crs_to_crs_fuzzer" "re2_fuzzer" "woff2_convert_woff2ttf_fuzzer" "zlib_zlib_uncompress_fuzzer")

sudo PYTHONPATH=. python3 experiment/run_experiment.py \
  --allow_uncommitted_changes true \
  --experiment-config ${config_file} \
  --concurrent-builds 1 \
  --runners-cpus 2 \
  --measurers-cpus 2 \
  --experiment-name ${experiment_name} \
  --fuzzers \
      triereme_trie_single\
  --benchmarks ${benchmark_list[@]}
