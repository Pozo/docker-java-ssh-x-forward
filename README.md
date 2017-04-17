# docker-java-ssh-x-forward
##What is it?
This repository shows how to set up your environment for using a dockerized java swing application via SSH

##Usage

####build the application and the docker image
Run and check the application

    ./gradlew run

Create the fat jar and check it 

    ./gradlew jar
    java -jar build/libs/swing-app-1.0-SNAPSHOT.jar

Build the image from the Dockerfile
    
    docker build -t pozo/swing-app .

Run the container locally first

    docker run \
    -ti \ 
    --rm \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    pozo/swing-app:latest

######A few failed attempts and results

    docker run -ti --rm pozo/swing-app:latest 

####

    Exception in thread "AWT-EventQueue-0" java.awt.HeadlessException:
    No X11 DISPLAY variable was set, but this program performed an operation which requires it.

####  

    docker run \
    -ti \
    --rm \
    -e DISPLAY=$DISPLAY \
    pozo/swing-app:latest

####

    Exception in thread "main" java.awt.AWTError: Can't connect to X11 window server using ':0' as the value of the DISPLAY variable.

####Setup ssh on the server side in order to allow X forwarding

Change ssh config

    sudo vim /etc/ssh/ssh_config

Uncomment or add the following few lines

    ForwardAgent yes
    ForwardX11 yes
    ForwardX11Trusted yes

Change sshd config
    
    sudo vim /etc/ssh/sshd_config

Uncomment or add the following few lines

    X11Forwarding yes
    X11UseLocalhost no

Restart ssh and sshd

    service ssh restart
    service sshd restart

Don'ts

    xhost +



####Setup client side for running the application

## linux

Connect to the server

    ssh -X user@host
    
Run the container

    docker run \
    -ti \ 
    --rm \
    --net=host
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v "$HOME/.Xauthority:/root/.Xauthority:rw"
    pozo/swing-app:latest
    
## windows

git bash ssh is not working

The working combo is [xming](https://sourceforge.net/projects/xming/) and [putty](http://www.putty.org/)

    putty.exe -ssh -X user@host -m command.txt -t
    
command.txt content

    docker run \
    -ti \ 
    --rm \
    --net=host
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v "$HOME/.Xauthority:/root/.Xauthority:rw"
    pozo/swing-app:latest
    
## Banana for scale

![alt text](http://cdn0.dailydot.com/cache/f9/50/f950e4c4ffb624d260ec08f30d7266bd.jpg "Logo Title Text 1")
## Licensing

Please see the file called LICENSE.

## Contact

  Zoltan Polgar - pozo@gmx.com
  
  Please do not hesitate to contact me if you have any further questions. 