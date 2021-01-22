# -----------------------------------------------------------------------------
# List PKI roles on pki/il5/p1_int engine
# -----------------------------------------------------------------------------
path "pki/il5/p1_int/roles" {
  capabilities = ["list", "read"]
}

# -----------------------------------------------------------------------------
# Issue certificates from the p1-leaf-cert PKI role
# -----------------------------------------------------------------------------
#path "pki/il5/p1_int/issue/p1-leaf-cert" {
#  capabilities = ["update"]

#  control_group = {
#    factor "authorizer" {
#      identity {
#        group_names = [ "il5-p1-int" ]
#        approvals   = 2
#      }
#    }
#  }
#}

# -----------------------------------------------------------------------------
# Sign CSRs with the p1-leaf-cert PKI role
# -----------------------------------------------------------------------------
path "pki/il5/p1_int/sign/p1-leaf-cert" {
  capabilities = ["update"]

  control_group = {
    factor "authorizer" {
      identity {
        group_names = [ "il5-p1-int" ]
        approvals   = 2
      }
    }
  }
}
