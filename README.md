# Githubs Actions

<details>
<summary>
 <a href="#components">Component</a>
</summary>
<ul>
<li><a href="#workflows">Workflows</a></li>
<li><a href="#jobs">Jobs</a></li>
<li><a href="#steps">Steps</a></li>
</ul>
</details>

[Action](#actions)

## Components

### Workflows
  - name : Name of the workflow, if it's not provided relative path will show on Github Actions tab
  - on : event and trigger like [push,folk,pr]

### Jobs 
  - building blocks of workflows
  - can have one or more jobs in single workflow
  - is associated with a runner
       - Linux, Mac or Window VM
       - Github hosted or Self-hosted
       -  use runs-on attr to specify runner config
### Steps
 - Steps, individual task or actions that make up the jobs
 - Multiple steps run sequencly in job's runner environment
 - Command, action, scripts to automate specific task like test, build and deploy for CI/CD


#### Actions
Actions are pre-built components that provide reusable capability to perform specific task for various repository and workflows. They can be created by you, developers from community and organization for reusability across the repository. There are a ton of pre-built actions from checkouting code to deploy to cloud server of your choice. You can browse for various actions in [GitHub Marketplace](https://github.com/marketplace?type=actions). 
