Files which may be used to build a Centos docker image containing the package set found in a
published (H)CALDP pipeline environment.

#### Example use:

```
$ ./build [TAG] [Pipeline_snapshot_URL]
```
Where:
* `TAG` is the image tag to be appended to astroconda/buildsys-pipeline:
* `Pipeline_snapshot_URL` is the URL where a published (H)CALDP delivery snapshot YAML file may be found. i.e. https://ssb.stsci.edu/astroconda-releases/caldp/[date or codename]/latest-linux.yml

```
$ ./build CALDP-20200421 https://ssb.stsci.edu/astroconda-releases/caldp/20200421/latest-linux.yml
```
for the 20200421 final delivery iteration.

In-progress and finalized pipeline delivery snapshot definitions may be found here https://github.com/astroconda/astroconda-releases/tree/master/caldp 
