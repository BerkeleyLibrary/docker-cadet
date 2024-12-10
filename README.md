# dockerized CADET

this repository allows you to install a Dockerized version of [CADET](https://www.wgbh.org/foundation/services/ncam/cadet) (Caption and Description Editing Tool), developed by the National Center for Accessible Media at WGBH. 

## getting started / installation

* ensure you have Docker installed.
* Run `docker compose up --build`. You will see a message that you have to accept the CADET End User License Agreement (see below).

the installer script does the following:
* it ensures that the EULA has been accepted;
* it checks to see if CADET has been previously installed in the container;
    * if it hasn't, it fetches the CADET release and installs it;
    * if it has, it checks to see if the installed version matches the version to be installed.

it uses the `data` directory (created within this repository) for projects/media files by default, mounted within the container at `/opt/app/data`.

## environment variables / options

### `CADET_ACCEPT_EULA` 

this specifies that you have accepted the [CADET Freeware End User License Agreement](http://ncamftp.wgbh.org/cadet/cadet-eula.html), which you must confirm by setting this to a value that starts with `y` or `Y`. 

to start CADET and indicate you've accepted the license agreement, run:

```bash
CADET_ACCEPT_EULA=y docker compose up
```

### `CADET_VERSION`

this allows you to specify which version of CADET you'd like to install. Versions are listed on the download page linked from the EULA after its acceptance.

to set a different version:

```bash
CADET_VERSION=2.0.044 docker compose up
```

## unfrequently asked questions

**what's the deal with the EULA? / why does it install CADET on startup and not part of the image build process?**

while CADET is freeware, it is not open source. neither this repository, nor images built from this repository, distribute CADET itself. *this is by design.* 