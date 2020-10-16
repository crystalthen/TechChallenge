FROM python:3

WORKDIR /work

# Install ansible and required python modules
COPY requirements.txt ./
RUN pip install -r /work/requirements.txt \
    && ansible-galaxy collection install community.aws

# Install AWS cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install

ENTRYPOINT [ "/bin/sh" ]
CMD [ "ansible-playbook", "./TechChallengeApp/deploy/deploy.yml" ]
