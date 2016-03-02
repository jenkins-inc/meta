# Jenkins demo
This GitHub organization is for Jenkins, Inc., which is a hypothetical company that uses Jenkins.
We use this and http://demo.jenkins-ci.org/ to illustrate a best practice usage of Jenkins with
realistic data.

## Goals
* Highlight key parts of noteworthy features in Jenkins 2.0 through a functioning live Jenkins
  instance that people can experience just with a browser
* Eventually evolve into a permanent demo instance to show off various noteworthy features
  beyond initial 2.0 GA

## Key Ingredients
* A fictional company “Jenkins, Inc.” is introduced as users of the demo instance
* Justifiable Continuous Delivery pipeline that highlights the following
    * Organization folder
    * Multiple branches
    * Really concise Jenkinsfile in repos + actual definitions in global library
    * Staged deployment to multiple environments
    * Docker Integration
* Live & real-looking data so that people without the context can easily the applications & development processes that are being automated
* A web page to walk people through the demo with hyperlinks

## Setup
* A public "jenkins-inc" github org for the fictional Jenkins, Inc.
    * A handful of repos each containing Node.js hello world webapp
        * We label them “micro service components” to help people mentally picture what this company produces
        * Each repo will have [a one-line Jenkinsfile](https://github.com/jenkins-demo/borat/blob/dev/Jenkinsfile)
    * A release engineering repository that defines global-libs
        * And [Jenkinsfile to auto-deploy the change](https://github.com/jenkins-demo/release-engineering/blob/master/Jenkinsfile)
* [Jenkins instance](http://demo.jenkins-ci.org/)
    * Access restricted so that anonymous users can only read
* The pipeline setup for "micro service" (see [definition](https://github.com/jenkins-demo/release-engineering/blob/master/vars/microService.groovy))
    * Phase 1
        * Triggered by changes get committed by developers to the ‘dev’ branch
            * We’ll set up a job on ci.jenkins-ci.org to manufacture commits from developers by turning Twitter posts like [these](https://twitter.com/devops_borat) into commits.
        * The app gets deployed to the ‘dev’ environment on Heroku
        * Tests run, which is just “sleep 60”
            * To be improved later
        * The ‘dev’ branch gets merged into the ‘staging’ branch and pushed back into GitHub
    * Phase 2
        * Triggered by the merge commit from previous stage
        * The app gets deployed to the ‘staging’ environment on Heroku
        * Tests run, which is a longer “sleep 300”
        * The ‘staging’ branch gets merged into the ‘prod’ branch and pushed back into GitHub
    * Phase 3
        * Triggered by the merge commit from previous stage
        * The app gets deployed to the ‘prod’ environment on Heroku
        * Smoke tests run, which is “sleep 60”
    * (More linear staged pipeline was considered earlier but rejected as it won’t show off multiple branches)
* A freestyle project that has some job configuration to show off the tabbed configuration page
    * Building jenkinsci/jenkins so that it shows realistic incoming changes

