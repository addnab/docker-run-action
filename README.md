# Docker Run Action

- run a specific step in docker.
- run an image built by a previous step.
- See https://github.com/addnab/docker-run-action/blob/main/action.yml for all the available inputs.

## Examples

#### Typical Use Case

```yaml
- name: Checkout 
  uses: actions/checkout@v2 # Required to mount the Github Workspace to a volume 
- uses: addnab/docker-run-action@v3
  with:
    username: ${{ secrets.DOCKER_USERNAME }}
    password: ${{ secrets.DOCKER_PASSWORD }}
    registry: gcr.io
    image: private-image:latest
    options: -v ${{ github.workspace }}:/work -e ABC=123
    run: |
      echo "Running Script"
      /work/run-script
```

#### run a privately-owned image
```yaml
- uses: addnab/docker-run-action@v3
  with:
    username: ${{ secrets.DOCKER_USERNAME }}
    password: ${{ secrets.DOCKER_PASSWORD }}
    registry: gcr.io
    image: test-image:latest
    run: echo "hello world"
```

#### run an image built by a previous step
```yaml
- uses: docker/build-push-action@v2
  with:
    tags: test-image:latest
    push: false
- uses: addnab/docker-run-action@v3
  with:
    image: test-image:latest
    run: echo "hello world"
```


#### use a specific shell (default: sh). 
*Note: The shell must be installed in the container*
```yaml
- uses: addnab/docker-run-action@v3
  with:
    image: docker:latest
    shell: bash
    run: |
      echo "first line"
      echo "second line"
```

#### Capture Output from a Docker Container

You can capture output from the container, using the `::set-output` [workflow command](https://docs.github.com/en/actions/learn-github-actions/workflow-commands-for-github-actions) in GitHub Actions.
Steps that execute following this step can access the output using the `${{ steps.<step_id>.outputs.<output_name> }}` syntax.
For more information, see the [Contexts documentation](https://docs.github.com/en/actions/learn-github-actions/contexts) for GitHub Actions.

```yaml
- uses: pcgeek86/docker-run-action@v4
  id: container_test
  with:
    image: mcr.microsoft.com/powershell
    run: |
      pwsh -EncodedCommand JABJAG4AcwB0AGEAbABsAGUAZABNAG8AZAB1AGwAZQBzACAAPQAgACgARwBlAHQALQBNAG8AZAB1AGwAZQAgAC0ATABpAHMAdABBAHYAYQBpAGwAYQBiAGwAZQApAC4ATgBhAG0AZQAgAC0AagBvAGkAbgAgACcALAAnAAoAJwA6ADoAcwBlAHQALQBvAHUAdABwAHUAdAAgAG4AYQBtAGUAPQBjAG8AbgB0AGEAaQBuAGUAcgBfAG8AdQB0AHAAdQB0ADoAOgB7ADAAfQAnACAALQBmACAAJABJAG4AcwB0AGEAbABsAGUAZABNAG8AZAB1AGwAZQBzAA==
- run: echo "Installed PowerShell modules are: ${{ steps.container_test.outputs.container_output }}"
```
