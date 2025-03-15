node_groups = [
  {
    desired_size    = 2,
    max_size        = 2,
    min_size        = 2,
    max_unavailable = 1,
    instance_types  = [ "t3.medium" ],
    capacity_type    = "ON_DEMAND"
  }
]

created_by         = "Ayrton Fidel"
application        = "uplinq"
cost_center        = "ND"
contact            = "ayrtonfidel9@gmail.com"
maintenance_window = "ND"
deletion_date      = "ND"
environment        = "prod"