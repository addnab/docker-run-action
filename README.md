# Docker Run Action

This action targets a very specific use-case that is not currently supported by Github Workflows. This action gives you the capability to run built containers.

Docker already supports running commands inside a docker image. See [jobs.<jobs_id>.container](https://help.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idcontainer). But it doesn't give you a clean way to run an image from a private repo or an image built by a previous step.

### Example Usage

#### single-line command
```yaml
- uses: addnab/docker-run-action@v1
  with:
    image: docker:latest
    run: echo "hello world"
```

#### multi-line commands
```yaml
- uses: addnab/docker-run-action@v1
  with:
    image: docker:latest
    run: |
      echo "first line"
      echo "second line"
```

#### Run on previously built container. 
```yaml
- uses: docker/build-push-action@v1
  with:
    repository: test-image
    push: false
- uses: addnab/docker-run-action@v1
  with:
    image: test-image:latest
    run: echo "hello world"
```


#### use a specific shell (default: sh). 
*Note: The shell must be installe in the container*
```yaml
- uses: addnab/docker-run-action@v1
  with:
    image: docker:latest
    shell: bash
    run: |
      echo "first line"
      echo "second line"
```
