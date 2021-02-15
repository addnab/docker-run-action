# Docker Run Action

- run a privately-owned image.
- run an image built by a previous step.
- run a specific step in docker.
- See https://github.com/addnab/docker-run-action/blob/main/action.yml for all the available inputs.

#### Typical Use Case

```yaml
- uses: addnab/docker-run-action@v1
  with:
    username: ${{ secrets.DOCKER_USERNAME }}
    password: ${{ secrets.DOCKER_PASSWORD }}
    registry: gcr.io
    image: private-image:latest
    options: -v $GITHUB_WORKSPACE:/work -e ABC=123
    run: |
      echo "Running Script"
      /work/run-script
```

#### run a privately-owned image
```yaml
- uses: addnab/docker-run-action@v1
  with:
    username: ${{ secrets.DOCKER_USERNAME }}
    password: ${{ secrets.DOCKER_PASSWORD }}
    registry: gcr.io
    image: test-image:latest
    run: echo "hello world"
```

#### run an image built by a previous step
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
