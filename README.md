# Web-App-DevOps-Project


Welcome to the Web App DevOps Project repo! In this project, I endeavored to replicate the role of a DevOps engineer by implementing a streamlined pipeline for deploying a web application. This application allows you to efficiently manage and track orders for a potential business. It provides an intuitive user interface for viewing existing orders and adding new ones.

## Table of Contents

- [Tools](#tools)
- [Web Application ](#Web-app)
- [Technology Stack](#technology-stack)
- [Contributors](#contributors)
- [License](#license)

## Architecture Diagram
Here is the proposed architecture that I will be building in this project.

   ![Architecture Diagram](<images/DevOps Pipeline Architecture.jpeg>)

### Tools <a name="tools"></a>

- GIT
- Docker
- Terraform
- Kubernetes
- Azure (including AKS and Azure devops)


### Prerequisites

- Azure
- Terraform
- Dockerfile

## Web Application <a name="Web-app"></a>

### Features

- **Order List:** View a comprehensive list of orders including details like date UUID, user ID, card number, store code, product code, product quantity, order date, and shipping date.
  
![Screenshot 2023-08-31 at 15 48 48](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/3a3bae88-9224-4755-bf62-567beb7bf692)

- **Pagination:** Easily navigate through multiple pages of orders using the built-in pagination feature.
  
![Screenshot 2023-08-31 at 15 49 08](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/d92a045d-b568-4695-b2b9-986874b4ed5a)

- **Add New Order:** Fill out a user-friendly form to add new orders to the system with necessary information.
  
![Screenshot 2023-08-31 at 15 49 26](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/83236d79-6212-4fc3-afa3-3cee88354b1a)

- **Data Validation:** Ensure data accuracy and completeness with required fields, date restrictions, and card number validation.

### Prerequisites

For the application to succesfully run, you will need to have the packages in the 'requirements.txt' file.

### Usage

To run the application, you simply need to run the `app.py` script in this repository. Once the application starts you should be able to access it locally at `http://127.0.0.1:5000`. Here you will be meet with the following two pages:

1. **Order List Page:** Navigate to the "Order List" page to view all existing orders. Use the pagination controls to navigate between pages.

2. **Add New Order Page:** Click on the "Add New Order" tab to access the order form. Complete all required fields and ensure that your entries meet the specified criteria.

### Technology Stack

- **Backend:** Flask is used to build the backend of the application, handling routing, data processing, and interactions with the database.

- **Frontend:** The user interface is designed using HTML, CSS, and JavaScript to ensure a smooth and intuitive user experience.

- **Database:** The application employs an Azure SQL Database as its database system to store order-related data.

## GIT
I have used githb and git for version control. The following shows an example of this:

## Feature Implementation

## Introduction

In this commit, I implemented a feature branch to introduce the `delivery_date` column into the codebase. The modifications involved updating both the `app.py` and `order.html` files within the repository.

### Code Modifications

1. **app.py**
   - Added handling for the `delivery_date` column in the relevant parts of the code.
   - Incorporated necessary logic to interact with the new data.

2. **order.html**
   - Updated the HTML template to display and capture the `delivery_date` to the order form.

### Reversion

Upon further consideration and feedback, it was determined that the introduction of the `delivery_date` column was not necessary for the current scope of the project. To revert the changes and restore the codebase to its previous state, the following actions were taken:

```bash
git revert <commit_hash_of_feature_branch>
```

### Feature Implementation

## Docker

By using docker, I containerized the application, allowing for distribution to different teams across the company to work on the project, irrespective of their working environment. The process involved creating a 'dockerfile', which gave instructions on containerising the application. Using ```docker build``` and ```docker push```, an image is created, and pushed to dockerhub.

# Docker Build Instructions

## Docker Build

The following steps outline how to build a Docker image for my application:

1. **Build the Docker Image**
   -Use the docker build command to build the Docker image. Specify the path to the directory containing the Dockerfile using the dot (.) if the Dockerfile is in the current directory.

   ```bash
   docker build -t myimage:latest .   
   ```

   The `-t` flag is used to tag the image.

   As Docker builds the image, it executes each instruction in the Dockerfile. One can see output indicating the progress of each step, displaying any error messages or warnings.

   Once the build is complete, verifying that the image has been created was done by listing all Docker images on the system.

   ```bash
   docker images
   ```
2. **Run the image locally**

   Running a Docker container locally ensures the application functions correctly within the containerized environment, I followed this process:

   Execute the following command to initiate the Docker container: `docker run -p 5000:5000 myimage`. This maps port 5000 from your local machine to the container, enabling access to the containerized application from your local development environment.

   Open a web browser and go to `http://127.0.0.1:5000` to interact with the application within the Docker container. Confirm the application works as expected by testing its functionality within the containerized environment.


3. **Push to Docker Hub**

   Finally, pushing the image to dockerhub:

   ```bash   
   docker login
   docker tag <image-name>:<tag> <docker-hub-username>/<image-name>:<tag>
   docker push <docker-hub-username>/<image-name>:<tag>
   ```

   When this process finished, I logged onto my Docker Hub repository and confirmed that the relevant docker image was listed. Following this process, one should be able to see the image's name, version (tag), and other relevant information.


## Clean Up

**Remove Containers**: Use the `docker ps -a command` to list all containers, including stopped ones. Remove any unnecessary containers with `docker rm <container-id>` to free up resources.

**Remove Images**: List all images using `docker images -a` and remove any unneeded images with `docker rmi <image-id>` to reclaim disk space.


## Terraform

Terraform is an important tool because it allows me to provision all the necessary infrastructure resources efficiently and consistently, enabling seamless deployment and management of complex cloud environments.

Here is how I have used it:

## Networking Module


The Networking Module is a foundational component crafted to establish the fundamental networking infrastructure required to support an Azure Kubernetes Service (AKS) cluster seamlessly. By automating the creation of essential networking resources, this module ensures a robust and well-architected network environment for your Kubernetes workloads.

# Key Feature:

- Azure Resource Group: Centralizing resources for simplified management, the module creates an Azure Resource Group to organize and govern the resources associated with the AKS cluster, promoting operational efficiency and ease of administration.

- Virtual Network (VNet): Facilitating secure communication among cluster components, the module provisions a Virtual Network (VNet) to establish an isolated network environment, enabling seamless connectivity while ensuring data integrity and confidentiality.

- Control Plane Subnet: Dedicated to hosting the AKS cluster's control plane components, such as the Kubernetes API server and etcd, the Control Plane Subnet provides a secure and segregated space for managing cluster operations, enhancing resilience and performance.

- Worker Node Subnet: Reserved for accommodating the worker nodes that execute containerized workloads, the Worker Node Subnet offers a scalable and flexible infrastructure for deploying and scaling application instances, catering to varying workload demands efficiently.

- Network Security Group (NSG): Enforcing network security policies and access controls, the module configures a Network Security Group (NSG) to filter inbound and outbound traffic, fortifying the AKS cluster against unauthorized access, malicious threats, and potential vulnerabilities.


## AKS Cluster Module

The AKS Cluster Module provides a streamlined approach to deploying and managing Azure Kubernetes Service (AKS) clusters. This module encompasses the orchestration of essential resources for a robust Kubernetes environment, ensuring seamless deployment and efficient management.

# Key Features:

- Scalable Infrastructure: The module facilitates the creation of a scalable infrastructure tailored to the requirements of your applications, enabling horizontal scaling of workloads across a cluster of virtual machines.

- Automated Deployment: Simplifying the deployment process, the module automates the provisioning of critical resources including Azure Resource Group, Virtual Network (VNet), Control Plane Subnet, Worker Node Subnet, and Network Security Group (NSG), ensuring a hassle-free setup.

- Network Security: With built-in support for Network Security Group (NSG), the module strengthens the security posture of the AKS cluster by enforcing network traffic rules and access controls, safeguarding against unauthorized access and potential threats.

- Optimized Resource Utilization: Leveraging Azure's capabilities, the module optimizes resource utilization by efficiently allocating compute resources to meet application demands while minimizing costs.

- High Availability: Ensuring high availability of applications, the AKS Cluster Module leverages Azure's fault-tolerant infrastructure, enabling continuous operation even in the event of hardware failures or disruptions.

- Customization and Flexibility: Offering flexibility and customization options, the module allows for fine-tuning of cluster configurations, including node sizes, instance counts, and networking settings, to align with specific workload requirements.

- Monitoring and Management: Integrated monitoring and management capabilities enable real-time insights into cluster performance and health, empowering administrators with the tools to optimize resource usage and troubleshoot issues effectively.

- Seamless Integration: Seamlessly integrate with other Azure services and DevOps tools, enabling streamlined workflows for application development, deployment, and operations within the AKS environment.


## Security

By provisioning the NSG, I control all inbound and outbound traffic, ensuring that any unauthorized access triggers alerts to the appropriate parties, thus maintaining security.


## Monitoring

This documentation outlines the steps taken to establish effective monitoring and alerting for an Azure Kubernetes Service (AKS) cluster. Proper monitoring is essential for ensuring the optimal performance, resource allocation, and stability of the AKS environment.

### Metrics Explorer Configuration

After enabling container insights, the following charts were created in the Metrics Explorer to provide a comprehensive overview of the AKS cluster's performance:

1. **Average Node CPU Usage:**
   - *Purpose:* Track CPU usage of AKS cluster nodes for efficient resource allocation and performance issue detection.
   -  *Interpretation*: A higher percentage indicates higher CPU usage. Regularly check this to optimize resources.  

2. **Average Pod Count:**
   - *Purpose:* Display the average number of pods running in the AKS cluster, aiding in capacity evaluation and workload distribution analysis.
   - *Interpretation*: A sudden increase may indicate increased workload. Monitor to ensure pods are distributed evenly.


3. **Used Disk Percentage:**
   - *Purpose:* Monitor disk usage to prevent storage-related issues by tracking the utilized disk space.
   *Interpretation*: A higher percentage may lead to storage issues. Regularly check and optimize storage.

4. **Bytes Read and Written per Second:**
   - *Purpose:* Monitor data I/O to identify potential performance bottlenecks by providing insights into data transfer rates.
   - *Interpretation*: Spikes in data transfer rates may indicate performance issues. Monitor for efficient data flow.

   The following screenshot of shows the metrics dashboard, containing all 4 charts:

   ![AKS Cluster Metrics](images/AKS%20cluster%20metrics.png)

### Log Analytics Configuration

Log Analytics was configured to capture detailed information for more in-depth analysis:

1. **Average Node CPU Usage Percentage per Minute:**
   - *Purpose:* Record granular data on node-level CPU usage, capturing logs per minute for detailed analysis.

   ![Average Nodes CPU Usage](images/log-Average%20Nodes%20CPU%20Usage.png)

2. **Average Node Memory Usage Percentage per Minute:**
   - *Purpose:* Track node-level memory usage to detect memory-related performance concerns and optimize resource allocation.

   ![Average Node Memory Usage](images/log-Average%20Node%20memory%20Usage.png)


3. **Pods Counts with Phase:**
   - *Purpose:* Provide information on pod counts with different phases (Pending, Running, Terminating) for workload distribution insights.

   ![Pod Counts with Phase](images/pod%20counts%20with%20Phase.png)


4. **Find Warning Value in Container Logs:**
   - *Purpose:* Proactively detect issues or errors within containers by configuring Log Analytics to search for `warning` values in container logs.

   ![Warning Container Logs](images/Warning%20container%20logs.png)


5. **Monitoring Kubernetes Events:**
   - *Purpose:* Monitor Kubernetes events, including pod scheduling, scaling activities, and errors, to ensure overall cluster health and stability.

   ![Kubernetes Events](images/kubernetes%20events.png)


### Alert Rule Configuration

#### Disk Usage Alert

- **Objective:** Trigger an alarm when the used disk percentage in the AKS cluster exceeds 90%.
- **Frequency:** Check every 5 minutes.
- **Loopback Period:** 15 minutes.
- **Notification:** Configure alerts to be sent to the specified email address for proactive issue detection and resolution planning.

### CPU and Memory Usage Alerts

- **Objective:** Trigger alerts when CPU usage and memory working set percentage exceed 80%.
- **Purpose:** Ensure timely notification when critical resources approach their limits, preventing decreased application performance.
- **Frequency:** Check every 5 minutes.
- **Notification:** Alerts configured to notify the specified email address for prompt response and resource optimization.

By implementing these monitoring and alerting configurations, the AKS cluster is equipped to maintain optimal performance and respond promptly to potential issues.

## Potential response

### General Response Strategies:

1. **Incident Documentation:**
   - Document each incident, including the actions taken, for future reference and improvement.

3. **Alert Threshold Review:**
   - Periodically review and adjust alert thresholds based on evolving application requirements.

4. **Historical Analysis:**
   - Use monitoring tools to analyze historical trends, helping to plan for future resource needs and optimize the AKS cluster.

5. **Capacity Planning:**
   - Conduct regular capacity planning to anticipate resource requirements and scale the cluster accordingly.

6. **Continuous Improvement:**
   - Continuously assess and improve AKS configurations and operational procedures based on insights gained from monitoring and alerting.

### Disk Usage Exceeds 90%:

1. **Immediate Investigation:**
   - Review the alert details to identify the specific node or nodes experiencing high disk usage.

2. **Data Cleanup:**
   - Remove unnecessary files or data to free up disk space.

3. **Scaling Persistent Storage:**
   - Assess the need for scaling persistent storage on affected nodes to accommodate increased disk usage.

4. **Optimize Logging:**
   - Review and optimize application logging configurations to prevent excessive log data from filling up the disk.

5. **Container Cleanup:**
   - Clean up unused containers and images on the affected nodes.

### CPU and Memory Usage Exceeds 80%:

1. **Immediate Investigation:**
   - Identify the specific pods or containers causing high CPU or memory usage based on the alert details.

2. **Vertical Scaling:**
   - Adjust resource requests and limits for the affected pods to allocate more CPU and memory.

3. **Horizontal Scaling:**
   - Deploy additional instances of the application (horizontal scaling) if vertical scaling is insufficient.

5. **Auto-Scaling Configuration:**
   - Configure or adjust auto-scaling settings for the AKS cluster to dynamically adjust node count based on demand.




## Contributors 

- [Maya Iuga]([https://github.com/yourusername](https://github.com/maya-a-iuga))

## License

This project is licensed under the MIT License. For more details, refer to the [LICENSE](LICENSE) file.