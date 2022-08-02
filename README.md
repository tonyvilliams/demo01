# Description
Deploy infrastructure required for lambda application to run inside a VPC

## Parameters
The list of parameters for this template:

* ### environment 
    Type: String <br />
    Default: dev <br />
    Description: Environment in which the resources will be deployed <br />
* ### VpcCidr 
    Type: String <br />
    Default: 10.1.0.0/16 <br />
    Description: VPC Cidr in which the resources will be deployed <br />
* ### PublicSubnet1aCidr 
    Type: String <br />
    Default: 10.1.1.0/24 <br />
    Description: Public Subnet Cidr in which the resources will be deployed <br />
* ### PublicSubnet1bCidr 
    Type: String <br />
    Default: 10.1.2.0/24 <br />
    Description: Public Subnet Cidr in which the resources will be deployed <br />
* ### PrivateSubnet1aCidr 
    Type: String <br />
    Default: 10.1.3.0/24 <br />
    Description: Private Subnet Cidr in which the resources will be deployed <br />
* ### PrivateSubnet1bCidr 
    Type: String <br />
    Default: 10.1.4.0/24 <br />
    Description: Private Subnet Cidr in which the resources will be deployed <br />

## Resources
The list of resources this template creates:

* ### pubPrivateVPC 
    Type: AWS::EC2::VPC  
* ### publicSubnet1a 
    Type: AWS::EC2::Subnet  
* ### publicSubnet1b 
    Type: AWS::EC2::Subnet  
* ### privateSubnet1a 
    Type: AWS::EC2::Subnet  
* ### privateSubnet1b 
    Type: AWS::EC2::Subnet  
* ### internetGateway 
    Type: AWS::EC2::InternetGateway  
* ### gatewayToInternet 
    Type: AWS::EC2::VPCGatewayAttachment  
* ### publicRouteTable 
    Type: AWS::EC2::RouteTable  
* ### publicRoute 
    Type: AWS::EC2::Route  
* ### publicSubnet1aRouteTableAssociation 
    Type: AWS::EC2::SubnetRouteTableAssociation  
* ### publicSubnet1bRouteTableAssociation 
    Type: AWS::EC2::SubnetRouteTableAssociation  
* ### natGateway1a 
    Type: AWS::EC2::NatGateway  
* ### natPublicIP1a 
    Type: AWS::EC2::EIP  
* ### RouteTable1a 
    Type: AWS::EC2::RouteTable  
* ### RouteTable1b 
    Type: AWS::EC2::RouteTable  
* ### Route1a 
    Type: AWS::EC2::Route  
* ### Route1b 
    Type: AWS::EC2::Route  
* ### privateSubnet1aRouteTableAssociation 
    Type: AWS::EC2::SubnetRouteTableAssociation  
* ### privateSubnet1bRouteTableAssociation 
    Type: AWS::EC2::SubnetRouteTableAssociation  
* ### LambdaIAMRole 
    Type: AWS::IAM::Role  
* ### DynamoDBTable 
    Type: AWS::DynamoDB::Table  
* ### ApiDeployment 
    Type: AWS::Serverless::Api  
* ### CDDemoLambda 
    Type: AWS::Serverless::Function  
* ### WAFv2WebACL 
    Type: AWS::WAFv2::WebACL  
* ### WAFv2IPSet 
    Type: AWS::WAFv2::IPSet  
* ### WAFv2WebACLAssociation 
    Type: AWS::WAFv2::WebACLAssociation  

## Outputs
The list of outputs this template exposes:

* ### pubPrivateVPCID 
    Description: VPC ID 
    Export name: {'Fn::Join': ['-', [{'Ref': 'AWS::StackName'}, 'vpc']]}  

* ### devSubnet1aID 
    Description: Private Subnet A ID 
    Export name: {'Fn::Join': ['-', [{'Ref': 'AWS::StackName'}, 'private-subnet1a']]}  

* ### privateSubnet1bID 
    Description: Private Subnet B ID 
    Export name: {'Fn::Join': ['-', [{'Ref': 'AWS::StackName'}, 'private-subnet1b']]}  

* ### privateVPCSecurityGroup 
    Description: Default security for Lambda VPC 
    Export name: {'Fn::Join': ['-', [{'Ref': 'AWS::StackName'}, 'vpc-sg']]}  

* ### APIUrl 
  

