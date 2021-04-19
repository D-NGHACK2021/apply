# How To Start the quill Service

To start the quill service, you will need two containers, one that runs MongoDB and one that runs quill.

The instruction below will guide you to run the containers manually through commandline. Alternatively, you can do so with `docker-compose` (recommended).

### Create a User-Defined Network

Note that as `--link` flag has been deprecated, you should use a user-defined network to connect the two containers

```bash
docker network create quill-network
```

### Start MongoDB Container

If you want to store the database in a local directory, replace the path in command with absolute path to the directory you want.

Alternatively, if you want to use a named volume, replace it with name of the volume.

For details, you can refer to the "Where to Store Data" Section in [Official Documentation](https://hub.docker.com/_/mongo)

```bash
docker pull mongo:latest
docker run -d \
    --network quill-network --network-alias quill-db \
    -v <replace with local directory path or volume name>:/data/db \
    --name quill-db \
    mongo:latest
```

## Build and Start Quill Container

We are going to build a docker image from current directory and label it as `quill:1.0`.

Do not forget to edit `.env` prior to building and put into the necessary environmental variables. The mongodb URI should be something like `mongodb://quill-db:27017`

```bash
cd <path to current directory>
docker build --tag=quill:1.0 .
```

Then, you should be able to start a container with the image we've just built. We're going to expose port `3000` so you can now access the website now at [`http://localhost:3000`](http://localhost:3000).

```
docker run -it \
    -p 3000:3000 \
    --network quill-network \
    --name quill \
    quill:1.0
```
