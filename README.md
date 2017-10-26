# sntest
quick snakemake tests

## Log-file failure when using cluster-status script

I encountered this bug when running a workflow on a test dataset. 
(The exact workflow and test data can be found 
[here](https://github.com/biocore/oecophylla/tree/dev)). 

When running conventionally---i.e., without providing the 
`--cluster-status` parameter---the workflow performs as expected.
However, when providing the `--cluster-status` script for job 
monitoring, the Snakemake process dies whenever a job finishes 
with a log output path that depends on a folder that has not yet 
been created. 

Snakemake fails with the following message:

```bash
barnacle:sntest $ bash barnacle/barnacle_unfail.sh 
Provided cluster nodes: 1
Job counts:
	count	jobs
	1	test
	1

rule test:
    output: results/foo.txt
    log: results/logs/test.log
    jobid: 0
    threads: 2

Submitted job 0 with external jobid '529505.barnacle.ucsd.edu'.
Exception in thread Thread-1:
Traceback (most recent call last):
  File "/home/jgsanders/miniconda/envs/oecophylla/lib/python3.5/site-packages/snakemake/io.py", line 308, in touch
    lutime(self.file, times)
  File "/home/jgsanders/miniconda/envs/oecophylla/lib/python3.5/site-packages/snakemake/io.py", line 41, in lutime
    os.utime(f, times)
FileNotFoundError: [Errno 2] No such file or directory

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/home/jgsanders/miniconda/envs/oecophylla/lib/python3.5/site-packages/snakemake/io.py", line 321, in touch_or_create
    self.touch()
  File "/home/jgsanders/miniconda/envs/oecophylla/lib/python3.5/site-packages/snakemake/io.py", line 315, in touch
    snakefile=self.rule.snakefile)
snakemake.exceptions.MissingOutputException: Output file results/logs/test.log of rule test shall be touched but does not exist.

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/home/jgsanders/miniconda/envs/oecophylla/lib/python3.5/threading.py", line 923, in _bootstrap_inner
    self.run()
  File "/home/jgsanders/miniconda/envs/oecophylla/lib/python3.5/threading.py", line 871, in run
    self._target(*self._args, **self._kwargs)
  File "/home/jgsanders/miniconda/envs/oecophylla/lib/python3.5/site-packages/snakemake/executors.py", line 759, in _wait_for_jobs
    active_job.callback(active_job.job)
  File "/home/jgsanders/miniconda/envs/oecophylla/lib/python3.5/site-packages/snakemake/scheduler.py", line 317, in _proceed
    self.get_executor(job).handle_job_success(job)
  File "/home/jgsanders/miniconda/envs/oecophylla/lib/python3.5/site-packages/snakemake/executors.py", line 583, in handle_job_success
    super().handle_job_success(job, upload_remote=False)
  File "/home/jgsanders/miniconda/envs/oecophylla/lib/python3.5/site-packages/snakemake/executors.py", line 183, in handle_job_success
    self.dag.handle_log(job)
  File "/home/jgsanders/miniconda/envs/oecophylla/lib/python3.5/site-packages/snakemake/dag.py", line 464, in handle_log
    f.touch_or_create()
  File "/home/jgsanders/miniconda/envs/oecophylla/lib/python3.5/site-packages/snakemake/io.py", line 324, in touch_or_create
    with open(self.file, "w") as f:
FileNotFoundError: [Errno 2] No such file or directory: 'results/logs/test.log'
```

I have tried to reproduce this error using a feux cluster submit on 
a local machine, but that does not actually reproduce the error.

The minimal example in the `barnacle` folder does fail, however,
when used on our Torque cluster.


