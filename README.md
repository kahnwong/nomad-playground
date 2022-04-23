# nomad-playground

## Install
```bash
brew tap hashicorp/tap
brew install hashicorp/tap/nomad
brew install hashicorp/tap/consul
```

## Usage
```bash
# Start Nomad agent
nomad agent -dev -dc "fringe-division" -bind 0.0.0.0 -log-level INFO # http://0.0.0.0:4646

# # Start Consul agent
# consul agent -data-dir=tmp/consul -dev # http://127.0.0.1:8500

# Run Nomad job
nomad job run example.nomad
```
