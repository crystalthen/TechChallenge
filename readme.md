# Servian Tech Challenge

This is my solution for the Servian Tech Challenge.

The solution creates the following components in AWS:
- VPC (ap-southeast-2)
- RDS instance (postgres, multi-az)
- EC2 instance (t2.micro)
- Elastic load balancer

The application binary runs on the EC2 instance as a service under systemd.
Network traffic between components is locked down to only what is required with security groups.

These components are created by an ansible playbook which runs in a docker container. Running the playbook in this way minimises the burden of pre-reqs (ansible, aws cli, various python modules) on the user.

## Usage

### Pre-requisites

- An AWS account with working access keys
- Docker

### Deployment

1. Clone the repository

        # git clone git@github.com:crystalthen/TechChallenge.git

2. Build the docker image

        docker build . -t techchallenge:latest


3. Add your AWS access key details to the `group_vars/all` file

        # cd TechChallenge/
        # vim group_vars/all

    Edit the following lines:

        access_key_id: xxxx
        secret_key: xxxx

4. Run the playbook inside the image

        docker run -v "${PWD}":/work --rm techchallenge:latest ./deploy.yml

The playbook takes about 20 minutes to run.

---

## To-Do

- Create EC2 launch group and auto-scaling group
- Update ELB from classic
- Pass AWS credentials through to the container via environment variables

##  Lessons learned
Given more time I would learn to deploy the AWS infra with a more specialised infra as code solution (e.g.: Terraform). Deploying with Ansible works fine, but it's a headache to set vars (for instance IDs, security group IDs, etc) and tearing down the stack afterwards is a manual process.

I'd also try to run the app with Fargate ECS for better reliability and scalability, and ease of updates.