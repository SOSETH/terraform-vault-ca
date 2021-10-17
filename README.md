# Terraform Vault CA

This sets up an opinionated CA using vault's PKI support.
The CA has a hardcoded 100 year lifetime and uses 4096 bit RSA keys, issued certificates
are done using 384 bit ECC.

## Parameters (module)
|Var|Default value|Description|
|---|-------------|-----------|
|name|(unset, required)|Name of the CA|
|description|(unset, required)|Description of the CA (used in main mount)|
|default_lease|12 hours|Default time for a secret lease|
|maximum_lease|24 hours|Maximum time for a secret lease|
|crl_time|24 hours|Validity of a given CRL (beware of vault bug 3827!)| 
|pki_aia_basepath|`https://vault-pki.example.org`|Base path to use for CRL/AIA (see below)|

## Parameters (entity)
Each entity in vault wishing to request a certificate is expected to have the following metadata:
 * `hostname` should be set to the FQDN of the host - CN in the certificates is restricted to this
 * `san0` - `san3` should be set to any DNS SANs you might want to issue with that identity in addition to the hostname

Note: IP SANs are not checked - this is a vault limitation!

## AIA
Issued certificate will have their AIA set to `${pki_aia_basepath}/ca/${name}` and their CRL
to `${pki_aia_basepath}/crl/${name}`. For compatibility it is recommended to make sure these paths are
proxied to the vault server.

## Vault roles
`client`, `server` and `dual` are created - for client certificates, server certificates and certificates that can be
used for both roles. Matching policies are created as `ca-${name}-${type}`