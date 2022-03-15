## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

https://github.com/Rubick-Techies/Project13/blob/main/network%20diagram.PNG

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the pentest.yml file may be used to install only certain pieces of it, such as Filebeat.

https://github.com/Rubick-Techies/Project13/blob/main/Ansible/pentest.yml

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly responsive, in addition to restricting traffic to the network.
Load balancers help to ensure the availability of a network by distributing traffic across multiple servers to minimise overload (e.g. from DDoS attacks). 
The Jumpbox gateway VM is used as a security measure to stop Azure traffic from being publicly accessible through utilising SSH connections and security rules to control access to the network.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the performance and system logs.
- Filebeat watches for changes to log data in a file system, keeping a record of their state and assigning unique identifiers (as files can be renamed, move etc.) to detect whether a file has been harvested previously. 
- Metricbeat allows you to monitor and record server metric data and send them to the ELK server (metric data such as CPU or memory usage, load and network traffic).

The configuration details of each machine may be found below.

| Name of VM         | Function    | IP address            | Operating System |
|--------------------|-------------|-----------------------|------------------|
| JumpBoxProvisioner | Gateway     | 20.70.88.132 (Public) | Linux            |
| Web1               | DVWA        | 10.2.0.7 (Private)    | Linux            |
| Web2               | DVWA        | 10.2.0.8 (Private)    | Linux            |
| Web3               | DVWA        | 10.2.0.9 (Private)    | Linux            |
| ELK-SERVER         | Monitoring  | 10.3.0.4 (Private)    | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the ELK-SERVER machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
20.37.11.111:5601
which can be accessed via
http://20.37.11.111:5601/app/kibana#/home


Machines within the network can only be accessed by the JumpBoxProvisioner VM which has been configured to require an SSH connection configured to my host's IPv4 address.
My JumpBoxProvisioner has access to my ELK-SERVER VM. The JumpBoxProvisioner's public IP is 20.70.88.132.

A summary of the access policies in place can be found in the table below.

| Name of VM         | Publicly Accessible | Allowed IP Addresses          |
|--------------------|---------------------|-------------------------------|
| JumpBoxProvisioner | No (SSH)            | 121.200.5.159 (My public IP)  |
| Web1               | No (SSH)            | 10.2.0.4 (JumpBox private IP) |
| Web2               | No (SSH)            | 10.2.0.4 (JumpBox private IP) |
| Web3               | No (SSH)            | 10.2.0.4 (JumpBox private IP) |
| ELK-SERVER         | Yes                 | 121.200.5.159 (My public IP)  |
### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because it minimises the chance for error when having to rewrite configuration files and utilising ansible playbooks can excecute tasks in order. 

The playbook implements the following tasks:
- Increases the virtual memory usage
- Installs docker.io
- Downloads and launches the sebp/elk:761 container with published ports '5601:5601','9200:9200','5044:5044'
- Installs python3-pip
- Enables docker service

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

https://github.com/Rubick-Techies/Project13/blob/main/docker_ps_output.PNG

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
Web1: 10.2.0.7
Web2: 10.2.0.8
Web3: 10.2.0.9

We have installed the following Beats on these machines:
- Metricbeat and Filebeat were installed to the [webservers] in the /etc/ansible/hosts file defined as the the 3 VMs: Web1-10.2.0.7, Web2-10.2.0.8 and Web3-10.2.0.9.

These Beats allow us to collect the following information from each machine:
- Metricbeat collects and sends metric data of our 3 Web VMs to our ELK server such as memory and CPU usage and network traffic, e.g. could be used to analyse a DDoS attack.
- Filebeat monitors log files and changes to them, log events and other log data to analyse in Kibana through our ELK server, e.g. could be used to analyse attempted logins to access our system.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the pentest.yml file to playbook.
- Update the pentest file to include desired server IP under [webservers] with ansible_python_interpreter=/usr/bin/python3 in /etc/ansible/hosts.
- Run the playbook, and navigate to the server via ssh and curl localhost/setup.php to check that the installation worked as expected.

Answer the following questions to fill in the blanks:
- Which file is the playbook? 
	pentest.yml
- Where do you copy it?
	/etc/ansible/
- Which file do you update to make Ansible run the playbook on a specific machine? 
	/etc/ansible/hosts
- How do I specify which machine to install the ELK server on versus which to install Filebeat on?
	define your server groups in /etc/ansible/hosts/ 
- Which URL do you navigate to in order to check that the ELK server is running?
	http://20.37.11.111:5601/app/kibana#/home
_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._