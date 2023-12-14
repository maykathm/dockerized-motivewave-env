# Dockerized Motive Wave Environment

Dockerized development environment for developing Motive Wave studies in development containers with VS Code

## Environment Purpose

This repo is for anyone who doesn't wish to install Motive Wave development dependencies on their native system and yet develop as if on their native system using VS Code and its dev containers.

> Note: to develop Motive Wave studies as if on the native system, one must add in some opportune volume maps. I go over that under the environment creation instructions.

Motive Wave suggests using Eclipse for development using their SDK (https://www.motivewave.com/support/sdk.htm), but personally I'm not a huge fan of Ecilpse and prefer to use VS Code. Also I like to keep all my development enviornments separate. I don't want to install Java 20 on my native system. This repo's purpose is to share the joy.

## The Dockerfile will create a Docker image with the following:

- **Java 20**: The current version of Java used in Motive Wave
- **ANT**: The build system used in the starter kit recommended by Motive Wave
- **VS Code server**: Normally automatically downloaded and installed during dev container startup. By pre-installing, one can develop Motive Wave studies using dev containers without an Internet connection and does not have to wait for those few seconds at every startup for the server to be installed.

## Enviornment Creation Instructions

### Step 1 - Motive Wave Starter Kit
Download the starter kit from Motive Wave found on their SDK support page: [MotiveWave_Studies.zip](https://www.motivewave.com/sdk/MotiveWave_Studies.zip) and extract it to whatever directory you want to develop in.

### Step 2 - Install Docker
One can do so in different ways. Probably the easiest is to install [Docker Desktop](https://www.docker.com/products/docker-desktop/)

### Step 3 - Build Docker Image

To build a container, open a command prompt in this directory folder (or if you're already in VS Code, just hit ctrl+j or command+j to toggle open the terminal).

The command to build an image is ```docker build -t <name you wish to call your image> -f /path/to/Dockerfile .```

So if you decide to call your image "motive", and your console is currently positioned inside this repo directory, you would run the commnad ```docker build -t motive -f Dockerfile .``` in your terminal:

#### It would look something like this on a Mac:
```zsh
user@user-MBP dockerized-motivewave-env % docker build -t motive -f Dockerfile .
```

#### It would look something like this on Windows:
```cmd
C:\Users\User\source\dockerized-motivewave-env> docker build -t motive -f Dockerfile .
```

#### It would look something like this on Linux:
```bash
user@machine[/home/user/source/dockerized-motivewave-env]$ docker build -t motive -f Dockerfile .
```

### Step 4 - Build Docker container

If you've never used Docker before, this step basically creates a super lightweight virtual machine without a graphic user interface. It's actually definitely not a VM, but if you don't want to read up on the difference, it doesn't really matter for the purposes of this repo.

The commands to familiarize oneself with are 
- ```docker create``` - creates a container from an image and only needs to be run once
- ```docker start``` - starts an already-created container

> Note: The command ```docker run``` combines the two

One should add in some volume mappings to ensure a seamless development experience. There are two directories to map into the container:

- The development directory (the directory of the unzipped "MotiveWave_Studies.zip downloaded from Motive Wave's websight)
- The ```MotiveWave Extensions``` directory found under the home folder (assuming the username is "user": ```/Users/user/MotiveWave Extensions``` on a Mac, ```C:\Users\user\MotiveWave Extensions``` on Windows, and ```/home/user/MotiveWave Extensions``` on Linux) to the container home folder

#### Windows folders example

For instance, if I am on Windows, my username is "booya," and I unzipped the "MotiveWave_Studies.zip" folder into my source folder (called "source" that I have in my home directory), then my mappings would be the following:

|Native System Folder|Container Folder|
|-|-|
|C:\Users\booya\source\MotiveWave Studies|/opt/MotiveWave Studies|
|C:\Users\booya\MotiveWave Extensions|/root/MotiveWave Extensions|


#### Mac folders example

If, instead, I'm on a Mac, my username is "trader", and I unzipped the "MotiveWave_Studies.zip" folder into my source folder (called "source" that I have in my home directory), then my mappings would be the following:

|Native System Folder|Container Folder|
|-|-|
|/Users/trader/source/MotiveWave Studies|/opt/MotiveWave Studies|
|/Users/trader/MotiveWave Extensions|/root/MotiveWave Extensions|

#### Container create command

If I wish to create my container with the name "motive-env", my command would therefore be:

Windows:

```console
docker create --name motive-env -v "C:\Users\booya\source\MotiveWave Studies":/opt/MotiveWave Studies -v "C:\Users\booya\MotiveWave Extensions":"/root/MotiveWave Extensions" -it motive
```

Mac:

```console
docker create --name motive-env -v "/Users/trader/source/MotiveWave Studies":/opt/MotiveWave Studies -v "/Users/trader/MotiveWave Extensions":"/root/MotiveWave Extensions" -it motive
```

## Usage Instructions

Once the enviornment is created, everyday development is simple.

### Step 1 - Start the container

You can either do so from Docker Desktop's GUI by going to the "Containers" tab and pressing the "play" button next to the container name. Alternatively, you can run the following from the command line:

```console
docker start motive-env
``` 

### Step 2 - Open MotiveWave Studies in VS Code dev containers

In the bottom lefthand side of VS Code, there is a blue icon with ```><``` symbols. If you click on it, assuming you have the dev containers extension installed, you should see the option "Attach to Running Container." If you click it and select the "motive-env" enviornment, then it will open a new VS Code window inside the "motive-env" container. At that point, open up the folder found at ```/opt/MotiveWave Studies```. Now you can develop just as if you were on your native system. 

>If you want intellisense, you should install the Java extension pack inside the container as VS Code will suggest once you open up a Java source file. 

Because we mapped the ```MotiveWave Studies``` folder from your native system to the container enviornment, any changes you make in the ```MotiveWave Studies``` folder inside the container will be reflected in the native system and vice versa.

### Step 3 - Build and deploy

Open up a terminal (ctrl+j or command+j) and move to the build folder (```cd /opt/MotiveWave\ Studies/build```) and run the command ```ant```

Because we mapped the ```MotiveWave Extensions``` folder from the container to your native system home directory ```MotiveWave Extensions``` folder, you should see the deployment on your native system and see the changes reflected in your MotiveWave installed on your native system.
