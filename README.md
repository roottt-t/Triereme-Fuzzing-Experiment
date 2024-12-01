This is a replication experiment setup instruction of the Triereme Fuzzing Tool. 

[Reference Triereme Fuzzing Benchmark](https://github.com/vusec/fuzzbench-triereme)

## System 
```
AWS Ubuntu 22.04
```

## Download the Package
```
git clone  https://github.com/roottt-t/Triereme-Fuzzing.git
git clone https://github.com/vusec/triereme.git
```
## Install

```
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt install python3.10 python3.10-dev python3.10-venv libpq-dev
apt install google.cloud.loggin
sudo apt install google.cloud.loggin
pip install google-cloud-logging
sudo apt install python3-pip
pip install google-cloud-logging
pip install google-cloud
pip install google-cloud-error-reporting
sudo apt install -y docker.io
sudo pip install google.cloud.logging
pip install google.cloud.logging
sudo pip install google-cloud-error-reporting
pip3 install -r requirements.txt
sudo apt install sqlite3
sudo apt install build-essential cmake libssl-dev libffi-dev zlib1g-dev python3-dev
sudo apt-get install --reinstall libffi-dev libssl-dev
```

## Docker
Initialize the docker environment first
```
sudo usermod -aG docker $USER
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
docker run -it ubuntu bash
sudo chown root:docker /var/run/docker.sock
sudo chmod 660 /var/run/docker.sock
```
## Clean data
To clean the past experiment data, we can run 
```
docker system prune -af
docker volume prune -a
```
## Make the folder
```
mkdir experiment-data
mkdir report-data
```
## Set Benchmark
```
benchmark_list=("woff2_convert_woff2ttf_fuzzer")
```
## Run Experiment
To run the experiment, under the folder Triereme-Fuzzing, run the following commands
```
PYTHONPATH=. python3 experiment/run_experiment.py \
  --experiment-config experiemnt-config.yaml \
  --concurrent-builds 1 \
  --runners-cpus 2 \
  --measurers-cpus 2 \
  --experiment-name ${experiment_name} \
  --fuzzers \
      aflplusplus_cmplog_forkmode \
      symcc_libafl_single \
      triereme_linear_single \
      triereme_trie_single \
  --benchmarks ${benchmark_list[@]}
  --allow_uncommitted_changes true  
```

## Extract the results
To extract the result of the experiment, run the following commands
```
# AFL++, Symcc Fuzzers
python3 triereme/fuzzbench/extract_symcc_libafl_stats.py \
  ${experiment_filestore} ${experiment_name} ${output_dir}

# Trim linear, Trim single Fuzzers
python3 triereme/fuzzbench/extract_trace_stats.py \
  ${experiment_filestore} ${experiment_name} ${output_dir}
```
