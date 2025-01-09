# The csvserver assignment

The developer team of the csvserver was working hard to get it ready for production. The team decided to go for a trip before the launch, and has been missing since then. You have been given the responsibility to figure out how to get the csvserver running correctly with the help of the following document. You might need to understand why things are failing and try to fix them, and make it ready for a launch<sup>[1](#user-content-ftn1)</sup>.

## Prerequisites
You don't need to know Docker or Prometheus beforehand to solve this assignment, take a look at the following docs and understand the basics about these tools.
  - Read Docker orientation and setup: https://docs.docker.com/get-started/
  - Read Docker build and run your image: https://docs.docker.com/get-started/part2/
  - Read Get started with Docker Compose: https://docs.docker.com/compose/gettingstarted/
  - Read Prometheus getting started: https://prometheus.io/docs/prometheus/latest/getting_started/
  - Read Prometheus installation with Docker: https://prometheus.io/docs/prometheus/latest/installation/
  - Install Docker and docker-compose on your machine and run following commands,
    ```sh
    docker pull infracloudio/csvserver:latest
    docker pull prom/prometheus:v2.45.2
    ```
  - Clone this repository to your machine. (**Don't fork it**).
  - Use `bash` shell for all the operations, other shells like ksh, fish etc might cause unknown issues.
  - Create a new **private** repository on GitHub.
  - `cd` into the `solution` directory, and perform all the steps from that directory.

> **NOTE**: If you have a Windows machine, you can try to do this assignment on [WSL-2](https://docs.docker.com/docker-for-windows/wsl/) or use https://labs.play-with-docker.com or install GNU/Linux (i.e. Ubuntu) in a virtual machine.

### Please note
  - Any step from the assignment does **not** require you to modify the container image, or build your own container image at all.
  - - Make sure all the files you create have the exact same names as given.
  - Don't commit all of your work as a single commit, commit it as you finish each part, so we can see the work as you built it up.
  - The solution should work on a different machine, which has `docker` and `docker-compose`, without any modifications.
  - Reading this document carefully is the key to solve this assignment.
  - If you need more time or are stuck at some point, don't hesitate to reach out to us.

## Part I
  1. Run the container image `infracloudio/csvserver:latest` in background and check if it's running.
  2. If it's failing then try to find the reason, once you find the reason, move to the next step.
  3. Write a bash script `gencsv.sh` to generate a file named `inputFile` whose content looks like:
     ```csv
     0, 234
     1, 98
     2, 34
     ```
     These are comma separated values with index and a random number.
     - Running the script with two arguments as `./gencsv.sh 2 8`, should generate the file `inputFile` with 7 such entries in current directory. Where the index of first entry is `2` and the last entry is `8`.
     -  4. Run the container again in the background with file generated in (3) available inside the container (remember the reason you found in (2)).
  5. Get shell access to the container and find the port on which the application is listening. Once done, stop / delete the running container.
  6. Same as (4), run the container and make sure,
     - The application is accessible on the host at http://localhost:9393
     - Set the environment variable `CSVSERVER_BORDER` to have value `Orange`.

The application should be accessible at http://localhost:9393, it should have the 7 entries from `inputFile` and the welcome note should have an orange color border.

> **NOTE**: If you are using play-with-docker.com then you will see the number 9393 highlighted at the top. You can access the application by clicking on that instead of using http://localhost:9393

> **NOTE**: On play-with-docker.com, you can create files in the terminal and edit them with their online editor.

# solution for part 1
  
##  $\color{blue} \textbf {installing docker and docker compose and start service}$
    2  yum update -y
    3  yum install docker -y
    4  docker --version
    5  systemctl start docker.s 
    6  systemctl start docker
    7  systemctl enable docker 

````
    8   curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
````
````
    9   chmod +x /usr/local/bin/docker-compose
   10  docker-compose --version
````
##  $\color{blue} \textbf { pull the images as instruction}$
   11  docker pull infracloudio/csvserver:latest
   12  docker pull prom/prometheus:v2.45.2
   13  docker images

##  $\color{blue} \textbf { run or create the container}$ 
````
   14  docker run -d --name csvserver  infracloudio/csvserver
   15  docker ps
   16  docker ps -a
````
##  $\color{blue} \textbf { i have found error my container is not runned bacuse i dont have inputFile}$ 
  #checking logs to find error
   ````
17  docker logs csvserver
  ````

##  $\color{blue} \textbf { cloned the repository }$
 ````
   18  yum install git -y
   19  git clone https://github.com/infracloudio/csvserver.git
 ````
##  $\color{blue} \textbf { checked the directory or files are clomed or not}$
 ````
   20  ls
   21  cd csvserver/
   22  ls
   23  cd solution/
   24  ls
   25  cd ..
 ````
##  $\color{blue} \textbf { completed task to create a sh file to create file which is "inputFile}$
 ````
   26  vim gencsv.sh
   27  ls
   28  ./gencsv.sh
   29  chmod +x gencsv.sh 
   30  ls
   31  ./gencsv.sh
   32  ./gencsv.sh 2 8
   33  ls
 ````
##  $\color{blue} \textbf { by using shellfile here is automatically created inputFile }$
  
    ````
    34  cat inputFile 
     ````
   
##  $\color{blue} \textbf { then i have created once agian container with mounting the file correctly}$
  
    ````
    55  docker run -d --name csvserver -v "$(pwd)/inputFile:/csvserver/inputdata" infracloudio/csvserver:latest
   56  docker ps
   57  docker exec -it csvserver /bin/bash
    ````

##  $\color{blue} \textbf {To Find the listening port Inside the container, run}$
 ````
       netstat -tuln | grep LISTEN
````
then i got port which is assigned to the container 9393
 
````
   62  docker ps
   58  docker rm 6f
   59  docker stop 6f
   60  docker rm 6f
  ````
##  $\color{blue} \textbf {created the container where i use port 9393}$
````
   61  docker run -d --name csvserver -v "$(pwd)/inputFile:/csvserver/inputdata" -p 9393:9300 -e CSVSERVER_BORDER=Orange infracloudio/csvserver:latest
````
````
   62  docker ps
   63  curl http://localhost:9393
````
##  $\color{blue} \textbf {I GOT OUTPUT WHICH IS The application should be accessible at http://localhost:9393, it should have the 7 entries from inputFile and the welcome note should have an orange color border.}$ 

![image](https://github.com/HemaTate/interview-Task/blob/master/Screenshot%20(436).png)

## Part II
  0. Delete any containers running from the last part.
  1. Create a `docker-compose.yaml` file for the setup from part I.
  2. Use an environment variable file named `csvserver.env` in `docker-compose.yaml` to pass environment variables used in part I.
  3. One should be able to run the application with `docker-compose up`.

## Solution of part-II
Here is the solution to create a docker-compose.yaml file for the setup in Part I. We'll also create an environment variable file (csvserver.env) to pass the required environment variables.

##  $\color{blue}{Delete Existing Containers}$
````
docker ps -a  
docker stop [container_id]  
docker rm [container_id]    
````
````
docker rm -f $(docker ps -aq) #if we want to delete all container in one go
````
##  $\color{blue}{Create Environment File}$
````
vim touch csvserver.env
````

Add the following environment variables to the file:

````
CSVSERVER_BORDER=Orange
````

Create docker-compose.yaml

````
touch docker-compose.yaml
````

Add the following content to the file:

````
version: "3.9"

services:
  csvserver:
    image: infracloudio/csvserver:latest
    container_name: csvserver
    ports:
      - "9393:9300" # Map port 9300 inside the container to 9393 on the host
    environment:
      - CSVSERVER_BORDER=${CSVSERVER_BORDER} # Load environment variables from file
    env_file:
      - csvserver.env
    volumes:
      - ./inputFile:/csvserver/inputdata # Mount inputFile into the container
````

To Run the Application create or Generate inputFile:
Run the gencsv.sh script to create the inputFile:

````
./gencsv.sh 2 8
````
Start the application using Docker Compose:
````
docker-compose up
docker-compose up -d #to run in background
````
Verify the setup:

Open your browser and visit:
````
http://localhost:9393
````
Ensure the CSV data and orange border are displayed correctly.
## Output
![image](https://github.com/HemaTate/interview-Task/blob/master/Screenshot%20(436).png)

## part III
Delete any containers running from the last part.
Add Prometheus container (prom/prometheus:v2.45.2) to the docker-compose.yaml form part II.
Configure Prometheus to collect data from our application at <application>:<port>/metrics endpoint. (Where the <port> is the port from I.5)
Make sure that Prometheus is accessible at http://localhost:9090 on the host.
Type csvserver_records in the query box of Prometheus. Click on Execute and then switch to the Graph tab.
The Prometheus instance should be accessible at http://localhost:9090, and it should show a straight line graph with value 7 (consider shrinking the time range to 5m)
## solution :
## Step 1: Delete Any Running Containers
Stop and remove all containers from the previous part I and part II
````
docker-compose down
````
 ## Step 2: Add Prometheus to docker-compose.yaml
Modify the docker-compose.yaml file to include a Prometheus service
````
services:
  csvserver:
    image: infracloudio/csvserver:latest
    container_name: csvserver
    ports:
      - "9393:9300"
    env_file:
      - csvserver.env
    volumes:
      - ./inputFile:/csvserver/inputdata

  prometheus:
    image: prom/prometheus:v2.45.2
    container_name: prometheus
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
````
## Step 3: Create Prometheus Configuration File
Prometheus needs a configuration file to know where to scrape metrics from. Create a prometheus.yml file in the same directory as your docker-compose.yaml with the following content:
````
global:
  scrape_interval: 5s  # How often Prometheus scrapes metrics by default.

scrape_configs:
  - job_name: "csvserver"
    static_configs:
      - targets:
          - "csvserver:9300"  # Replace 9300 with the port on which your application exposes metrics.
````
## Step 4: Start the Docker Compose Setup
Bring up the entire setup, including csvserver and prometheus:
````
docker-compose up --build
````
This command will:
Start the csvserver container and expose its metrics at /metrics.
Start the Prometheus container and configure it to scrape metrics from csvserver.
## Step 5: Verify Prometheus
Open your browser and navigate to:
````
http://localhost:9090
````
In the Query box at the top, type:
````
csvserver_records
````
Click Execute, and switch to the Graph tab.

Adjust the time range (e.g., Last 5 minutes) and confirm that the graph displays a straight line at 7.

This means Prometheus successfully scraped the metric csvserver_records from the csvserver application. 










