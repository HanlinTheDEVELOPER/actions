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
- a job is associated with a runner
  - Linux, Mac or Window VM
  - Github hosted or Self-hosted
  - Use runs-on attr to specify runner config
- can have one or more jobs in single workflow
  - Jobs in a workflow run parallelly so it will fail in case one jobs depand on others
    > e.g Test jobs and deploy jobs depends on result from build jobs

In that case we can use `needs:` attribute

```yml
name: Series Multiple Jobs
on: push
jobs:
  build_job_1:
    name: Build State
    runs-on: ubuntu-latest
    steps:
      - name: Install package
        run: sudo apt install cowsay -y

      - name: Generate build file
        run: cowsay -f dragon "I am fooking dragon.. Let's burn them all" >> dragon.txt

  test_job_2:
    needs: build_job_1
    name: Testing
    runs-on: ubuntu-latest
    steps:
      - name: Check if build exist
        run: sudo grep -i "dragon" dragon.txt

  deploy_job_3:
    needs: test_job_2
    name: Deployment
    runs-on: ubuntu-latest
    steps:
      - name: Running The Build
        run: cat dragon.txt
```

![Series Jobs Fails](/assets/series-jobs-fails.png)

As you can see in image jobs are run sequencially. If one of the preceding jobs fails, the subsequent jobs will automatically be skipped.
Okay, we have a fail job to debug. Let's do it.

> Below is the log i found by clicking on the fail job

![Check Build File Exist Fails](/assets/check-build-exist-fail.png)

We clearly generate that file in build state, right? Then why does it saying `No such file or directory`. Remeber, it's said in above that `a job is associated with a runner`. What is a runner? It's a virtual machine or something like that, right? So even if those three jobs are running one after another, they are still running on each machine.
Here's the time for `artifacts` to shine.

> #### What are Artifacts?
>
> Artifacts are files or datas that generate during a job on its associated runner. They can be used to `share data between jobs` and `store build or test output`. Normally, artifacts will be deleted after the job compeled.

So now we know the existance of `artifacts` to save your day. But how do we share them across jobs with respective runner. Don't worry. There is already a verified action for uploading artifacts from a job and downloading artifacts from others.

![Artifacts Action](/assets/artifact-actions.png)

Let's use them in our workflow.

```yml
name: Series Multiple Jobs
on: push
jobs:
  build_job_1:
    ...same as above
    steps:
      ...same as above
      - name: Upload Artifact #<<<upload-artifact
        uses: actions/upload-artifact@v4 #<<<prebuilt-action
        with:
          name: dragon.txt #<<<name/of/artifact
          path: dragon.txt #<<<path/to/artifact/file

  test_job_2:
    ...same as above
    steps:

      <!--
        In downloading case, we need to run this step first.
         Otherwise it will fail as there is no file when the test run
      --!>
      - name: Download Artifact #<<<download-artifact
        uses: actions/download-artifact@v4 #<<<prebuilt-action
        with:
          name: dragon.txt #<<<name/of/artifact
      # In this case we don't need to specify path as it will be downloaded to current directory
      ...same as above

  deploy_job_3:
   <!--
   This will be the same as test_job_2
   --!>
```

Now if you push the code again, you will see all workflows are completed successfully.Now check into the run workflow's summary. you will see the build file in the artifacts section. You can download it and check the content or delete if you want.By default, artifacts are stored for 90 days. You can change it in the settings.

### Steps

- Steps, individual task or actions that make up the jobs
- Multiple steps run sequencly in job's runner environment
- Command, action, scripts to automate specific task like test, build and deploy for CI/CD

#### Actions

Actions are pre-built components that provide reusable capability to perform specific task for various repository and workflows. They can be created by you, developers from community and organization for reusability across the repository. There are a ton of pre-built actions from checkouting code to deploy to cloud server of your choice. You can browse for various actions in [GitHub Marketplace](https://github.com/marketplace?type=actions). There are two kind of actions. The one from verified creators like Github itself. Those actions can be used with confidence. The other kinds is those from other creators. If you want to use those actions, **:warning: it's adivce that before you start using it you have to check its source code throughly yourself if they handle repository as it should be**
