# Docker Run Action

Github Workflows already supports running on public docker images out-of-the-box (See [jobs.<jobs_id>.container](https://help.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idcontainer)).

### Why use docker-run-action?
- run on a privately-owned image.
- run on an image built by a previous step.
- run a specific step in docker

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

#### run on a privately-owned image
```yaml
- uses: addnab/docker-run-action@v1
  with:
    username: ${{ secrets.DOCKER_USERNAME }}
    password: ${{ secrets.DOCKER_PASSWORD }}
    registry: gcr.io
    image: test-image:latest
    run: echo "hello world"
```

#### run on an image built by a previous step
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
*Note: The shell must be installed in the container*
```yaml
- uses: addnab/docker-run-action@v1
  with:
    image: docker:latest
    shell: bash
    run: |
      echo "first line"
      echo "second line"
```
