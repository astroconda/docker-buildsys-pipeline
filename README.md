Files which may be used to build a Centos docker image containing the package set found in a
published (H)CALDP pipeline environment.

#### Example use:

```
$ ./build [TAG] [Pipeline_snapshot_URL]
```

i.e.
```
$ ./build atodsat_RC1 https://ssb.stsci.edu/astroconda-releases/caldp/atodsat/latest-linux.yml

```

For the RC1 delivery iteration of the not-yet-finalized 'atodsat' calibration environment delivery set.

Where:
* `TAG` is the image tag to be appended to astroconda/buildsys-pipeline:
* `Pipeline_snapshot_URL` is the URL where a published (H)CALDP delivery snapshot YAML file may be found.

In-progress and finalized pipeline delivery snapshot definitions may be found here https://github.com/astroconda/astroconda-releases/tree/master/caldp 

