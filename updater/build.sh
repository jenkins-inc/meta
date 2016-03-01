#!/bin/bash -ex

# manufacture commits as a specific user
source authors/$(( $BUILD_NUMBER % 5 ))

for r in borat securitay;
do
  if [ -d $r ]; then
    pushd $r
      git pull origin
    popd
  else
    git clone git@github.com:jenkins-inc/$r.git
  fi

  msg=$(groovy "$@" update.groovy $(cat $r/account) $BUILD_NUMBER)
  echo "<html><body><h2>$msg</h2></body></html>" > $r/src/main/webapp/index.jsp
  pushd $r
    git diff --quiet || (
      git commit -a -m "$msg"
      git push origin
    )
  popd
done
