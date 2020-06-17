# Docker Run Action

This action targets a very specific use-case that is not currently supported by Github Workflows. This action gives you the capability to run built containers.

Docker already supports running commands inside a docker image. See [jobs.<jobs_id>.container](https://help.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idcontainer). But it doesn't give you a clean way to run an image from a private repo or an image built on a previous step.

### Example Usage

#### Standard use-case
```yaml
- uses: addnab/docker-run-action@v1
  with:
    image: docker:latest
    command: echo "hello world"
```

### Supported Inputs
```yaml
  image:
    description: 'Image'
    required: true
  options:
    description: 'Options'
    required: false
  command:
    description: 'Command'
    required: false
  registry:
    description: 'Registry'
    required: false
  username:
    description: 'Username'
    required: false
  password:
    description: 'Password'
    required: false
```
