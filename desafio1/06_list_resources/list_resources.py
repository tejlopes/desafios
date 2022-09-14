#!/bin/python3
import boto3

class RegionDoNotExists(Exception): ...

class ClusterDoNotExists(Exception): ...

class EKS:
    def __init__(self, region='us-east-1'):
        self.client = boto3.Session().client('eks', region_name=region)
        self.region = region
        self.list_eks = []

    def valid_region(self, region):
        self.available_regions = ['us-east-2', 'us-east-1', 'us-west-1', 'us-west-2', 'af-south-1', 'ap-east-1', 'ap-southeast-3', 'ap-south-1', 'ap-northeast-3', 'ap-northeast-2', 'ap-southeast-1', 'ap-southeast-2', 'ap-northeast-1', 'ca-central-1', 'eu-central-1', 'eu-west-1', 'eu-west-2', 'eu-south-1', 'eu-west-3', 'eu-north-1', 'me-south-1', 'sa-east-1']
        if not region.lower() in self.available_regions:
            raise RegionDoNotExists("A região {} não existe.".format(region))
        else:
            return True

    def valid_cluster(self, cluster):
        if cluster not in self.get_eks():
            raise ClusterDoNotExists("O cluster {} não existe".format(cluster))
        else:
            return True

    def get_eks(self):
        list_eks = []
        response = self.client.list_clusters()
        for cluster in response['clusters']:
            list_eks.append(cluster)
        return list_eks

    def get_nodegroups(self, cluster):
        list_nodegroups = []
        response = self.client.list_nodegroups(clusterName=cluster)
        for nodegroup in response['nodegroups']:
            list_nodegroups.append(nodegroup)
        return list_nodegroups


if __name__ == "__main__":
    region = input("Para buscar por clusters EKS insira a região desejada (Ex: 'us-east-1'): ")
    eks = EKS(region)
    try:
        eks.valid_region(region)
    except RegionDoNotExists as e:
        error = {'error': str(e)}
    list_eks = eks.get_eks()
    print("Os clusters eks existentes na região {} são: {}.".format(region, ', '.join(list_eks)))
    cluster = input("Para buscar por nodegroups de um cluster EKS insira a nome do cluster (Ex: 'desafio-cluster'): ")
    try:
        eks.valid_cluster(cluster)
    except ClusterDoNotExists as e:
        error = {'error': str(e)}
    list_nodegroups = eks.get_nodegroups(cluster)
    print("Os managed nodegroups existentes no cluster {} são: {}".format(cluster, ', '.join(list_nodegroups)))