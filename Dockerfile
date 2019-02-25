FROM centos

RUN yum -y install epel-release \
    && yum -y install python36 netaddr openssh openssh-clients \
    && alternatives --install /usr/bin/python3 python3 /usr/bin/python36 0 \
    && curl -L https://bootstrap.pypa.io/get-pip.py | python36 \
    && pip install -U pip \
    && pip install -U setuptools

RUN pip install -U ansible==2.7.6 jmespath boto botocore boto3

WORKDIR /opt

COPY . /opt

CMD [ "/usr/local/bin/ansible-playbook" "playbook.yml" ]
