#YT LMTY

This Lab creates a hub and spoke network using terraform. This creates everything needed to get the peering connections for both spoke networks to communicate with the hub network.

This walks through the first step in getting an azure hub and spoke network deploy in azure using terraform.  The hub and spoke network design is a design that's really recommended by azure to help consolidate and make management of resources a lot easier.

AZURE-HUB-AND-SPOKE

# Phase 1
Step 1: Install Terraform and set path if using Windows
Step 2: Create base Terraform files
Step 3: Create a resource group
Step 4: Create 3 different virtual networks, with a 1 subnet in each virtual network
Step 5: Deploy main.tf and validate via Azure Portal that the resources defined in the script were created


# Phase 2
Step 1: Create 3 virtual machines across each virtual network
Step 2: Create a peering connection between the azure hub network and spoke virtual networks
Step 3: Use the azure virtual machines to test connectivity between the azure hub and spoke network after we create a peering connection


# Phase 3

Step 1: Creating 2 Route Tables for both spoke networks
Step 2: Creating an azure firewall to allow transitive routing
Step 3: Defining azure firewall routes for internet and network traffic
Step 4: Creating user defined route table entries to define routes
Step 5: Forcing all internet Traffic out through the azure firewall.
Step 6: Create a temp NAT to allow rdp access from the internet. Once tested, delete ASAP as this is not best practice 