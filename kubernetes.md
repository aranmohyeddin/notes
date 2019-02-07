master: controls the cluster and the nodes in it
nodes: host the containers inside them. containers are inside separate PODS
PODS: logical collection of containers which need to interact with eachother for an app
replication controller: ensures that requested no. of pods are always running on nodes
service: an object on Master that provides load balancing across a replicated group of pods
-> groups set of containers and referes to them via a DNS => load balence requests between the ocntainers of a given service

Master > 2 core, 4GB ram
Nodes > 1 core, 4GB ram

sudo kubeadm init --pod-network-cidr=<> --apiserver-advertise-address=<master-ip>(192...)
                    |> Calico CNI: 192.168.0.0/16 or For Flannel CNI: 10.244.0.0/16
                    |> IP pool for containers within the pod

=> kubernetes will give 3+1 commands

-> run the first three
--> setting up the pod network (Calico)
kubectl apply ...

kubectl get nodes
kubectl get pods --all-namespaces -o wide

setup the dashboard before the nodes join the cluster
dashboard on the master
kubectl create -f https://raw...../src/deploy/recommended/kuber-dashboard.yaml
kubectl proxy  ~> should be accessed on another url :-?

//to create a service account for your dashboard 
kubectl create serviceaccount dashboard -n default

//To add cluster binding rules for ur roles on dashboard
kubectl create clusterrolebinding dashboard-admin -n default \
  --clusterrole=cluster-admin \
  --serviceaccount=default:dashboard

// To get the secret key to be pasted into the dashboard token pwd. Copy outcomming secret key
kubectl

 * keeps resource usage in check and optimize when neccessery
 * bind containers of similar type to a higher-level construct like services so we don't have to deal with individual containers
 * rollout/rollback without downtime
 * Secrets and configuration management
   -> Kubernetes can manage secrets and configuration details for an application without re-building the respective images. With secrets, we can share confidential information to our application without exposing it to the stack configuration, like on GitHub.
 * Storage orchestration
   -> With Kubernetes and its plugins, we can automatically mount local, external, and storage solutions to the containers in a seamless manner, based on software-defined storage (SDS).
 * To manage the cluster state, Kubernetes uses etcd, and all master nodes connect to it. other masters are in high availability mode and they will just follow one master, it's for fault tollerancy.
 
API server: user/operator sends REST to API server which processes and executes them and stores the resulting state of the cluster in the distributed key-value store.
Scheduler: scheduled the work to nodes, has the resource usage stats of each node, also can apply some constraints, eg disk==ssd for a certain task, it also considers data locality, QOS, affinity, anti-affinity. it schedules the work in terms of pods and services.
Controller manager: The controller manager manages different non-terminating control loops, which regulate the state of the Kubernetes cluster. Each one of these control loops knows about the desired state of the objects it manages, and watches their current state through the API server. In a control loop, if the current state of the objects it manages does not meet the desired state, then the control loop takes corrective steps to make sure that the current state is the same as the desired state.
Worker Node: a machine/... that runs the apps using pods and is controlled by the master.
Pod: the scheduling unit in K8s. a logical collection of one or more containers which are always scheduled together.

to access applications from the external world, we connect to worker nodes and not to the master node.

worker->containter runtime: containerd(docker is a platform that uses this), rkt, lxd. manage the container's lifecycle.
worker->kubelet: communicates with master, receives pod definition, runs the containers for the pods and makes sure the containers remain healthy.
---> kubelet connects to Container Runtime using CRI(=protocol buffers, gRPC(Remote proc call) API, libs) -> we can use any CR that implements CRI
---> CRI implements two services
------->ImageService -> image related ops
------->RuntimeService -> pod/container related ops.

etcd is based on (raft consensus algorithm)[https://web.stanford.edu/~ouster/cgi-bin/papers/raft-atc14]
Raft allows a collection of machines to work as a coherent group that can survive the failures of some of its members. At any given time, one of the nodes in the group will be the master, and the rest of them will be the followers. Any node can be treated as a master.
etcd stores cluster state + conf details e.g. subnets, confmaps, secrets, etc.

 * each pod has a unique id -> CR asks CNI which asks MACvlan/Bridge/...
 * containers within a pod can communicate
   * With the help of host OS each CR generally creates isolated nets for each container it starts.
   * these can be shared, inside a Pod, containers share the network namespaces, so that they can reach to each other via localhost.
 * pods can communicate
   * k8s requires not havign NAT so we should either
     * have routable Pods and nodes using the underlyng physical infra e.g. google k8s engine.
     * use software defined networking, e.g. Flannel, Weave, Calico, etc
 * application deployed within the pod is accessible from the external world

container networking specs:
 * Container Network Model (CNM), proposed by Docker
 * Container Network Interface (CNI), proposed by CoreOS (used by k8s)

Configuration modes:
 * All-in-One Single-Node Installation
 * With all-in-one, all the master and worker components are installed on a single node. This is very useful for learning, development, and testing. This type should not be used in production. Minikube is one such example, and we are going to explore it in future chapters.
 * Single-Node etcd, Single-Master, and Multi-Worker Installation
 * In this setup, we have a single master node, which also runs a single-node etcd instance. Multiple worker nodes are connected to the master node.
 * Single-Node etcd, Multi-Master, and Multi-Worker Installation
 * In this setup, we have multiple master nodes, which work in an HA mode, but we have a single-node etcd instance. Multiple worker nodes are connected to the master nodes.
 * Multi-Node etcd, Multi-Master, and Multi-Worker Installation
 * In this mode, etcd is configured in a clustered mode, outside the Kubernetes cluster, and the nodes connect to it. The master nodes are all configured in an HA mode, connecting to multiple worker nodes. This is the most advanced and recommended production setup.

