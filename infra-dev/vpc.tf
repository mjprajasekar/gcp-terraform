module "vpc-client" {
  source  = "terraform-google-modules/network/google"
  version = "~> 9.1"

  project_id   = var.project_id
  network_name = "client1"
  routing_mode = "REGIONAL"

  subnets = [
    {
      subnet_name   = "subnet-01"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = "australia-southeast2"
    },
    {
      subnet_name           = "subnet-02"
      subnet_ip             = "10.10.20.0/24"
      subnet_region         = "australia-southeast2"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
      description           = "This subnet has a description"
    },
    {
      subnet_name               = "subnet-03"
      subnet_ip                 = "10.10.30.0/24"
      subnet_region             = "australia-southeast2"
      subnet_flow_logs          = "true"
      subnet_flow_logs_interval = "INTERVAL_10_MIN"
      subnet_flow_logs_sampling = 0.7
      subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
    }
  ]

  secondary_ranges = {
    subnet-01 = [
      {
        range_name    = "subnet-01-secondary-01"
        ip_cidr_range = "192.168.64.0/24"
      },
    ]

    subnet-02 = []
  }
}

module "vpc-server" {
  source  = "terraform-google-modules/network/google"
  version = "~> 9.1"

  project_id   = var.project_id
  network_name = "server1"
  routing_mode = "REGIONAL"

  subnets = [
    {
      subnet_name   = "subnet-04"
      subnet_ip     = "10.11.10.0/24"
      subnet_region = "australia-southeast2"
    },
    {
      subnet_name           = "subnet-05"
      subnet_ip             = "10.11.20.0/24"
      subnet_region         = "australia-southeast2"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
      description           = "This subnet has a description"
    },
    {
      subnet_name               = "subnet-06"
      subnet_ip                 = "10.11.30.0/24"
      subnet_region             = "australia-southeast2"
      subnet_flow_logs          = "true"
      subnet_flow_logs_interval = "INTERVAL_10_MIN"
      subnet_flow_logs_sampling = 0.7
      subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
    }
  ]

  secondary_ranges = {
    subnet-01 = [
      {
        range_name    = "subnet-02-secondary-01"
        ip_cidr_range = "192.167.64.0/24"
      },
    ]

    subnet-02 = []
  }
}

# vpc peering 

module "peering-client-server" {
  source = "terraform-google-modules/network/google//modules/network-peering"

  prefix        = "name-prefix"
  local_network = module.vpc-server.network.network_id
  peer_network  = module.vpc-client.network.network_id
}