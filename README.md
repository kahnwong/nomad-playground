# nomad-playground

## Install
```bash
brew tap hashicorp/tap
brew install hashicorp/tap/nomad
```

## Usage
```bash
# Start Nomad agent
nomad agent -dev -bind 0.0.0.0 -log-level INFO # http://0.0.0.0:4646
```
