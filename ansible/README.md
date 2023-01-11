# Ansible
We used [Ansible] to configure all the VMs necessary for the infrastructure to function. 
> **Info:** [Ansible] allows you to configure VMs in an agentless way by simply executing commands via the SSH protocol.

We have created a series of playbooks for initial configuration, copying, starting and stopping the Docker Swarm; we have also configured the join in the Docker Swarm in a fully automatic way by the other manager nodes as well as for the worker nodes. There is also a small SH script to optimize the SWAP and Network of individual nodes.

## Playbooks
To be able to use playbooks correctly you have to create the swarm-mode directory in `/root/swarm-mode` with the [swarm-mode](https://github.com/MatteoFasulo/ScalableWebApp/tree/main/swarm-mode) content of this repository. The `swap_and_network.sh` script must be placed in the `root` folder.

#### Run a playbook
```sh
ansible-playbook <PLAYBOOK_NAME.yml>
```

## Hosts file
You need to edit the `hosts` file by changing the public IP addresses of the VMs to be used as manager and worker nodes; for SSH access [Ansible] uses public-key encryption so you will need to create a pair of SSH keys and provide [Ansible] with the private key for SSH access to the VMs.



[Ansible]: <https://www.ansible.com/>
