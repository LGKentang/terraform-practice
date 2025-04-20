terraform {
#	backend "local" {
#		path = "./terraform.tfstate"
#	}
   cloud {
	 	organization = "lgk"
	 	workspaces {
	 		name = "terraform-experimental"
	 		project = "terraform-experimental"		
	 	}
   }

		required_providers {
		aws = {
			source = "hashicorp/aws"
			version = "5.93.0"
		}
	}
}

resource "aws_instance" "test-server" {
    ami                                  = "ami-04b3f96fa99d40135"
    arn                                  = "arn:aws:ec2:ap-southeast-2:908027419451:instance/i-0aafefd41027d23f9"
    associate_public_ip_address          = true
    availability_zone                    = "ap-southeast-2a"
    disable_api_stop                     = false
    disable_api_termination              = false
    ebs_optimized                        = false
    get_password_data                    = false
    hibernation                          = false
    host_id                              = null
    iam_instance_profile                 = null
    id                                   = "i-0aafefd41027d23f9"
    instance_initiated_shutdown_behavior = "stop"
    instance_lifecycle                   = null
    instance_state                       = "running"
    instance_type                        = "t2.micro"
    ipv6_address_count                   = 0
    ipv6_addresses                       = []
    key_name                             = "DemoKeyPair"
    monitoring                           = false
    outpost_arn                          = null
    password_data                        = null
    placement_group                      = null
    placement_partition_number           = 0
    primary_network_interface_id         = "eni-06f2b934c775a8094"
    private_dns                          = "ip-172-31-7-65.ap-southeast-2.compute.internal"
    private_ip                           = "172.31.7.65"
    public_dns                           = "ec2-13-54-19-47.ap-southeast-2.compute.amazonaws.com"
    public_ip                            = "13.54.19.47"
    secondary_private_ips                = []
    security_groups                      = [
        "launch-wizard-1",
    ]
    source_dest_check                    = true
    spot_instance_request_id             = null
    subnet_id                            = "subnet-07f705230099d4742"
    tags                                 = {
        "Name" = "test-server"
    }
    tags_all                             = {
        "Name" = "test-server"
    }
    tenancy                              = "default"
    vpc_security_group_ids               = [
        "sg-049228208ea1d8248",
    ]

    capacity_reservation_specification {
        capacity_reservation_preference = "open"
    }

    cpu_options {
        amd_sev_snp      = null
        core_count       = 1
        threads_per_core = 1
    }

    credit_specification {
        cpu_credits = "standard"
    }

    enclave_options {
        enabled = false
    }

    maintenance_options {
        auto_recovery = "default"
    }

    metadata_options {
        http_endpoint               = "enabled"
        http_protocol_ipv6          = "disabled"
        http_put_response_hop_limit = 2
        http_tokens                 = "required"
        instance_metadata_tags      = "disabled"
    }

    private_dns_name_options {
        enable_resource_name_dns_a_record    = true
        enable_resource_name_dns_aaaa_record = false
        hostname_type                        = "ip-name"
    }

    root_block_device {
        delete_on_termination = true
        device_name           = "/dev/xvda"
        encrypted             = false
        iops                  = 3000
        kms_key_id            = null
        tags                  = {}
        tags_all              = {}
        throughput            = 125
        volume_id             = "vol-01a1f5bf81fdb1689"
        volume_size           = 8
        volume_type           = "gp3"
		}
}








