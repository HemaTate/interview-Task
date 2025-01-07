#all commands what i run in part 1
  
1--> installing docker and docker compose and start service
    2  yum update -y
    3  yum install docker -y
    4  docker --version
    5  systemctl start docker.s 
    6  systemctl start docker
    7  systemctl enable docker 
    8   curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    9   chmod +x /usr/local/bin/docker-compose
   10  docker-compose --version

2------>then i pull the images as instruction
   11  docker pull infracloudio/csvserver:latest
   12  docker pull prom/prometheus:v2.45.2
   13  docker images

3------> then i have run or create the container
   14  docker run -d --name csvserver  infracloudio/csvserver
   15  docker ps
   16  docker ps -a
4------> i have found error my container is not runned bacuse i dont have inputFile 
   17  docker logs csvserver #checking logs to find error
5------>cloned the repository as per instruction
   18  yum install git -y
   19  git clone https://github.com/infracloudio/csvserver.git
6-------> checked the directory or files are clomed or not
   20  ls
   21  cd csvserver/
   22  ls
   23  cd solution/
   24  ls
   25  cd ..
7----->completed task to create a sh file to create file which is "inputFile"
   26  vim gencsv.sh
   27  ls
   28  ./gencsv.sh
   29  chmod +x gencsv.sh 
   30  ls
   31  ./gencsv.sh
   32  ./gencsv.sh 2 8
   33  ls
8------> bu using shellfile here is automatically created inputFile 
   34  cat inputFile 
   
9------> then i have created once agian container with mounting the file correctly
   55  docker run -d --name csvserver -v "$(pwd)/inputFile:/csvserver/inputdata" infracloudio/csvserver:latest
   56  docker ps
   57  docker exec -it csvserver /bin/bash

10-----> To Find the listening port Inside the container, run:
       netstat -tuln | grep LISTEN then i got port which is assigned to the container 9393
   62  docker ps
   58  docker rm 6f
   59  docker stop 6f
   60  docker rm 6f
11----> created the container where i use port 9393

   61  docker run -d --name csvserver -v "$(pwd)/inputFile:/csvserver/inputdata" -p 9393:9300 -e CSVSERVER_BORDER=Orange infracloudio/csvserver:latest

   62  docker ps
   63  curl http://localhost:9393
12---->THEN I GOT OUTPUT WHICH IS The application should be accessible at http://localhost:9393, it should have the 7 entries from inputFile and the welcome note should have an orange color border.

