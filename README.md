# docker-proftpd
Minimal Docker Image that can be used to run [ProFTPD](http://www.proftpd.org/) in FTP and/or FTPS mode. **Note** that this image is **absolutely** only intended for testing purposes.

## Clone the Repository

```bash
git clone https://github.com/rhoepner/docker-proftpd.git
```

## Building the Image on your own

```bash
docker build -t rhoepner/proftpd
```
Or use whatever repository name / image name you like.

## Pull the image from Docker Hub

```bash
docker pull rhoepner/proftpd
```

## Run the image using docker compose

Due to the ports needed to be open the shortest way to run the image is using docker compose:

```bash
docker-compose up
```
(To be continued soon...)


