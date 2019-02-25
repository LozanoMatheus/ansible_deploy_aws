# Deploy AWS Stack with Ansible

This project will deploy the entire stack on AWS and it will store the state for this stack.

It's possible to create/update/delete without changing the logic, just changing the variables on `group_vars/all/`.

---

## Index

* [Pre-requirements](https://github.com/LozanoMatheus/ansible_deploy_aws#pre-requirements)
* [Running](https://github.com/LozanoMatheus/ansible_deploy_aws#running)
  * [Deploying & Deleting](https://github.com/LozanoMatheus/ansible_deploy_aws#deploying--deleting)
  * [Just Deleting](https://github.com/LozanoMatheus/ansible_deploy_aws#just-deleting)
* [How it works](https://github.com/LozanoMatheus/ansible_deploy_aws#how-it-works)
  * [SSH Key](https://github.com/LozanoMatheus/ansible_deploy_aws#ssh-key)
  * [Security Group](https://github.com/LozanoMatheus/ansible_deploy_aws#security-group)
  * [EC2](https://github.com/LozanoMatheus/ansible_deploy_aws#ec2)

---

## Pre-requirements

* Developed, Tested and Executed on [Ansible 2.7.6](https://github.com/ansible/ansible/blob/stable-2.7/changelogs/CHANGELOG-v2.7.rst#v2-7-6)
* Define the variables `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`.

---

## Running

You have multiple choices to use in here. You can just deploy or just delete, deploy and after delete everything or just a few resources.

### Deploying & Deleting

To deploy your stack and after deleting everything, you can run this command.

```bash
ansible-playbook -e "delete_env=true" playbook
```

If you use `-e "delete_env=false"` for this variable or don't set up, it will just deploy the stack and create the state files/variables.

### Just Deleting

To delete without creating anything, you can run this command.

```bash
ansible-playbook -e "just_delete=true" playbook
```

---

## How it works

If you need to deploy the entire stack, you can just execute the ansible like `ansible-plabook playbook.yml`. But you can add, change or delete resources easily.

### SSH Key

The role `01-ssh_key` will check if not exist the files on `files/keys/` and will create, otherwise, it will skip the ssh key generation.

Based on these files (Private/Public), the role will deploy the public key on your AWS Account

### Security Group

These tasks are dynamic generated/updated. You just need to change the files `group_vars/all/sg_roles.yml` or `roles/02-security_groups/templates/create_sg.j2` _(Optional)_.

By default, it will allow your public IPv4 to access via SSH/TCP on 22 port and ports 80/443-TCP to download packages from yum repositories.

### EC2

At the end of the role `03-ec2`, it will create the `hosts` ansible inventory file and print the public and private IPv4 of your instances.

Example:

```text
TASK [03-ec2 : Creating inventory file] *****************************************************************************************************************************************************************
changed: [localhost]

TASK [03-ec2 : Instances Private ipv4] ******************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": [
        "x.x.x.x",
        "x.x.x.x",
        "x.x.x.x"
    ]
}

TASK [03-ec2 : Instances Public ipv4] *******************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": [
        "y.y.y.y",
        "y.y.y.y",
        "y.y.y.y"
    ]
}
```
